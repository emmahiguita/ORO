import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/screens/search/search.dart';

class SerchBar extends StatelessWidget {
  final void Function()? onPressed;
  final String hint;
  final TextEditingController? controller;

  const SerchBar({
    super.key,
    this.onPressed,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .12),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            Get.to(
              const Search(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 300),
              arguments: {'input': value},
            );
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.brightness == Brightness.dark
                ? OroColors.surfaceDarkElevated
                : Colors.white,
            prefixIcon: IconButton(
              tooltip: 'search_products'.tr,
              onPressed: onPressed,
              icon: const Icon(Icons.search_rounded),
              color: OroColors.accentGold,
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: OroColors.accentGold.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: OroColors.accentGold.withValues(alpha: .26),
                ),
              ),
              child: const Icon(Icons.tune_rounded, size: 19),
            ),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
