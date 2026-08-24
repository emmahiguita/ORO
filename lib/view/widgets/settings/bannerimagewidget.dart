import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/settings/imagepickerdialog.dart';

class BannerImageWidget extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const BannerImageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: controller.banner == null
                  ? CachedNetworkImage(
                      imageUrl: AppLink.bannerimage + controller.oldbanner,
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
                      controller.banner!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => _showImagePickerDialog(controller, 'banner'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
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
