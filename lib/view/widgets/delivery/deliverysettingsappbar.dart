import 'package:flutter/material.dart';

class DeliverySettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DeliverySettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Ajustes',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black87,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
