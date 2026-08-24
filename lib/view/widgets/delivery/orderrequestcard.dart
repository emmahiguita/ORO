import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/view/widgets/delivery/orderrequestactionbuttons.dart';
import 'package:oro/view/widgets/delivery/orderrequestheader.dart';
import 'package:oro/view/widgets/delivery/orderrequestinfo.dart';
import 'package:oro/view/widgets/delivery/orderrequestpricesection.dart';

class OrderRequestCard extends StatelessWidget {
  final DeliveryRequestsControllerImp controller;
  final int index;

  const OrderRequestCard({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final order = controller.undeliveredOrders[index];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderRequestHeader(
              order: order,
              controller: controller,
            ),
            const SizedBox(height: 16),
            OrderRequestInfo(order: order),
            const SizedBox(height: 20),
            OrderRequestPriceSection(order: order),
            const SizedBox(height: 20),
            OrderRequestActionButtons(
              controller: controller,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
