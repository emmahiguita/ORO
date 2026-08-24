import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/auth/verifycodedata.dart';
import 'package:oro/view/screens/home/homescreen.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode(String verify);
  resendCode({bool disableSnackbar = false});
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  String? email;
  bool isFromSetting = false;
  StatusRequest statusRequest = StatusRequest.none;
  final VerifycodeData verifycodeData = VerifycodeData(Get.find());
  final Services services = Get.find();

  @override
  Future<void> checkCode(String verify) async {
    if (email == null || verify.trim().isEmpty) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await verifycodeData.postData(email!, verify.trim());
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success') {
        services.sharedPreferences.setString('approve', '1');
        final token = response['token'];
        if (token is String && token.isNotEmpty) {
          await services.setAuthToken(token);
        }
        if (response['data'] is Map) {
          final data = response['data'] as Map;
          services.sharedPreferences.setString('id', '${data['user_id']}');
          services.sharedPreferences
              .setString('username', '${data['user_name'] ?? ''}');
          services.sharedPreferences
              .setString('email', '${data['user_email'] ?? ''}');
          services.sharedPreferences
              .setString('phone', '${data['user_phone'] ?? ''}');
          services.sharedPreferences
              .setString('pfp', '${data['user_pfp'] ?? 'default.png'}');
          services.sharedPreferences
              .setString('banner', '${data['user_banner'] ?? 'default.png'}');
          services.sharedPreferences
              .setString('key', '${data['user_keyaccess'] ?? 0}');
        }
        await services.syncPushToken();
        services.sharedPreferences.setString('step', '2');
        Get.find<Localecontroller>().geIsVerified();
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 450),
        );
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: 'Código incorrecto',
          middleText:
              'Revisa el código de confirmación e inténtalo nuevamente.',
        );
      }
    }
    update();
  }

  @override
  Future<void> resendCode({bool disableSnackbar = false}) async {
    if (email == null) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await verifycodeData.resendCode(email!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success') {
        if (!disableSnackbar) {
          Get.snackbar(
            'Código reenviado',
            'Revisa tu correo para consultar el nuevo código.',
            colorText: Appcolor.ink,
            backgroundColor: Appcolor.surface,
            icon: const Icon(Icons.email_rounded),
          );
        }
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: 'No pudimos reenviar el código',
          middleText: 'Inténtalo nuevamente en unos minutos.',
        );
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments?['email'] as String?;
    isFromSetting = Get.arguments?['setting'] == true;
    if (isFromSetting) resendCode(disableSnackbar: true);
    super.onInit();
  }
}
