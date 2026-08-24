import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/OnBoardingController.dart';

class OBSkip extends GetView<OnBoardingControllerImp> {
  const OBSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: controller.skip,
      child: Text(
        '12'.tr,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: .58),
            ),
      ),
    );
  }
}
