import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/OnBoardingController.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/view/widgets/locale/Appbar.dart';
import 'package:oro/view/widgets/onBoarding/Button.dart';
import 'package:oro/view/widgets/onBoarding/Dots.dart';
import 'package:oro/view/widgets/onBoarding/Skip.dart';
import 'package:oro/view/widgets/onBoarding/Slider.dart';

class OnBoarding extends GetView<Localecontroller> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      appBar: const LCAppBar(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => alertExitApp(),
        child: const SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 18),
            child: Column(
              children: [
                Expanded(flex: 5, child: OBSlider()),
                SizedBox(height: 10),
                OBDots(),
                SizedBox(height: 24),
                OBButton(),
                SizedBox(height: 8),
                OBSkip(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
