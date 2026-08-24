import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';

abstract class CreateNewDeliveryAccountController extends GetxController {
  createNewAccount();
}

class CreateNewDeliveryAccountControllerImp
    extends CreateNewDeliveryAccountController {
  GlobalKey<FormState> globalKey = GlobalKey();
  StatusRequest statusRequest = StatusRequest.none;
  AdminData adminData = AdminData(Get.find());

  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? phoneNumber;
  TextEditingController? password;

  bool get isLoading => statusRequest == StatusRequest.loding;

  bool? isPasswordHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden!;
    update();
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  createNewAccount() async {
    var fomrstate = globalKey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await adminData.createNewDeliveryAccount(
          username!.text, email!.text, phoneNumber!.text, password!.text);
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.back();
          Get.snackbar(
            "Éxito",
            "Cuenta creada con éxito",
            colorText: Appcolor.charcoalGray,
            backgroundColor: Appcolor.rosePompadour,
            icon: const Icon(Icons.check_circle),
          );
        } else {
          statusRequest = StatusRequest.failure;
          Get.defaultDialog(
              title: "warning!!",
              middleText: response["status"] == "emailfail"
                  ? "the email you entered is already in use please try logging in"
                  : response["status"] == "userfail"
                      ? "this username is already taken"
                      : "the phone number you ve entered already exists with another account");
        }
      }
      update();
    }
  }
}
