import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/admin/imagesourcebutton.dart';

class ImagePickerDialog extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;
  final String imageType;

  const ImagePickerDialog({
    super.key,
    required this.controller,
    required this.imageType,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ImageSourceButton(
                    icon: Icons.photo_library,
                    label: 'Galería',
                    onTap: () async {
                      Get.back();
                      if (imageType == 'banner') {
                        controller.banner = await controller.getImageByGallery(
                            controller.banner, false);
                      } else {
                        controller.pfp = await controller.getImageByGallery(
                            controller.pfp, true);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ImageSourceButton(
                    icon: Icons.camera_alt,
                    label: 'Cámara',
                    onTap: () async {
                      Get.back();
                      if (imageType == 'banner') {
                        controller.banner = await controller.getImageByCamera(
                            controller.banner, false);
                      } else {
                        controller.pfp = await controller.getImageByCamera(
                            controller.pfp, true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
