import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/adminsettingscontroller.dart';
import 'package:oro/view/widgets/admin/adminactionbuttonssection.dart';
import 'package:oro/view/widgets/admin/adminheadersection.dart';
import 'package:oro/view/widgets/admin/adminsettingssection.dart';
import 'package:oro/view/widgets/admin/adminuserinfocard.dart';

class AdminSetting extends StatelessWidget {
  const AdminSetting({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminSettingsControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: GetBuilder<AdminSettingsControllerImp>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                // Header Section with Banner and Profile
                AdminHeaderSection(controller: controller),

                const SizedBox(height: 20),

                // User Info Card
                AdminUserInfoCard(controller: controller),

                const SizedBox(height: 20),

                // Settings Section
                AdminSettingsSection(controller: controller),

                const SizedBox(height: 20),

                // Action Buttons Section
                const AdminActionButtonsSection(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
