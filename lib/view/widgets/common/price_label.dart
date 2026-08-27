import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';

class PriceLabel extends StatelessWidget {
  final double currentPrice;
  final double originalPrice;
  final int discount;

  const PriceLabel({
    super.key,
    required this.currentPrice,
    required this.originalPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            OroMoney.format(currentPrice),
            maxLines: 1,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
              color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
            ),
          ),
        ),
        if (discount > 0 && originalPrice > currentPrice) ...[
          const SizedBox(height: 1),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              OroMoney.format(originalPrice),
              maxLines: 1,
              style: TextStyle(
                fontSize: 10,
                decoration: TextDecoration.lineThrough,
                color: isDark
                    ? OroColors.textMutedDark
                    : OroColors.textMutedLight,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
