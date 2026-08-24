import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/settings/adminsettingscontroller.dart';

class AdminHeaderSection extends StatelessWidget {
  final AdminSettingsControllerImp controller;

  const AdminHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Banner Image
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: AppLink.bannerimage + controller.banner!,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, size: 50),
                ),
              ),
            ),
          ),

          // Profile Avatar
          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: AppLink.pfpimage + controller.pfp!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, size: 40),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
