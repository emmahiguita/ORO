import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/view/widgets/delivery/paymenttypebadge.dart';

class OrderRequestHeader extends StatelessWidget {
  final dynamic order;
  final DeliveryRequestsControllerImp controller;

  const OrderRequestHeader({
    super.key,
    required this.order,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${order.orderId}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                Jiffy.parse(order.orderDatetime ?? '').fromNow(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        PaymentTypeBadge(
          paymentType: controller.getPaymentType(order.orderPaymenttype!),
        ),
      ],
    );
  }
}
