import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliverysettingscontroller.dart';
import 'package:oro/core/constant/color.dart';

class DeliveryLogoutButton extends StatelessWidget {
  final DeliverySettingsControllerImp controller;

  const DeliveryLogoutButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.logout(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.berry,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Cerrar sesión',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
