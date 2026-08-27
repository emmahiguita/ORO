import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/items/specrow.dart';

class SpecificationsCard extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const SpecificationsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: .65)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Información del Producto",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
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
