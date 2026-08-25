import 'package:flutter/material.dart';
import 'package:oro/controller/admin/settings/adminsettingscontroller.dart';
import 'package:oro/core/constant/color.dart';

class AdminSettingsSection extends StatelessWidget {
  final AdminSettingsControllerImp controller;

  const AdminSettingsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Ajustes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SwitchListTile(
              value: controller.isNotificationEnabled ?? false,
              onChanged: (value) {
                controller.disableNotification();
              },
              title: const Text(
                "Push Notifications",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Receive notifications for orders and updates",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              activeThumbColor: Appcolor.forest,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
