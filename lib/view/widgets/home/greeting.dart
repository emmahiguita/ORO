import 'dart:ui';

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
    final isDark = theme.brightness == Brightness.dark;
    final displayName = _displayName(name);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? OroColors.surfaceDarkElevated.withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.90),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.10)
                    : OroColors.borderLight,
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar / ORO Official Logo Badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: OroColors.accentGold,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: OroColors.accentGold.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            size: 16,
                            color: OroColors.accentGold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Saludo Flotante
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            '¡Hola, $displayName!',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '✨',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        'Explora lo mejor de ORO',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10.5,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.60),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Acción de Notificaciones
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
          ),
        ),
      ),
    );
  }

  String _displayName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return 'Bienvenido';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFF3F2EC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.notifications_none_rounded, size: 19),
          ),
        ),
        if (count > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              height: 15,
              constraints: const BoxConstraints(minWidth: 15),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: OroColors.error,
                borderRadius: BorderRadius.circular(7.5),
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
