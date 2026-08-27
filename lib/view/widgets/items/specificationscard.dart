import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
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
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      OroColors.nightBlue.withValues(alpha: 0.90),
                      OroColors.surfaceDarkElevated.withValues(alpha: 0.82),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.30),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Información del Producto",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: OroColors.crystalWhite,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 14),
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
            ),
          ),
        ),
        if (controller.allRating.isEmpty) const SizedBox(height: 50),
      ],
    );
  }
}
