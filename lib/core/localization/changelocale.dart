import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/functions/notificationconfiguration.dart';
import 'package:oro/core/services/services.dart';

class Localecontroller extends GetxController {
  late Locale languge;
  final Services service = Get.find();

  void changelocale(String langcode) {
    final locale = Locale(langcode);
    languge = locale;
    service.sharedPreferences.setString('langcode', langcode);
    Get.updateLocale(locale);
    update();
  }

  bool geIsVerified() {
    return service.sharedPreferences.getString('approve') == '0';
  }

  @override
  void onInit() {
    final saved = service.sharedPreferences.getString('langcode');
    if (saved == 'es') {
      languge = const Locale('es');
    } else if (saved == 'ar' || saved == 'en') {
      languge = Locale(saved!);
    } else {
      languge = const Locale('es');
      service.sharedPreferences.setString('langcode', 'es');
    }

    if (service.firebaseReady) {
      notificationConfiguration();
      notificationListen();
    }
    super.onInit();
  }
}
