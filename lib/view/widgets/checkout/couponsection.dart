import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/checkout/couponcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<CouponControllerImp>(
      builder: (controller) => Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? OroColors.nightBlue.withValues(alpha: 0.85)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: controller.isCouponUsed
                      ? OroColors.emerald
                      : OroColors.accentGold.withValues(alpha: 0.40),
                  width: 1.2,
                ),
              ),
              child: TextFormField(
                readOnly: controller.isCouponUsed,
                controller: controller.couponTextEditingController,
                style: TextStyle(
                  color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  hintText: "Ingresa tu código de cupón",
                  hintStyle: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? OroColors.accentGoldSoft.withValues(alpha: 0.65)
                        : OroColors.textSecondaryLight,
                  ),
                  prefixIcon: const Icon(
                    Icons.local_offer_rounded,
                    color: OroColors.accentGold,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: controller.isCouponUsed
                  ? OroColors.emeraldGradient
                  : OroColors.goldGradient,
              boxShadow: [
                BoxShadow(
                  color: (controller.isCouponUsed
                          ? OroColors.emerald
                          : OroColors.accentGold)
                      .withValues(alpha: 0.30),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: IgnorePointer(
                ignoring: controller.isCouponUsed,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () async {
                    await OroMotion.selectionHaptic();
                    controller.checkCoupon();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Center(
                      child: controller.statusRequest == StatusRequest.loding
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : controller.isCouponUsed
                              ? const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Aplicado",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "Aplicar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13.5,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
