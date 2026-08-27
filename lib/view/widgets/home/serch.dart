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
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: _openSearch,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: IconButton(
            tooltip: 'search_products'.tr,
            onPressed: onPressed,
            icon: const Icon(Icons.search_rounded),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(7),
            child: Material(
              color: theme.colorScheme.primary.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(13),
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(13),
                child: const SizedBox(
                  width: 42,
                  height: 42,
                  child: Icon(
                    Icons.tune_rounded,
                    color: OroColors.forest,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openSearch(String value) {
    Get.to(
      const Search(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 280),
      arguments: {'input': value},
    );
  }
}
