import 'package:flutter/material.dart';
import 'package:oro/controller/admin/offermessage/editoffercontroller.dart';
import 'package:oro/view/widgets/admin/ImageButton.dart';

class ImageSelectionButtons extends StatelessWidget {
  final EditOfferControllerImp controller;

  const ImageSelectionButtons({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ImageButton(
            icon: Icons.camera_alt,
            label: 'Cámara',
            onTap: () => controller.getImageByCamera(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ImageButton(
            icon: Icons.photo_library,
            label: 'Galería',
            onTap: () => controller.getImageByGallery(),
          ),
        ),
      ],
    );
  }
}
