import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class ShippingAddress extends StatelessWidget {
  final String title;
  final String placeName;
  final String subTitle;
  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  const ShippingAddress({
    super.key,
    required this.title,
    required this.subTitle,
    required this.placeName,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          await OroMotion.selectionHaptic();
          onTap?.call();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? (isDark ? const Color(0xFF142B3B) : const Color(0xFFFAF6EE))
                : (isDark
                    ? OroColors.nightBlue.withValues(alpha: 0.60)
                    : Colors.white.withValues(alpha: 0.80)),
            border: Border.all(
              color: isSelected
                  ? OroColors.accentGold
                  : (isDark ? OroColors.borderDark : OroColors.borderLight),
              width: isSelected ? 1.6 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: OroColors.accentGold.withValues(alpha: 0.20),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: isSelected
                      ? OroColors.accentGold.withValues(alpha: 0.15)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? OroColors.accentGold
                      : (isDark
                          ? OroColors.crystalWhite.withValues(alpha: 0.50)
                          : OroColors.textSecondaryLight),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w900 : FontWeight.w700,
                        fontSize: 13.5,
                        color: isDark
                            ? OroColors.crystalWhite
                            : OroColors.nightBlue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [placeName, subTitle]
                          .where((s) => s.trim().isNotEmpty)
                          .join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? OroColors.accentGoldSoft.withValues(alpha: 0.80)
                            : OroColors.textSecondaryLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected
                    ? OroColors.accentGold
                    : (isDark
                        ? OroColors.crystalWhite.withValues(alpha: 0.30)
                        : Colors.grey.shade400),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
