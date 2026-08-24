import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/resetpassword/resetpassword.dart';
import 'package:oro/view/screens/home/home.dart';

abstract class RestPasswordController extends GetxController {
  restPassword();
  showPassword();
  showPassword2();
}

class RestPasswordControllerImp extends RestPasswordController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController password;
  late TextEditingController repassword;
  bool obscureText = true;
  bool obscureText2 = true;
  StatusRequest statusRequest = StatusRequest.none;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  String? email;
  String? code;
  Services service = Get.find();

  @override
  showPassword() {
    obscureText = !obscureText;
    update();
  }

  @override
  showPassword2() {
    obscureText2 = !obscureText2;
    update();
  }

  @override
  restPassword() async {
    var fomrstate = formkey.currentState;
    if (password.text == repassword.text) {
      if (fomrstate!.validate()) {
        statusRequest = StatusRequest.loding;
        update();
        var response =
            await resetPasswordData.postData(email!, password.text, code!);
        statusRequest = handlingdata(response);
        if (statusRequest == StatusRequest.success) {
          if (response["status"] == "success") {
            service.sharedPreferences
                .setString("id", response["data"]["user_id"].toString());
            service.sharedPreferences
                .setString("username", response["data"]["user_name"]);
            service.sharedPreferences
                .setString("email", response["data"]["user_email"]);
            service.sharedPreferences
                .setString("phone", response["data"]["user_phone"]);
            service.sharedPreferences.setString("step", "2");
            Get.to(() => const Home(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 800));
          } else if (response["status"] == "failure") {
            statusRequest = StatusRequest.failure;
          }
        }
        update();
      } else {}
    } else {
      Get.defaultDialog(
          title: "warning!!",
          middleText: "the passwords you entered did not match.");
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    email = Get.arguments["email"];
    code = Get.arguments["code"];

    super.onInit();
  }

  @override
  void dispose() {
    repassword.dispose();
    password.dispose();
    super.dispose();
  }
}
