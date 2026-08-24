import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/deliveryhomecontroller.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/view/widgets/delivery/deliverybottomnavigationbar.dart';

class DeliveryHome extends StatelessWidget {
  const DeliveryHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryHomeControllerImp());
    return GetBuilder<DeliveryHomeControllerImp>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: const DeliveryBottomNavigationBar(),
          extendBody: true,
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              alertExitApp();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: controller.listpages.elementAt(controller.currentpage),
            ),
          ),
        );
      },
    );
  }
}
