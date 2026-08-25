import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/config/firebase_config.dart';
import 'package:oro/core/services/offline_data_provider.dart';

class Services extends GetxService {
  late SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool firebaseReady = false;
  String? authToken;
  StreamSubscription<String>? _tokenRefreshSubscription;

  Future<Services> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    OfflineDataProvider.isOfflineMode =
        sharedPreferences.getBool('is_offline_mode') ?? false;
    try {
      authToken = await secureStorage.read(key: 'authToken');
    } catch (_) {
      // No se usa SharedPreferences como fallback para credenciales.
      authToken = null;
    }

    final options = FirebaseConfig.options;
    if (options != null) {
      try {
        await Firebase.initializeApp(options: options);
        firebaseReady = true;
        _tokenRefreshSubscription =
            FirebaseMessaging.instance.onTokenRefresh.listen(
          (token) => _registerPushToken(token),
          onError: (_) {},
        );
        if (authToken != null) {
          await syncPushToken();
        }
      } catch (_) {
        firebaseReady = false;
      }
    }
    return this;
  }

  Future<void> setAuthToken(String token) async {
    authToken = token;
    try {
      await secureStorage.write(key: 'authToken', value: token);
    } catch (_) {
      // Queda solo en memoria: al reiniciar se exigirá login nuevamente.
    }
    if (firebaseReady) await syncPushToken();
  }

  Future<void> clearAuthToken() async {
    authToken = null;
    try {
      await secureStorage.delete(key: 'authToken');
    } catch (_) {}
  }

  String get _platformName {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform.name;
  }

  Future<void> syncPushToken() async {
    if (!firebaseReady || authToken == null || authToken!.isEmpty) return;
    if (sharedPreferences.getBool('isNotificationEnabled') == false) return;
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.denied) return;
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) await _registerPushToken(token);
    } catch (_) {}
  }

  Future<void> _registerPushToken(String deviceToken) async {
    final session = authToken;
    if (session == null || session.isEmpty || deviceToken.isEmpty) return;
    try {
      await http.post(
        Uri.parse(AppLink.registerDevice),
        headers: {'Authorization': 'Bearer $session'},
        body: {'token': deviceToken, 'platform': _platformName},
      ).timeout(const Duration(seconds: 15));
    } catch (_) {}
  }

  Future<void> unregisterPushToken() async {
    if (!firebaseReady || authToken == null || authToken!.isEmpty) return;
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null || token.isEmpty) return;
      await http.post(
        Uri.parse(AppLink.unregisterDevice),
        headers: {'Authorization': 'Bearer $authToken'},
        body: {'token': token},
      ).timeout(const Duration(seconds: 15));
    } catch (_) {}
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await sharedPreferences.setBool('isNotificationEnabled', enabled);
    if (enabled) {
      await syncPushToken();
    } else {
      await unregisterPushToken();
    }
  }

  @override
  void onClose() {
    _tokenRefreshSubscription?.cancel();
    super.onClose();
  }
}

Future<void> InitialServices() async {
  await Get.putAsync(() => Services().init());
}
