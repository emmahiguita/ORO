import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/category/admincategorycontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/addimage.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';

abstract class AddCategoryController extends GetxController {
  addCategory();
}

class AddCategoryControllerImp extends AddCategoryController {
  TextEditingController? categoryName;
  TextEditingController? categoryNameAr;
  TextEditingController? categoryNameEs;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  AdminData adminData = AdminData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  File? image;

  getImage() async {
    image = await uploadImage();
    update();
  }

  @override
  addCategory() async {
    if (!formstate.currentState!.validate()) {
      return;
    }
    if (image == null) {
      Get.snackbar(
        "Image",
        "Please add image",
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.error),
      );
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    var response = await adminData.addCategory(
      categoryName!.text,
      categoryNameAr!.text,
      categoryNameEs!.text,
      image!,
    );
    statusRequest = handlingdata(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.find<AdminCategoryControllerImp>().getCategories();
        Get.back();
        Get.snackbar(
          "Éxito",
          "Category added successfully",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    categoryName = TextEditingController();
    categoryNameAr = TextEditingController();
    categoryNameEs = TextEditingController();
    super.onInit();
  }
}
