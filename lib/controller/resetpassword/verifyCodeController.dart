import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/resetpassword/verifycodepass.dart';
import 'package:oro/view/screens/resetpassword/resetpassword.dart';

abstract class VerifyCodeController extends GetxController {
  verifyCode(String code);
  resendCode();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  String? email;
  VerifyCodePassData verifyCodePassData = VerifyCodePassData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  verifyCode(code) async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await verifyCodePassData.postData(email!, code);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        // data.addAll(response['data']);
        Get.to(() => const RestPassword(),
            arguments: {"email": email, "code": code},
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 800));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "warning!!",
            middleText: "the email you entered isn't connected to an account.");
      }
    }
    update();
  }

  @override
  resendCode() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await verifyCodePassData.resendCode(email!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Verification code resent successfully.",
          "Please check your email for the new code",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.email_rounded),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "Failed to resend verification code.",
            middleText: "Something went wrong. Please try again later.");
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }
}
