import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/adminprofilepicturewidget.dart';
import 'package:oro/view/widgets/admin/adminuserinfowidget.dart';

class AdminDrawerHeaderWidget extends StatelessWidget {
  final AdminHomeControllerImp controller;

  const AdminDrawerHeaderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Appcolor.berry,
            Appcolor.berry.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Banner
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: AppLink.bannerimage + controller.banner!,
              fit: BoxFit.cover,
              width: 1500,
              height: 500,
              alignment: Alignment.center,
              color: Colors.black.withValues(alpha: 0.4),
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) => Container(
                color: Appcolor.berry.withValues(alpha: 0.7),
              ),
              errorWidget: (context, url, error) => Container(
                color: Appcolor.berry.withValues(alpha: 0.7),
              ),
            ),
          ),

          // Profile Content
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                AdminProfilePictureWidget(controller: controller),
                const SizedBox(height: 16),
                // User Info
                AdminUserInfoWidget(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
