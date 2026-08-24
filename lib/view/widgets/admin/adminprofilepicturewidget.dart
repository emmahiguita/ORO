import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';

class AdminProfilePictureWidget extends StatelessWidget {
  final AdminHomeControllerImp controller;

  const AdminProfilePictureWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey[300],
            backgroundImage: controller.pfp != null
                ? CachedNetworkImageProvider(
                    AppLink.pfpimage + controller.pfp!,
                  )
                : null,
            child: controller.pfp == null
                ? const Icon(
                    Icons.person_outline,
                    size: 40,
                    color: Colors.grey,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.green[400],
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
