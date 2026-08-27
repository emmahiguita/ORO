import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class ShareButton extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ShareButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: .88),
        shape: BoxShape.circle,
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: .7)),
      ),
      child: IconButton(
        icon: Icon(Icons.share_outlined, color: theme.colorScheme.onSurface),
        onPressed: () {
          controller.shareProductWithImage();
        },
      ),
    );
  }
}
