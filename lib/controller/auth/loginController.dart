import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/auth/logindata.dart';
import 'package:oro/view/screens/admin/adminhome.dart';
import 'package:oro/view/screens/auth/signUp.dart';
import 'package:oro/view/screens/auth/verifycodesignup.dart';
import 'package:oro/view/screens/delivery/deliveryhome.dart';
import 'package:oro/view/screens/home/homescreen.dart';
import 'package:oro/view/screens/resetpassword/forgotpassword.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  showPassword();
  goToForgotPassword();
  Future<void> saveCachedData(var response);
  userHome();
  deliveryHome();
  adminHome();
  changeLoginRemember(bool value);
  Future<void> enterOfflineDemoMode([int role = 0]);
}

class LogincontrollerImp extends LoginController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;
  final Services service = Get.find();
  late TextEditingController username;
  late TextEditingController password;
  final LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  bool rememberMe = true;

  @override
  Future<void> login() async {
    if (!(formkey.currentState?.validate() ?? false)) return;
    statusRequest = StatusRequest.loding;
    update();
    final response =
        await loginData.postData(username.text.trim(), password.text);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success' && response['data'] is Map) {
        if (rememberMe) {
          service.sharedPreferences.setBool('remember_me', true);
          service.sharedPreferences
              .setString('saved_login_user', username.text.trim());
          service.sharedPreferences
              .setString('saved_login_pass', password.text);
        } else {
          service.sharedPreferences.setBool('remember_me', false);
          service.sharedPreferences.remove('saved_login_user');
          service.sharedPreferences.remove('saved_login_pass');
        }
        OfflineDataProvider.isOfflineMode = false;
        service.sharedPreferences.setBool('is_offline_mode', false);
        await saveCachedData(response);
        await service.syncPushToken();
        final role = int.tryParse('${response['data']['user_keyaccess']}') ?? 0;
        if (role == 1) {
          deliveryHome();
        } else if (role == 2) {
          adminHome();
        } else {
          userHome();
        }
        Get.find<Localecontroller>().geIsVerified();
      } else if (response['status'] == 'unverified' &&
          response['data'] is Map) {
        if (rememberMe) {
          service.sharedPreferences.setBool('remember_me', true);
          service.sharedPreferences
              .setString('saved_login_user', username.text.trim());
          service.sharedPreferences
              .setString('saved_login_pass', password.text);
        }
        final data = response['data'] as Map;
        service.sharedPreferences.setString('id', '${data['user_id']}');
        service.sharedPreferences
            .setString('username', '${data['user_name'] ?? ''}');
        service.sharedPreferences
            .setString('email', '${data['user_email'] ?? ''}');
        service.sharedPreferences
            .setString('phone', '${data['user_phone'] ?? ''}');
        service.sharedPreferences
            .setString('pfp', '${data['user_pfp'] ?? 'default.png'}');
        service.sharedPreferences
            .setString('banner', '${data['user_banner'] ?? 'default.png'}');
        service.sharedPreferences.setString('approve', '0');
        service.sharedPreferences.setString('key', '0');
        service.sharedPreferences.setString('step', '1');
        Get.to(
          () => const VerifyCodeSignUp(),
          arguments: {'email': '${data['user_email'] ?? ''}'},
          transition: Transition.rightToLeft,
        );
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: 'No pudimos iniciar sesión',
          middleText:
              'Verifica tu usuario o correo y contraseña e inténtalo de nuevo.',
        );
      }
    }
    update();
  }

  @override
  Future<void> saveCachedData(response) async {
    final data = response['data'] as Map;
    service.sharedPreferences.setString('id', '${data['user_id']}');
    service.sharedPreferences
        .setString('username', '${data['user_name'] ?? ''}');
    service.sharedPreferences.setString('email', '${data['user_email'] ?? ''}');
    service.sharedPreferences.setString('phone', '${data['user_phone'] ?? ''}');
    service.sharedPreferences
        .setString('pfp', '${data['user_pfp'] ?? 'default.png'}');
    service.sharedPreferences
        .setString('banner', '${data['user_banner'] ?? 'default.png'}');
    service.sharedPreferences
        .setString('key', '${data['user_keyaccess'] ?? 0}');
    service.sharedPreferences
        .setString('approve', '${data['user_approve'] ?? 0}');
    final token = response['token'];
    if (token is String && token.isNotEmpty) {
      await service.setAuthToken(token);
    }
    if (!service.sharedPreferences.containsKey('isNotificationEnabled')) {
      service.sharedPreferences
          .setBool('isNotificationEnabled', service.firebaseReady);
    }
  }

  @override
  void goToSignUp() => Get.off(
        () => const SignUp(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 450),
      );

  @override
  void goToForgotPassword() => Get.to(
        () => const ForgotPassword(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 450),
      );

  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    rememberMe = service.sharedPreferences.getBool('remember_me') ?? true;
    if (rememberMe) {
      username.text =
          service.sharedPreferences.getString('saved_login_user') ?? '';
      password.text =
          service.sharedPreferences.getString('saved_login_pass') ?? '';
    }
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  void showPassword() {
    obscureText = !obscureText;
    update();
  }

  @override
  void adminHome() {
    if (rememberMe) service.sharedPreferences.setString('step', '4');
    Get.off(() => const AdminHome(), transition: Transition.rightToLeft);
  }

  @override
  void deliveryHome() {
    if (rememberMe) service.sharedPreferences.setString('step', '3');
    Get.off(() => const DeliveryHome(), transition: Transition.rightToLeft);
  }

  @override
  void userHome() {
    if (rememberMe) service.sharedPreferences.setString('step', '2');
    Get.off(() => const HomeScreen(), transition: Transition.rightToLeft);
  }

  @override
  void changeLoginRemember(bool value) {
    rememberMe = value;
    service.sharedPreferences.setBool('remember_me', value);
    if (!value) {
      service.sharedPreferences.remove('saved_login_user');
      service.sharedPreferences.remove('saved_login_pass');
    }
    update();
  }

  @override
  Future<void> enterOfflineDemoMode([int role = 0]) async {
    OfflineDataProvider.isOfflineMode = true;
    service.sharedPreferences.setBool('is_offline_mode', true);
    final demoUser = {
      'status': 'success',
      'data': {
        'user_id': 1,
        'user_name': role == 2
            ? 'Administrador (Demo)'
            : role == 1
                ? 'Repartidor (Demo)'
                : 'Emmanuel (Modo Offline)',
        'user_email': role == 2
            ? 'admin@devemm.com'
            : role == 1
                ? 'delivery@devemm.com'
                : 'emmanuel@devemm.com',
        'user_phone': '+57 300 123 4567',
        'user_pfp': 'default.png',
        'user_banner': 'default.png',
        'user_approve': 1,
        'user_keyaccess': role,
      },
      'token': 'demo_offline_token_2026',
    };
    await saveCachedData(demoUser);
    if (role == 1) {
      deliveryHome();
    } else if (role == 2) {
      adminHome();
    } else {
      userHome();
    }
  }
}
