import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/view/screens/cart/cart.dart';
import 'package:oro/view/widgets/home/custombottomnavigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          floatingActionButton: Tooltip(
            message: 'open_cart'.tr,
            child: FloatingActionButton(
              elevation: 6,
              onPressed: () {
                Get.to(
                  () => const Cart(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 340),
                );
              },
              child: const Icon(Icons.shopping_bag_outlined, size: 24),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomNavigationBar(),
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              alertExitApp();
            },
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.listpages,
            ),
          ),
        );
      },
    );
  }
}
