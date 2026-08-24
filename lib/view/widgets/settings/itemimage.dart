import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/constant/color.dart';

class ItemImage extends StatelessWidget {
  final dynamic rating;

  const ItemImage({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Hero(
          tag: rating.itemId!,
          child: CachedNetworkImage(
            imageUrl: AppLink.itemimage + rating.itemImg!,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 90,
              height: 90,
              color: Colors.grey[100],
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Appcolor.berry,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 90,
              height: 90,
              color: Colors.grey[100],
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
