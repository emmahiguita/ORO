import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/view/widgets/locale/List.dart';

class LCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LCAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'DevEmm',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: -.4,
            ),
      ),
      actions: [
        IconButton(
          tooltip: '2'.tr,
          onPressed: () {
            Get.defaultDialog(
              title: 'language_title'.tr,
              titleStyle: Theme.of(context).textTheme.titleLarge,
              content: const SizedBox.shrink(),
              actions: lcList(),
              radius: 22,
            );
          },
          icon: const Icon(Icons.language_rounded),
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
