import 'package:flutter/material.dart';
import 'package:oro/view/widgets/delivery/inforowwidget.dart';

class OrderRequestInfo extends StatelessWidget {
  final dynamic order;

  const OrderRequestInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoRowWidget(
          icon: Icons.person_outline,
          label: 'Customer',
          value: order.userName ?? 'N/A',
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        InfoRowWidget(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: order.userPhone ?? 'N/A',
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        InfoRowWidget(
          icon: Icons.location_on_outlined,
          label: 'Address',
          value: order.addressBymap ?? 'N/A',
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        InfoRowWidget(
          icon: Icons.schedule_outlined,
          label: 'Delivery Time',
          value: order.addressDeliverytime ?? 'N/A',
          maxLines: 1,
        ),
      ],
    );
  }
}
