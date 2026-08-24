import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/view/widgets/locale/Button.dart';

List<Widget> lcList() {
  final controller = Get.find<Localecontroller>();
  return [
    LCButon(
      text: 'language_spanish'.tr,
      onPressed: () {
        controller.changelocale('es');
        Get.back();
      },
    ),
    LCButon(
      text: 'language_english'.tr,
      onPressed: () {
        controller.changelocale('en');
        Get.back();
      },
    ),
    LCButon(
      text: 'language_arabic'.tr,
      onPressed: () {
        controller.changelocale('ar');
        Get.back();
      },
    ),
    const SizedBox(height: 8),
  ];
}
