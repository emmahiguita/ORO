import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/design/oro_colors.dart';
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
          floatingActionButton: FloatingActionButton(
            elevation: 8,
            tooltip: 'open_cart'.tr,
            backgroundColor: OroColors.forest,
            foregroundColor: Colors.white,
            onPressed: () {
              Get.to(
                () => const Cart(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: const Icon(Icons.shopping_bag_outlined, size: 24),
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
