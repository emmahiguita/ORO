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
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: BottomAppBar(
              height: 82,
              elevation: 0,
              notchMargin: 10,
              shape: const CircularNotchedRectangle(),
              color: (isDark ? OroColors.surfaceDark : OroColors.surface)
                  .withValues(alpha: .92),
              surfaceTintColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: List.generate(
                    controller.listpages.length + 1,
                    (index) {
                      if (index == 2) {
                        return const SizedBox(width: 72);
                      }
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
