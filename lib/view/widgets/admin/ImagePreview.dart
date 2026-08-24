import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/offermessage/editoffercontroller.dart';

class ImagePreview extends StatelessWidget {
  final EditOfferControllerImp controller;

  const ImagePreview({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: controller.file == null
            ? CachedNetworkImage(
                imageUrl: AppLink.homeimage + (controller.oldimg ?? ''),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Failed to load image',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            : Image.file(
                controller.file!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
