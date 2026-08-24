import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class DeliveryType extends StatelessWidget {
  final bool isDelivery;
  final bool isPickUp;
  final Function()? onTapPickUp;
  final Function()? onTapDelivery;
  const DeliveryType(
      {super.key,
      required this.isDelivery,
      required this.isPickUp,
      required this.onTapPickUp,
      required this.onTapDelivery});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Appcolor.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDelivery
                            ? Appcolor.deepPink
                            : Colors.grey.shade300,
                        width: isDelivery ? 1.5 : 1,
                      ),
                    ),
                    child: Material(
                      color: isDelivery
                          ? Appcolor.deepPink.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: onTapDelivery,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.delivery_dining,
                                size: 32,
                                color: isDelivery
                                    ? Appcolor.deepPink
                                    : Colors.grey.shade700,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Entrega",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDelivery
                                      ? Appcolor.deepPink
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            isPickUp ? Appcolor.deepPink : Colors.grey.shade300,
                        width: isPickUp ? 1.5 : 1,
                      ),
                    ),
                    child: Material(
                      color: isPickUp
                          ? Appcolor.deepPink.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: onTapPickUp,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.store,
                                size: 32,
                                color: isPickUp
                                    ? Appcolor.deepPink
                                    : Colors.grey.shade700,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Pick Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isPickUp
                                      ? Appcolor.deepPink
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
