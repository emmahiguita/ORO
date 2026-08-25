import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/static/static.dart';
import 'package:oro/view/screens/auth/login.dart';

abstract class OnBoardinggController extends GetxController {
  next();
  onPageChanged(int index);
  skip();
}

class OnBoardingControllerImp extends OnBoardinggController {
  final onBoardingList = getOnBoardingList();
  late PageController pageController;
  int currentPage = 0;
  Services services = Get.find();

  @override
  next() {
    if (currentPage >= onBoardingList.length - 1) {
      services.sharedPreferences.setString("step", "1");
      Get.offAll(() => const Login(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 800));
    } else {
      pageController.animateToPage(currentPage + 1,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeIn);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  skip() {
    pageController.animateToPage(onBoardingList.length - 1,
        duration: const Duration(milliseconds: 900), curve: Curves.easeIn);
  }
}
