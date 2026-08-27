import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/widgets/home/bottombarbutton.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  color: (dark ? OroColors.surfaceDark : Colors.white)
                      .withValues(alpha: .94),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: .72),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: dark ? .26 : .08),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Row(
                  children: List.generate(
                    controller.listpages.length + 1,
                    (index) {
                      if (index == 2) return const SizedBox(width: 70);
                      final pageIndex = index > 2 ? index - 1 : index;
                      return Expanded(
                        child: BottomBarButton(
                          isActive: controller.currentpage == pageIndex,
                          onPressed: () => controller.changePage(pageIndex),
                          iconData: controller.iconpages[pageIndex],
                          text: controller.namepages[pageIndex],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
