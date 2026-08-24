import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/ordercard.dart';

class DeliveryList extends StatelessWidget {
  final AcceptedOrdersControllerImp controller;

  const DeliveryList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.getAcceptedOrders(),
      color: Appcolor.berry,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: controller.acceptedOrders.length,
        itemBuilder: (context, index) => OrderCard(
          controller: controller,
          index: index,
        ),
      ),
    );
  }
}
