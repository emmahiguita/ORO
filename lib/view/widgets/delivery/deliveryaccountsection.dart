import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliverysettingscontroller.dart';
import 'package:oro/view/widgets/delivery/deliverydivider.dart';
import 'package:oro/view/widgets/delivery/deliverymenuitem.dart';

class DeliveryAccountSection extends StatelessWidget {
  final DeliverySettingsControllerImp controller;

  const DeliveryAccountSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Cuenta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          DeliveryMenuItem(
            icon: Icons.history,
            iconColor: Colors.orange,
            title: 'Delivery History',
            subtitle: 'View completed orders',
            onTap: () => controller.goToDeliveredOrders(),
          ),
          const DeliveryDivider(),
          DeliveryMenuItem(
            icon: Icons.edit_outlined,
            iconColor: Colors.green,
            title: 'Edit Profile',
            subtitle: 'Update account information',
            onTap: () => controller.goToUpdateAccountInformation(),
          ),
        ],
      ),
    );
  }
}
