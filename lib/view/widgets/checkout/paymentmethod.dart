import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(18),
      color: theme.colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: value == groupValue
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
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
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: .35),
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
