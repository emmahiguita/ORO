import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/delivery/deliverysettingscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/deliveryinfocard.dart';

class DeliveryProfileHeader extends StatelessWidget {
  final DeliverySettingsControllerImp controller;

  const DeliveryProfileHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Banner with profile picture overlay
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Appcolor.berry.withValues(alpha: 0.8),
                      Appcolor.berry,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: controller.banner != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: AppLink.bannerimage + controller.banner!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Appcolor.berry.withValues(alpha: 0.8),
                                  Appcolor.berry,
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
              Positioned(
                bottom: -35,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      child: controller.pfp != null
                          ? ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: AppLink.pfpimage + controller.pfp!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  size: 45,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.grey[600],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

          // Username directly under profile picture
          Text(
            controller.username ?? 'User Name',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),

          const SizedBox(height: 20),

          // User info cards in a more organized layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                DeliveryInfoCard(
                  icon: Icons.email_outlined,
                  iconColor: Colors.blue,
                  label: 'Correo electrónico',
                  value: controller.email ?? 'user@email.com',
                ),
                const SizedBox(height: 12),
                DeliveryInfoCard(
                  icon: Icons.phone_outlined,
                  iconColor: Colors.green,
                  label: 'Phone',
                  value: controller.phoneNumber ?? '+000 000 0000',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
