import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oro/apilink.dart';

class NotificationIcon extends StatelessWidget {
  final dynamic notification;
  const NotificationIcon({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: notification.notificationIcon == null
          ? Icon(
              Icons.notifications_rounded,
              color: Theme.of(context).primaryColor,
              size: 24,
            )
          : Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.network(
                  AppLink.notificationicon + notification.notificationIcon!,
                  fit: BoxFit.contain,
                  placeholderBuilder: (context) => Icon(
                    Icons.notifications_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
    );
  }
}
