import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/items/specrow.dart';

class SpecificationsCard extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const SpecificationsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Información del Producto",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 16),
              SpecRow(
                label: "Categoría",
                value: databaseTranslation(
                  controller.data.categoryName,
                  controller.data.categoryNameAr,
                  controller.data.categoryNameEs,
                ),
              ),
              SpecRow(
                label: "Disponibilidad",
                value: (controller.data.itemCount ?? 0) > 0
                    ? "En Stock (Disponible)"
                    : "Agotado",
              ),
              if ((controller.data.itemDiscount ?? 0) > 0)
                SpecRow(
                  label: "Descuento Exclusivo",
                  value: "${controller.data.itemDiscount}% OFF",
                ),
            ],
          ),
        ),
        if (controller.allRating.isEmpty) const SizedBox(height: 50),
      ],
    );
  }
}
