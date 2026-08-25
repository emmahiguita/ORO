import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/OnBoardingController.dart';
import 'package:oro/data/datasource/static/static.dart';

class OBSlider extends GetView<OnBoardingControllerImp> {
  const OBSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingList = getOnBoardingList();
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(
              onBoardingList[index].title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              onBoardingList[index].image,
              height: 350,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(onBoardingList[index].content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            )
          ],
        );
      },
    );
  }
}
