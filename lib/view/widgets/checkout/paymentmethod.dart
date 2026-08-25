import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class PaymentMethod extends StatelessWidget {
  final String paymentName;
  final String paymentImg;
  final int value;
  final int? groupValue;
  final void Function()? onTap;
  const PaymentMethod({
    super.key,
    required this.paymentName,
    required this.paymentImg,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Appcolor.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: value == groupValue
                  ? Appcolor.deepPink
                  : Colors.grey.shade300,
              width: value == groupValue ? 1.5 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(paymentImg),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    paymentName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  value == groupValue
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: value == groupValue
                      ? Appcolor.deepPink
                      : Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
