import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/disablenotification.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/view/screens/address/viewaddress.dart';
import 'package:oro/view/screens/auth/login.dart';
import 'package:oro/view/screens/auth/verifycodesignup.dart';
import 'package:oro/view/screens/settings/updateaccountinformation.dart';
import 'package:oro/view/screens/settings/viewallrating.dart';
import 'package:oro/view/widgets/settings/language.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SettingController extends GetxController {
  logout();
  contactus(int type);
  goToAddress();
  disableNotification();
  changeLanguages();
  goToUpdateAccountInformation();
  goToAllRating();
  goToVerify();
}

class SettingControllerImp extends SettingController {
  final Services services = Get.find<Services>();
  static const supportPhone = String.fromEnvironment('SUPPORT_PHONE');
  String? username, email, pfp;
  bool? isApprove, isNotificationEnabled;

  @override
  void goToAddress() =>
      Get.to(() => const ViewAddress(), transition: Transition.cupertino);

  @override
  Future<void> logout() async {
    await services.unregisterPushToken();
    await services.clearAuthToken();
    final lang = services.sharedPreferences.getString('langcode') ?? 'es';
    await services.sharedPreferences.clear();
    await services.sharedPreferences.setString('langcode', lang);
    await services.sharedPreferences.setString('step', '1');
    Get.offAll(() => const Login(), transition: Transition.fadeIn);
  }

  @override
  Future<void> contactus(int type) async {
    if (supportPhone.isEmpty) {
      Get.snackbar('Contacto no configurado',
          'Define SUPPORT_PHONE antes de publicar la aplicación.');
      return;
    }
    final message = Uri.encodeComponent('Hola, necesito ayuda con mi compra.');
    final uri = type == 0
        ? Uri.parse('https://wa.me/$supportPhone?text=$message')
        : Uri.parse('sms:$supportPhone?body=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
          'No pudimos abrir la aplicación',
          type == 0
              ? 'WhatsApp no está disponible.'
              : 'La aplicación de mensajes no está disponible.');
    }
  }

  @override
  void onInit() {
    isNotificationEnabled =
        services.sharedPreferences.getBool('isNotificationEnabled') ?? false;
    username = services.sharedPreferences.getString('username');
    email = services.sharedPreferences.getString('email');
    pfp = services.sharedPreferences.getString('pfp');
    isApprove = services.sharedPreferences.getString('approve') == '1';
    super.onInit();
  }

  @override
  Future<void> disableNotification() async {
    if (services.firebaseReady) await disableNotifications();
    isNotificationEnabled =
        services.sharedPreferences.getBool('isNotificationEnabled') ?? false;
    update();
  }

  @override
  void changeLanguages() {
    Get.bottomSheet(
      Material(
        color: Theme.of(Get.context!).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context!).dividerColor,
                      borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 18),
              Row(children: [
                const Icon(Icons.language_rounded, color: Appcolor.accentGold),
                const SizedBox(width: 10),
                Text('2'.tr, style: Theme.of(Get.context!).textTheme.titleLarge)
              ]),
              const SizedBox(height: 16),
              ...buildLanguageOptions(),
            ]),
          ),
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  List<Widget> buildLanguageOptions() => [
        LanguageOption(
            code: 'es', name: 'Español', nativeName: 'Español', flag: ''),
        LanguageOption(
            code: 'en', name: 'Inglés', nativeName: 'English', flag: ''),
        LanguageOption(
            code: 'ar', name: 'Árabe', nativeName: 'العربية', flag: ''),
      ]
          .map((lang) => LanguageButton(
                language: lang,
                onPressed: () {
                  Get.find<Localecontroller>().changelocale(lang.code);
                  Get.back();
                },
              ))
          .toList();

  @override
  void goToUpdateAccountInformation() =>
      Get.to(() => const UpdateAccountInformation(),
          transition: Transition.cupertino);
  @override
  void goToAllRating() =>
      Get.to(() => const ViewAllRating(), transition: Transition.cupertino);
  @override
  void goToVerify() => Get.to(() => const VerifyCodeSignUp(),
      arguments: {'email': email, 'setting': true},
      transition: Transition.cupertino);
}
