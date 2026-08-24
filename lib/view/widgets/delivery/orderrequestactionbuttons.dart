import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/view/widgets/delivery/acceptorderbutton.dart';
import 'package:oro/view/widgets/delivery/viewdetailsbutton.dart';

class OrderRequestActionButtons extends StatelessWidget {
  final DeliveryRequestsControllerImp controller;
  final int index;

  const OrderRequestActionButtons({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final order = controller.undeliveredOrders[index];

    return Row(
      children: [
        Expanded(
          child: ViewDetailsButton(
            onPressed: () {
              controller.goToOrderDetails(
                order.orderId.toString(),
                index,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AcceptOrderButton(
            loading: controller.loading,
            onPressed: controller.loading
                ? null
                : () {
                    controller.acceptorder(
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
