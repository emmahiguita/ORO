import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/orderrequestcard.dart';

class DeliveryRequestsList extends StatelessWidget {
  final DeliveryRequestsControllerImp controller;

  const DeliveryRequestsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.getUndeliveredOrders(),
      color: Appcolor.berry,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: controller.undeliveredOrders.length,
        itemBuilder: (context, index) => OrderRequestCard(
          controller: controller,
          index: index,
        ),
      ),
    );
  }
}
