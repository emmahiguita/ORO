import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final String itemprice;
  final String itmeQuantity;
  const ItemView(
      {super.key,
      required this.itemName,
      required this.itemImage,
      required this.itemprice,
      required this.itmeQuantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(itemImage),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              itemprice,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Qty: $itmeQuantity',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
