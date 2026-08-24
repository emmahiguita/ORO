import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/inforow.dart';

class CustomerInfoSection extends StatelessWidget {
  final dynamic order;

  const CustomerInfoSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.person_outline,
            text: order.userName ?? 'N/A',
            maxLines: 1,
            iconColor: Appcolor.berry,
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.phone_outlined,
            text: order.userPhone ?? 'N/A',
            maxLines: 1,
            iconColor: Colors.green[600]!,
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.location_on_outlined,
            text: order.addressBymap ?? 'N/A',
            maxLines: 2,
            iconColor: Colors.red[500]!,
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.access_time_outlined,
            text: order.addressDeliverytime ?? 'N/A',
            maxLines: 1,
            iconColor: Colors.orange[600]!,
          ),
        ],
      ),
    );
  }
}
