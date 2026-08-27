import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/formatters/oro_money.dart';

class CartFloatingButton extends StatelessWidget {
  final double price;
  final int shippingPrice;
  final void Function()? onTap;
  final StatusRequest statusRequest;
  final bool isDisabled;

  const CartFloatingButton({
    super.key,
    required this.price,
    required this.shippingPrice,
    this.statusRequest = StatusRequest.none,
    this.onTap,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = price + shippingPrice;

    return Stack(
      children: [
        // Main frosted glass card
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: BoxDecoration(
                color: isDark
                    ? OroColors.nightBlue.withValues(alpha: 0.90)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: OroColors.accentGold.withValues(alpha: 0.55),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: OroColors.accentGold.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.30),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? OroColors.accentGoldSoft
                              : OroColors.textSecondaryLight,
                        ),
                      ),
                      Text(
                        OroMoney.format(price),
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? OroColors.crystalWhite
                              : OroColors.nightBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Costo de envío",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? OroColors.accentGoldSoft
                              : OroColors.textSecondaryLight,
                        ),
                      ),
                      Text(
                        shippingPrice == 0
                            ? "GRATIS"
                            : OroMoney.format(shippingPrice.toDouble()),
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: shippingPrice == 0
                              ? OroColors.emerald
                              : (isDark
                                  ? OroColors.crystalWhite
                                  : OroColors.nightBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: isDark
                        ? OroColors.borderDark
                        : OroColors.borderLight,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total a Pagar",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: OroColors.accentGold,
                          letterSpacing: 0.2,
                        ),
                      ),
                      Text(
                        OroMoney.format(total),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: isDark
                              ? OroColors.crystalWhite
                              : OroColors.nightBlue,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Botón Checkout con Gradiente Esmeralda y Hápticos
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isDisabled
                          ? null
                          : () async {
                              await OroMotion.selectionHaptic();
                              onTap?.call();
                            },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: isDisabled
                              ? null
                              : OroColors.emeraldGradient,
                          color: isDisabled
                              ? Colors.grey.withValues(alpha: 0.3)
                              : null,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDisabled
                              ? null
                              : [
                                  BoxShadow(
                                    color: OroColors.emerald
                                        .withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Continuar con el pedido",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Loading overlay
        if (statusRequest == StatusRequest.loding)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(OroColors.accentGold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

