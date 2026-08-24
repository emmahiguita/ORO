import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/setting/viewratingcontroller.dart';
import 'package:oro/core/constant/color.dart';

class UserInfoSection extends StatelessWidget {
  final ViewRatingControllerImp controller;

  const UserInfoSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Appcolor.berry.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[100],
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: AppLink.pfpimage + controller.pfp!,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.username!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2D3748),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'Your review',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
