import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/view/widgets/admin/adminbottomnavigationbar.dart';
import 'package:oro/view/widgets/admin/admindrawer.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeControllerImp());
    return GetBuilder<AdminHomeControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          drawer: const AdminDrawer(),
          bottomNavigationBar: const AdminBottomNavigationBar(),
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
