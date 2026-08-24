import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/view/widgets/admin/adminlogoutdialogwidget.dart';
import 'package:oro/view/widgets/admin/adminmenuitemwidget.dart';

class AdminDrawerFooterWidget extends StatelessWidget {
  final AdminHomeControllerImp controller;

  const AdminDrawerFooterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: AdminMenuItemWidget(
        icon: Iconsax.logout,
        title: 'Logout',
        textColor: Colors.red[600]!,
        iconColor: Colors.red[600]!,
        onTap: () {
          _showLogoutDialog(context);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AdminLogoutDialogWidget(controller: controller),
    );
  }
}
