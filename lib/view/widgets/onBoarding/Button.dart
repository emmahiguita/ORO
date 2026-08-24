import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/OnBoardingController.dart';

class OBButton extends GetView<OnBoardingControllerImp> {
  const OBButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: controller.next,
        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
        label: Text('11'.tr),
      ),
    );
  }
}
