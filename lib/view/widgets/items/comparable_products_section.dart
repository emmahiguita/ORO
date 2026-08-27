import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/items/oro_product_comparison_sheet.dart';

class ComparableProductsSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ComparableProductsSection({super.key, required this.controller});

  List<ItemsModel> _getComparableItems() {
    final currentCat = controller.data.itemCat;
    final currentId = controller.data.itemId;

    final List<ItemsModel> list = [];
    for (final raw in OfflineDataProvider.mockItems) {
      try {
        final model = ItemsModel.fromJson(raw);
        if (model.itemId != currentId && (model.itemCat == currentCat || list.length < 4)) {
          list.add(model);
        }
      } catch (_) {}
    }
    return list;
  }

  void _openComparison(BuildContext context, List<ItemsModel> comparables) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OroProductComparisonSheet(
        currentItem: controller.data,
        comparableItems: comparables,
        onSelectProduct: (selected) {
          controller.data = selected;
          controller.update();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final comparables = _getComparableItems();

    if (comparables.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  OroColors.nightBlue.withValues(alpha: 0.90),
                  OroColors.surfaceDarkElevated.withValues(alpha: 0.82),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: 0.40),
                width: 1.2,
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
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.compare_rounded,
                          color: OroColors.accentGold,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PRODUCTOS COMPARABLES',
                          style: TextStyle(
                            color: OroColors.turquoise,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        OroMotion.selectionHaptic();
                        _openComparison(context, comparables);
                      },
                      icon: const Icon(
                        Icons.compare_arrows_rounded,
                        size: 14,
                        color: OroColors.accentGold,
                      ),
                      label: const Text(
                        'Comparar',
                        style: TextStyle(
                          fontSize: 11,
                          color: OroColors.accentGold,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Horizontal Rail of Comparable Cards
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: comparables.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = comparables[index];
                      final name = databaseTranslation(
                        item.itemName,
                        item.itemNameAr,
                        item.itemNameEs,
                      );
                      final price = (item.itemFinalPrice ?? item.itemPrice ?? 0).toDouble();

                      return InkWell(
                        onTap: () async {
                          await OroMotion.selectionHaptic();
                          controller.data = item;
                          controller.update();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 110,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF132738) : const Color(0xFFF9F7F2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: OroColors.accentGold.withValues(alpha: 0.35),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 58,
                                  width: 58,
                                  child: OroProductImage(
                                    imageUrl: item.itemImg,
                                    productName: name,
                                    categoryName: item.categoryName,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                  color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                OroMoney.format(price),
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w900,
                                  color: OroColors.accentGold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
