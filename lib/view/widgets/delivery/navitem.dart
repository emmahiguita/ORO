import 'package:flutter/material.dart';
import 'package:oro/controller/delivery/deliveryhomecontroller.dart';
import 'package:oro/core/constant/color.dart';

class NavItem extends StatelessWidget {
  final DeliveryHomeControllerImp controller;
  final int index;
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const NavItem(
      {super.key,
      required this.controller,
      required this.index,
      required this.icon,
      required this.label,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isNotificationTab = index == 2;
    int unreadCount = controller.getUnreadCount();
    final theme = Theme.of(context);

    return Expanded(
      child: Semantics(
        label: '$label tab${isActive ? ', selected' : ''}',
        selected: isActive,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      Appcolor.berry.withValues(alpha: 0.12),
                      Appcolor.berry.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: isActive
                ? Border.all(
                    color: Appcolor.berry.withValues(alpha: 0.2),
                    width: 1,
                  )
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: Appcolor.berry.withValues(alpha: 0.15),
              highlightColor: Appcolor.berry.withValues(alpha: 0.08),
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  vertical: isActive ? 10 : 8,
                  horizontal: 6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with enhanced animations and badge
                    SizedBox(
                      height: 36,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Icon background with micro-interaction
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            padding: EdgeInsets.all(isActive ? 8 : 6),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Appcolor.berry.withValues(alpha: 0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: Appcolor.berry
                                            .withValues(alpha: 0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: AnimatedScale(
                              scale: isActive ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: Icon(
                                icon,
                                size: 22,
                                color: controller.getIconColor(
                                  isActive,
                                  isNotificationTab,
                                  unreadCount,
                                  theme,
                                ),
                              ),
                            ),
                          ),
                          // Enhanced notification badge
                          if (isNotificationTab && unreadCount > 0)
                            Positioned(
                              right: -1,
                              top: -1,
                              child: AnimatedScale(
                                scale: 1.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.elasticOut,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.red.shade400,
                                        Colors.red.shade600,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.red.withValues(alpha: 0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    unreadCount > 99
                                        ? '99+'
                                        : unreadCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Enhanced label with better typography
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      style: TextStyle(
                        fontSize: isActive ? 12 : 11,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                        color: isActive
                            ? Appcolor.berry
                            : theme.textTheme.bodyMedium?.color
                                    ?.withValues(alpha: 0.7) ??
                                Colors.grey[600],
                        letterSpacing: isActive ? 0.2 : 0.1,
                        height: 1.2,
                      ),
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
