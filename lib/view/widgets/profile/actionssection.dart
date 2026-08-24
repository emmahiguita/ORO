import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:oro/controller/profile/profilecontroller.dart';
import 'package:oro/view/widgets/profile/actiontile.dart';

class ActionsSection extends StatelessWidget {
  final ProfileControllerImp controller;

  const ActionsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ActionTile(
            icon: Iconsax.truck_fast_copy,
            title: 'Pedidos en Curso',
            subtitle: 'Sigue el estado de tus compras activas',
            onTap: () => controller.goToUnDeliverdOrders(),
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          ActionTile(
            icon: Iconsax.archive_book_copy,
            title: 'Historial de Pedidos',
            subtitle: 'Revisa tus compras y recibos anteriores',
            onTap: () => controller.goToArchivedOrder(),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
