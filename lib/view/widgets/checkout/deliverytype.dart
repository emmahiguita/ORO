import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class DeliveryType extends StatelessWidget {
  final bool isDelivery;
  final bool isPickUp;
  final Function()? onTapPickUp;
  final Function()? onTapDelivery;

  const DeliveryType({
    super.key,
    required this.isDelivery,
    required this.isPickUp,
    required this.onTapPickUp,
    required this.onTapDelivery,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // 1. Envío a Domicilio
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              await OroMotion.selectionHaptic();
              onTapDelivery?.call();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDelivery
                    ? (isDark
                        ? const Color(0xFF142B3B)
                        : const Color(0xFFFAF6EE))
                    : (isDark
                        ? OroColors.nightBlue.withValues(alpha: 0.60)
                        : Colors.white.withValues(alpha: 0.80)),
                border: Border.all(
                  color: isDelivery
                      ? OroColors.accentGold
                      : (isDark
                          ? OroColors.borderDark
                          : OroColors.borderLight),
                  width: isDelivery ? 1.6 : 1.0,
                ),
                boxShadow: isDelivery
                    ? [
                        BoxShadow(
                          color: OroColors.accentGold.withValues(alpha: 0.22),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDelivery
                          ? OroColors.accentGold.withValues(alpha: 0.15)
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.04)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.local_shipping_rounded,
                      size: 24,
                      color: isDelivery
                          ? OroColors.accentGold
                          : (isDark
                              ? OroColors.crystalWhite.withValues(alpha: 0.50)
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Envío a Domicilio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight:
                          isDelivery ? FontWeight.w900 : FontWeight.w700,
                      fontSize: 12.5,
                      color: isDelivery
                          ? (isDark
                              ? OroColors.crystalWhite
                              : OroColors.nightBlue)
                          : (isDark
                              ? OroColors.crystalWhite.withValues(alpha: 0.65)
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Entrega asegurada",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isDelivery
                          ? (isDark
                              ? OroColors.turquoise
                              : OroColors.waterBlue)
                          : (isDark
                              ? OroColors.textSecondaryDark
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // 2. Recogida en Boutique
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              await OroMotion.selectionHaptic();
              onTapPickUp?.call();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isPickUp
                    ? (isDark
                        ? const Color(0xFF142B3B)
                        : const Color(0xFFFAF6EE))
                    : (isDark
                        ? OroColors.nightBlue.withValues(alpha: 0.60)
                        : Colors.white.withValues(alpha: 0.80)),
                border: Border.all(
                  color: isPickUp
                      ? OroColors.accentGold
                      : (isDark
                          ? OroColors.borderDark
                          : OroColors.borderLight),
                  width: isPickUp ? 1.6 : 1.0,
                ),
                boxShadow: isPickUp
                    ? [
                        BoxShadow(
                          color: OroColors.accentGold.withValues(alpha: 0.22),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isPickUp
                          ? OroColors.accentGold.withValues(alpha: 0.15)
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.04)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 24,
                      color: isPickUp
                          ? OroColors.accentGold
                          : (isDark
                              ? OroColors.crystalWhite.withValues(alpha: 0.50)
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Recogida en Tienda",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: isPickUp ? FontWeight.w900 : FontWeight.w700,
                      fontSize: 12.5,
                      color: isPickUp
                          ? (isDark
                              ? OroColors.crystalWhite
                              : OroColors.nightBlue)
                          : (isDark
                              ? OroColors.crystalWhite.withValues(alpha: 0.65)
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Retiro en boutique",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isPickUp
                          ? (isDark
                              ? OroColors.turquoise
                              : OroColors.waterBlue)
                          : (isDark
                              ? OroColors.textSecondaryDark
                              : OroColors.textSecondaryLight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
