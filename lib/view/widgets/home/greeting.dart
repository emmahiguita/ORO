import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/constant/imageasset.dart';
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
    final safeName = _displayName(name);
    final hasImage = img != null && img!.trim().isNotEmpty;

    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.secondary.withValues(alpha: .7),
            ),
          ),
          child: ClipOval(
            child: hasImage
                ? CachedNetworkImage(
                    imageUrl: '${AppLink.pfpimage}$img',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: theme.colorScheme.surface,
                    ),
                    errorWidget: (_, __, ___) => _avatarFallback(context),
                  )
                : _avatarFallback(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'hello'.tr}, $safeName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.35,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'home_subtitle'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Material(
          color: theme.colorScheme.surface.withValues(alpha: .82),
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Get.to(
                () => const ViewNotification(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: SizedBox(
              height: 46,
              width: 46,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Icon(Icons.notifications_none_rounded,
                      color: theme.colorScheme.onSurface),
                  if (controller.getUnreadCount() > 0)
                    Positioned(
                      right: 7,
                      top: 7,
                      child: Container(
                        height: 16,
                        constraints: const BoxConstraints(minWidth: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Appcolor.oxblood,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          controller.getUnreadCount() > 99
                              ? '99+'
                              : '${controller.getUnreadCount()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
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

  Widget _avatarFallback(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: Image.asset(
        AppImage.authLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}
