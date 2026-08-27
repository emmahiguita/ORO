import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class CartItem extends StatelessWidget {
  final String img;
  final String itemName;
  final String itemCategory;
  final String itemPrice;
  final String itemCount;
  final Function()? onAdd;
  final Function()? onRemove;

  const CartItem({
    super.key,
    required this.img,
    required this.itemName,
    required this.itemCategory,
    required this.itemPrice,
    required this.itemCount,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0F2030)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: OroColors.accentGold.withValues(alpha: isDark ? 0.50 : 0.65),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: OroColors.accentGold.withValues(alpha: isDark ? 0.12 : 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 84,
            width: 84,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black26
                  : const Color(0xFFF9F7F2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: OroProductImage(
                imageUrl: img,
                productName: itemName,
                categoryName: itemCategory,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (itemCategory.trim().isNotEmpty)
                  Text(
                    itemCategory.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: OroColors.turquoise,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  itemName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    height: 1.2,
                    color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  itemPrice,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w900,
                    color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Control de Cantidad Elegante con Oro y Esmeralda
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF152A3C)
                  : const Color(0xFFF3EFE6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: 0.40),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      await OroMotion.selectionHaptic();
                      onRemove?.call();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.remove_rounded,
                        size: 16,
                        color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    itemCount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: OroColors.accentGold,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      await OroMotion.selectionHaptic();
                      onAdd?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        gradient: OroColors.emeraldGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

