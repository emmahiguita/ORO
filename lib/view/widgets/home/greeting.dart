import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/screens/notification/viewnotification.dart';

class Greeting extends StatelessWidget {
  final String name;
  final String? img;

  const Greeting({
    super.key,
    required this.name,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeScreenControllerImp>();
    final theme = Theme.of(context);
    final displayName = _displayName(name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'ORO',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: OroColors.accentGoldDark,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.4,
              ),
            ),
            const Spacer(),
            _NotificationAction(
              count: controller.getUnreadCount(),
              onTap: () {
                Get.to(
                  () => const ViewNotification(),
                  transition: Transition.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 280),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Hola, $displayName',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -.4,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Encuentra algo que realmente quieras conservar.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: .58),
          ),
        ),
      ],
    );
  }

  String _displayName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return 'bienvenido';
    final modeIndex = normalized.toLowerCase().indexOf('(modo');
    return (modeIndex == -1 ? normalized : normalized.substring(0, modeIndex))
        .trim();
  }
}

class _NotificationAction extends StatelessWidget {
  const _NotificationAction({
    required this.count,
    required this.onTap,
  });

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Tooltip(
          message: 'Notificaciones',
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.notifications_none_rounded, size: 22),
              ),
            ),
          ),
        ),
        if (count > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              height: 18,
              constraints: const BoxConstraints(minWidth: 18),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: OroColors.error,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
