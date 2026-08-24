import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/view/widgets/delivery/deliverbutton.dart';
import 'package:oro/view/widgets/delivery/viewdetailsbutton.dart';

class OrderActionButtons extends StatelessWidget {
  final AcceptedOrdersControllerImp controller;
  final dynamic order;
  final int index;

  const OrderActionButtons({
    super.key,
    required this.controller,
    required this.order,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Details Button
        Expanded(
          child: ViewDetailsButton(
            onPressed: () =>
                controller.goToOrderDetails(order.orderId.toString(), index),
          ),
        ),
        const SizedBox(width: 12),
        // Deliver Button
        Expanded(
          child: DeliverButton(
            loading: controller.loading,
            onPressed: controller.loading
                ? null
                : () {
                    controller.markAsDelivered(
                      order.orderUserid.toString(),
                      order.orderId.toString(),
                    );
                  },
          ),
        ),
      ],
    );
  }
}
