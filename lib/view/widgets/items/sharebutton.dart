import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class ShareButton extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ShareButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.share_outlined, color: Colors.white),
        onPressed: () {
          controller.shareProductWithImage();
        },
      ),
    );
  }
}
