import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class OroProductComparisonSheet extends StatelessWidget {
  final ItemsModel currentItem;
  final List<ItemsModel> comparableItems;
  final Function(ItemsModel selectedItem) onSelectProduct;

  const OroProductComparisonSheet({
    super.key,
    required this.currentItem,
    required this.comparableItems,
    required this.onSelectProduct,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final compareCandidate = comparableItems.isNotEmpty ? comparableItems.first : null;

    final currentName = databaseTranslation(
      currentItem.itemName,
      currentItem.itemNameAr,
      currentItem.itemNameEs,
    );
    final currentPrice = (currentItem.itemFinalPrice ?? currentItem.itemPrice ?? 0).toDouble();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          decoration: BoxDecoration(
            color: isDark
                ? OroColors.nightBlue.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.97),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: OroColors.accentGold.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: OroColors.accentGold.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.compare_arrows_rounded,
                        color: OroColors.accentGold,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Comparativa de Productos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? OroColors.crystalWhite
                              : OroColors.nightBlue,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Get.back(),
                    color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (compareCandidate == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No hay productos similares disponibles para comparar.',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
              else ...[
                // Side by Side Cards
                Row(
                  children: [
                    // Producto Actual
                    Expanded(
                      child: _buildProductPreviewCard(
                        title: "Actual",
                        name: currentName,
                        price: currentPrice,
                        imgUrl: currentItem.itemImg ?? '',
                        category: currentItem.categoryName ?? '',
                        rating: double.tryParse('${currentItem.itemAvgRating}') ?? 4.9,
                        isCurrent: true,
                        isDark: isDark,
                        onTap: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Producto Comparable
                    Expanded(
                      child: _buildProductPreviewCard(
                        title: "Alternativa",
                        name: databaseTranslation(
                          compareCandidate.itemName,
                          compareCandidate.itemNameAr,
                          compareCandidate.itemNameEs,
                        ),
                        price: (compareCandidate.itemFinalPrice ?? compareCandidate.itemPrice ?? 0).toDouble(),
                        imgUrl: compareCandidate.itemImg ?? '',
                        category: compareCandidate.categoryName ?? '',
                        rating: double.tryParse('${compareCandidate.itemAvgRating}') ?? 4.8,
                        isCurrent: false,
                        isDark: isDark,
                        onTap: () {
                          Get.back();
                          onSelectProduct(compareCandidate);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tabla de Especificaciones Comparadas
                _buildComparisonRow(
                  label: "Pureza / Material",
                  valA: "Oro 24K / 18K",
                  valB: "Oro 18K / PBR",
                  isDark: isDark,
                ),
                _buildComparisonRow(
                  label: "Garantía Oficial",
                  valA: "Certificado ORO",
                  valB: "Certificado ORO",
                  isDark: isDark,
                ),
                _buildComparisonRow(
                  label: "Envío & Entrega",
                  valA: "Envío Asegurado 24h",
                  valB: "Envío Asegurado 24h",
                  isDark: isDark,
                ),
                _buildComparisonRow(
                  label: "Disponibilidad",
                  valA: "${currentItem.itemCount ?? 10} uds",
                  valB: "${compareCandidate.itemCount ?? 8} uds",
                  isDark: isDark,
                ),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductPreviewCard({
    required String title,
    required String name,
    required double price,
    required String imgUrl,
    required String category,
    required double rating,
    required bool isCurrent,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF132738) : const Color(0xFFF9F7F2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrent
              ? OroColors.accentGold
              : OroColors.accentGold.withValues(alpha: 0.35),
          width: isCurrent ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  gradient: isCurrent ? OroColors.goldGradient : null,
                  color: isCurrent ? null : Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w900,
                    color: isCurrent ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 12, color: OroColors.accentGold),
                  const SizedBox(width: 2),
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Imagen
          Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: OroProductImage(
                imageUrl: imgUrl,
                productName: name,
                categoryName: category,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
            ),
          ),
          const SizedBox(height: 4),

          Text(
            OroMoney.format(price),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: OroColors.accentGold,
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: 32,
            child: ElevatedButton(
              onPressed: () async {
                await OroMotion.selectionHaptic();
                onTap();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrent ? OroColors.nightBlue : OroColors.emerald,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                isCurrent ? 'Actual' : 'Ver Este',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow({
    required String label,
    required String valA,
    required String valB,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDark ? OroColors.accentGoldSoft : OroColors.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              valA,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              valB,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
