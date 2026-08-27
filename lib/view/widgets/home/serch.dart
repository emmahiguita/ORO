import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/view/screens/search/search.dart';
import 'package:oro/view/widgets/search/oro_search_filter_sheet.dart';

class SerchBar extends StatelessWidget {
  final void Function()? onPressed;
  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const SerchBar({
    super.key,
    this.onPressed,
    required this.hint,
    required this.controller,
    this.onChanged,
  });

  void _openSearch(String value) async {
    await OroMotion.selectionHaptic();
    Get.to(
      () => const Search(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 280),
      arguments: {'input': value},
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OroSearchFilterSheet(
        onApply: ({
          category,
          required sort,
          required minPrice,
          required maxPrice,
          required onlyDiscount,
          required highRating,
        }) {
          Get.to(
            () => const Search(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 280),
            arguments: {
              'input': controller?.text ?? '',
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: isDark
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        OroColors.nightBlue.withValues(alpha: 0.92),
                        OroColors.surfaceDarkElevated.withValues(alpha: 0.82),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.96),
                        OroColors.surfaceWarm.withValues(alpha: 0.92),
                      ],
                    ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? OroColors.accentGold.withValues(alpha: 0.50)
                    : OroColors.accentGold.withValues(alpha: 0.65),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: OroColors.accentGold
                      .withValues(alpha: isDark ? 0.18 : 0.14),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: OroColors.accentGold.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: OroColors.accentGold,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: _openSearch,
                    style: TextStyle(
                      color:
                          isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? OroColors.accentGoldSoft.withValues(alpha: 0.75)
                            : OroColors.textSecondaryLight,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                if (controller?.text.isNotEmpty ?? false)
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark
                          ? OroColors.accentGoldSoft
                          : OroColors.nightBlue,
                      size: 18,
                    ),
                    onPressed: () {
                      controller?.clear();
                      onChanged?.call('');
                    },
                  )
                else ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          OroMotion.selectionHaptic();
                          if (onPressed != null) {
                            onPressed!();
                          } else {
                            _openFilters(context);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            gradient: OroColors.goldGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: OroColors.accentGold
                                    .withValues(alpha: 0.30),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

