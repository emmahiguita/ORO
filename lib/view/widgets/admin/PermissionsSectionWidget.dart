import 'package:flutter/material.dart';
import 'package:oro/view/widgets/admin/PermissionItemWidget.dart';

class PermissionsSectionWidget extends StatelessWidget {
  const PermissionsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Text(
            'Administrator Permissions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This account will have access to:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          const PermissionItemWidget(
            icon: Icons.dashboard,
            title: 'Full Dashboard Access',
            description: 'View all analytics and reports',
          ),
          const PermissionItemWidget(
            icon: Icons.inventory,
            title: 'Product Management',
            description: 'Add, edit, and delete products',
          ),
          const PermissionItemWidget(
            icon: Icons.people,
            title: 'User Management',
            description: 'Manage customer and delivery accounts',
          ),
          const PermissionItemWidget(
            icon: Icons.receipt_long,
            title: 'Order Management',
            description: 'View and process all orders',
          ),
          const PermissionItemWidget(
            icon: Icons.settings,
            title: 'System Settings',
            description: 'Configure app settings and preferences',
          ),
        ],
      ),
    );
  }
}
