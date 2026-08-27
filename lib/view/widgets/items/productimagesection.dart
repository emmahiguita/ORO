import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/discount_badge.dart';
import 'package:oro/view/widgets/common/favorite_button.dart';
import 'package:oro/view/widgets/common/oro_product_visualizer_3d.dart';

class ProductImageSection extends StatefulWidget {
  final ItemsDetailsControllerImp controller;

  const ProductImageSection({super.key, required this.controller});

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  int _selectedAngle = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageHeight = (width * 0.82).clamp(280.0, 440.0);

    final name = databaseTranslation(
      widget.controller.data.itemName,
      widget.controller.data.itemNameAr,
      widget.controller.data.itemNameEs,
    );
    final discount = widget.controller.data.itemDiscount ?? 0;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Contenedor de Fotografía 3D Water Liquid Glass
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      height: imageHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            OroColors.nightBlue.withValues(alpha: 0.92),
                            OroColors.surfaceDarkElevated.withValues(alpha: 0.84),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: OroColors.accentGold.withValues(alpha: 0.75),
                          width: 1.4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: OroColors.accentGold.withValues(alpha: 0.25),
                            blurRadius: 28,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: OroProductVisualizer3D(
                            imageUrl: widget.controller.data.itemImg,
                            productName: name,
                            categoryName: widget.controller.data.categoryName,
                            fit: BoxFit.contain,
                            memCacheWidth: 1080,
                            heroTag:
                                'product-${widget.controller.data.itemId ?? widget.controller.data.hashCode}',
                            enableInteractive360: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Badge de Descuento Esmeralda (Arriba Izquierda)
                if (discount > 0)
                  Positioned(
                    top: 14,
                    left: 14,
                    child: DiscountBadge(discount: discount),
                  ),

                // Botón de Favorito Flotante Cristalino (Arriba Derecha)
                Positioned(
                  top: 14,
                  right: 14,
                  child: FavoriteButton(
                    itemId: widget.controller.data.itemId,
                    size: 44,
                  ),
                ),

                // Indicador 360° Drag Cue (Abajo Izquierda)
                Positioned(
                  bottom: 14,
                  left: 14,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: OroColors.nightBlue.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: OroColors.accentGold.withValues(alpha: 0.65),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: OroColors.accentGold.withValues(alpha: 0.20),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.threesixty_rounded,
                          color: OroColors.accentGold,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "GIRA 360°",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Píldoras de Vistas Preestablecidas con scroll horizontal seguro
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAngleChip(0, "Frontal", Icons.crop_portrait_rounded),
                  const SizedBox(width: 8),
                  _buildAngleChip(1, "Lateral 90°", Icons.rotate_right_rounded),
                  const SizedBox(width: 8),
                  _buildAngleChip(2, "Posterior", Icons.flip_camera_android_rounded),
                  const SizedBox(width: 8),
                  _buildAngleChip(3, "360° Auto", Icons.sync_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAngleChip(int index, String label, IconData icon) {
    final isSelected = _selectedAngle == index;

    return InkWell(
      onTap: () async {
        await OroMotion.selectionHaptic();
        setState(() {
          _selectedAngle = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          gradient: isSelected ? OroColors.goldGradient : null,
          color: isSelected
              ? null
              : OroColors.nightBlue.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : OroColors.accentGold.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isSelected ? Colors.white : OroColors.crystalWhite,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? Colors.white : OroColors.crystalWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

