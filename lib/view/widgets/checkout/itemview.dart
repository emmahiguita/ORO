import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class ItemView extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final String itemprice;
  final String itmeQuantity;

  const ItemView({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.itemprice,
    required this.itmeQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final priceVal = double.tryParse(itemprice) ?? 0.0;

    return Container(
      width: 145,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? OroColors.nightBlue.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? OroColors.borderDark : OroColors.borderLight,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Imagen del producto
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: isDark ? const Color(0xFF0F1A24) : const Color(0xFFF7F8FA),
                width: double.infinity,
                child: OroProductImage(
                  imageUrl: itemImage,
                  productName: itemName,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // 2. Nombre del producto
          Text(
            itemName,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),

          // 3. Precio y Cantidad en Español
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  OroMoney.format(priceVal),
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: OroColors.accentGold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.10)
                      : Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'x$itmeQuantity',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? OroColors.turquoise
                        : OroColors.waterBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
