import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/adminsettingscontroller.dart';
import 'package:oro/view/widgets/admin/adminactionbutton.dart';

class AdminActionButtonsSection extends StatelessWidget {
  const AdminActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Management',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          AdminActionButton(
            icon: Icons.delivery_dining,
            title: "Create New Delivery Account",
            subtitle: "Add new delivery personnel",
            onTap: () {
              Get.find<AdminSettingsControllerImp>()
                  .goToCreateNewDeliveryAccount();
            },
          ),
          const SizedBox(height: 12),
          AdminActionButton(
            icon: Icons.admin_panel_settings,
            title: "Create New Admin Account",
            subtitle: "Add new administrator",
            onTap: () {
              Get.find<AdminSettingsControllerImp>()
                  .goToCreateNewAdminAccount();
            },
          ),
          const SizedBox(height: 12),
          AdminActionButton(
            icon: Icons.edit_outlined,
            title: "Edit Account Info",
            subtitle: "Update your profile information",
            onTap: () {
              Get.find<AdminSettingsControllerImp>()
                  .goToUpdateAccountInformation();
            },
          ),
        ],
      ),
    );
  }
}
