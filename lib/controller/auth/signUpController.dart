import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/auth/signupdata.dart';
import 'package:oro/view/screens/auth/login.dart';
import 'package:oro/view/screens/auth/verifycodesignup.dart';

abstract class SignupController extends GetxController {
  signUp();
  showPassword();
  goToVerfiy();
  goToLogin();
}

class SignUpcontrollerImp extends SignupController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;
  final SignUpData signUpData = SignUpData(Get.find());
  final Services service = Get.find();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void showPassword() {
    obscureText = !obscureText;
    update();
  }

  @override
  Future<void> signUp() async {
    if (!(formkey.currentState?.validate() ?? false)) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await signUpData.postData(
      username.text.trim(),
      email.text.trim(),
      phoneNumber.text.trim(),
      password.text,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success' && response['data'] is Map) {
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
        service.sharedPreferences
            .setString('approve', '${data['user_approve'] ?? 0}');
        service.sharedPreferences.setString('key', '0');
        service.sharedPreferences.setString('step', '1');
        service.sharedPreferences
            .setBool('isNotificationEnabled', service.firebaseReady);
        goToVerfiy();
      } else {
        statusRequest = StatusRequest.failure;
        final status = '${response['status']}';
        final message = status == 'emailfail'
            ? 'Ese correo ya está registrado.'
            : status == 'userfail'
                ? 'Ese nombre de usuario ya está en uso.'
                : status == 'phonefail'
                    ? 'Ese número de teléfono ya está registrado.'
                    : 'No pudimos crear tu cuenta.';
        Get.defaultDialog(title: 'Revisa tus datos', middleText: message);
      }
    }
    update();
  }

  @override
  void goToLogin() => Get.offAll(
        () => const Login(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 450),
      );

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  void goToVerfiy() => Get.off(
        () => const VerifyCodeSignUp(),
        arguments: {'email': email.text.trim()},
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 450),
      );
}
