import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/OnBoardingController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/data/datasource/static/static.dart';

class OBDots extends StatelessWidget {
  const OBDots({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) {
        final list = getOnBoardingList();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(list.length, (index) {
            final active = controller.currentPage == index;
            return AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              width: active ? 26 : 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: active
                    ? Appcolor.accentGold
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: .16),
              ),
            );
          }),
        );
      },
    );
  }
}
