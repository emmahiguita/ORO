import 'package:flutter/material.dart';
import 'package:oro/controller/admin/orders/manageorderscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class ActionButtons extends StatelessWidget {
  final ManageOrdersControllerImp controller;
  final dynamic order;

  const ActionButtons({
    super.key,
    required this.controller,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    switch (order.orderStatus) {
      case 0: // Pending
        return Row(
          children: [
            Expanded(
              child: controller.loading == true
                  ? IgnorePointer(
                      ignoring: true,
                      child: OutlinedButton.icon(
                        label: const SizedBox(
                            height: 20,
                            child: GradientProgressIndicator(strokeWidth: 3)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Appcolor.berry,
                          side: const BorderSide(color: Appcolor.berry),
                        ),
                        onPressed: () {},
                      ),
                    )
                  : OutlinedButton.icon(
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text(
                        'Approve',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Appcolor.berry,
                        side: const BorderSide(color: Appcolor.berry),
                      ),
                      onPressed: () {
                        controller.approveOrder(
                            order.userId.toString(), order.orderId.toString());
                      },
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: controller.cLoading == true
                  ? IgnorePointer(
                      ignoring: true,
                      child: OutlinedButton.icon(
                        label: const SizedBox(
                            height: 20,
                            child: GradientProgressIndicator(strokeWidth: 3)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Appcolor.berry,
                          side: const BorderSide(color: Appcolor.berry),
                        ),
                        onPressed: () {},
                      ),
                    )
                  : OutlinedButton.icon(
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Appcolor.red,
                      ),
                      label: const Text(
                        'Cancelar',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Appcolor.red,
                        side: const BorderSide(color: Appcolor.red),
                      ),
                      onPressed: () {
                        controller.cancelOrder(
                            order.userId.toString(), order.orderId.toString());
                      },
                    ),
            ),
          ],
        );
      case 1: // On the way (for delivery)
        return SizedBox(
          width: double.infinity,
          child: controller.loading == true
              ? IgnorePointer(
                  ignoring: true,
                  child: OutlinedButton.icon(
                    label: const SizedBox(
                        height: 20,
                        child: GradientProgressIndicator(strokeWidth: 3)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Appcolor.berry,
                      side: const BorderSide(color: Appcolor.berry),
                    ),
                    onPressed: () {},
                  ),
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.done_all, size: 18),
                  label: const Text(
                    'Done Preparing',
                    style: TextStyle(color: Appcolor.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.berry,
                  ),
                  onPressed: () {
                    controller.finishPreparing(
                      order.userId.toString(),
                      order.orderId.toString(),
                      order.orderType,
                    );
                  },
                ),
        );
      case 4: // Ready for pickup
        return SizedBox(
          width: double.infinity,
          child: controller.loading == true
              ? IgnorePointer(
                  ignoring: true,
                  child: OutlinedButton.icon(
                    label: const SizedBox(
                        height: 20,
                        child: GradientProgressIndicator(strokeWidth: 3)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Appcolor.berry,
                      side: const BorderSide(color: Appcolor.berry),
                    ),
                    onPressed: () {},
                  ),
                )
              : ElevatedButton.icon(
                  icon: const Icon(
                    Icons.local_shipping,
                    size: 18,
                    color: Appcolor.white,
                  ),
                  label: const Text(
                    'Mark as Picked Up',
                    style: TextStyle(color: Appcolor.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.berry,
                  ),
                  onPressed: () {
                    controller.markAsPickedUp(
                        order.userId.toString(), order.orderId.toString());
                  },
                ),
        );
      case 5:
      case 3: // Archived
        return SizedBox(
          width: double.infinity,
          child: controller.loading == true
              ? IgnorePointer(
                  ignoring: true,
                  child: OutlinedButton.icon(
                    label: const SizedBox(
                        height: 20,
                        child: GradientProgressIndicator(strokeWidth: 3)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Appcolor.berry,
                      side: const BorderSide(color: Appcolor.berry),
                    ),
                    onPressed: () {},
                  ),
                )
              : OutlinedButton.icon(
                  icon: const Icon(Icons.archive, size: 18),
                  label: const Text(
                    'Archive',
                    style: TextStyle(color: Appcolor.berry),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[700]!),
                  ),
                  onPressed: () {
                    controller.archiveOrder(
                        order.userId.toString(), order.orderId.toString());
                  },
                ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
