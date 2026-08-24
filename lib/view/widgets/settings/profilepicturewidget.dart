import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/settings/imagepickerdialog.dart';

class ProfilePictureWidget extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const ProfilePictureWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 100,
                height: 100,
                child: controller.pfp == null
                    ? CachedNetworkImage(
                        imageUrl: AppLink.pfpimage + controller.oldpfp,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Image.file(
                        controller.pfp!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showImagePickerDialog(controller, 'pfp'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog(
      UpdateAccountInformationControllerImp controller, String imageType) {
    Get.dialog(
      ImagePickerDialog(controller: controller, imageType: imageType),
    );
  }
}
