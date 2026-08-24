import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/core/constant/color.dart';

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeControllerImp>(
      builder: (controller) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentpage < 6 ? controller.currentpage : 0,
          onTap: controller.changePage,
          selectedItemColor:
              controller.currentpage < 6 ? Appcolor.berry : Colors.grey[600],
          unselectedItemColor: Colors.grey[600],
          selectedFontSize: controller.currentpage < 6 ? 14 : 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: List.generate(
            6,
            (index) => BottomNavigationBarItem(
              icon: Icon(controller.iconpages[index]),
              label: controller.namepages[index],
            ),
          ),
        );
      },
    );
  }
}
