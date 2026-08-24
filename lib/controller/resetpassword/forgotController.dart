import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/resetpassword/checkemail.dart';
import 'package:oro/view/screens/resetpassword/verifycode.dart';

abstract class ForgotPasswordcontroller extends GetxController {
  forgotPassword();
}

class ForgotPasswordcontrollerImp extends ForgotPasswordcontroller {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  CheckEmailData checkEmailData = CheckEmailData(Get.find());
  late TextEditingController email;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  forgotPassword() async {
    var fomrstate = formkey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await checkEmailData.postData(email.text);
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          // data.addAll(response['data']);
          Get.to(() => const VerifyCode(),
              arguments: {"email": email.text},
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 800));
        } else if (response["status"] == "failure") {
          statusRequest = StatusRequest.failure;
          Get.defaultDialog(
              title: "warning!!",
              middleText:
                  "the email you entered isn't connected to an account.");
        }
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
