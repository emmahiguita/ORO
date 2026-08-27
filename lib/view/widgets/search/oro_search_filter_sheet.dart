import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/formatters/oro_money.dart';

class OroSearchFilterSheet extends StatefulWidget {
  final String? initialCategory;
  final String initialSort;
  final double initialMinPrice;
  final double initialMaxPrice;
  final bool initialOnlyDiscount;
  final bool initialHighRating;
  final Function({
    String? category,
    required String sort,
    required double minPrice,
    required double maxPrice,
    required bool onlyDiscount,
    required bool highRating,
  }) onApply;

  const OroSearchFilterSheet({
    super.key,
    this.initialCategory,
    this.initialSort = 'relevance',
    this.initialMinPrice = 0,
    this.initialMaxPrice = 200000000,
    this.initialOnlyDiscount = false,
    this.initialHighRating = false,
    required this.onApply,
  });

  @override
  State<OroSearchFilterSheet> createState() => _OroSearchFilterSheetState();
}

class _OroSearchFilterSheetState extends State<OroSearchFilterSheet> {
  late String? _selectedCategory;
  late String _selectedSort;
  late RangeValues _priceRange;
  late bool _onlyDiscount;
  late bool _highRating;

  final List<Map<String, dynamic>> _categories = [
    {'id': null, 'label': 'Todos', 'icon': Icons.all_inclusive_rounded},
    {'id': 'oro', 'label': 'Oro & Joyas', 'icon': Icons.diamond_rounded},
    {'id': 'electronica', 'label': 'Electrónica', 'icon': Icons.devices_rounded},
    {'id': 'moda', 'label': 'Moda & Ropa', 'icon': Icons.checkroom_rounded},
    {'id': 'calzado', 'label': 'Calzado', 'icon': Icons.snowshoeing_rounded},
    {'id': 'hogar', 'label': 'Hogar', 'icon': Icons.home_rounded},
  ];

  final List<Map<String, dynamic>> _sortOptions = [
    {'id': 'relevance', 'label': 'Relevancia', 'icon': Icons.auto_awesome_rounded},
    {'id': 'price_asc', 'label': 'Menor Precio', 'icon': Icons.arrow_downward_rounded},
    {'id': 'price_desc', 'label': 'Mayor Precio', 'icon': Icons.arrow_upward_rounded},
    {'id': 'rating', 'label': 'Mejor Calificados', 'icon': Icons.star_rounded},
    {'id': 'discount', 'label': 'Mayor Descuento', 'icon': Icons.local_offer_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedSort = widget.initialSort;
    _priceRange = RangeValues(widget.initialMinPrice, widget.initialMaxPrice);
    _onlyDiscount = widget.initialOnlyDiscount;
    _highRating = widget.initialHighRating;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          decoration: BoxDecoration(
            color: isDark
                ? OroColors.nightBlue.withValues(alpha: 0.94)
                : Colors.white.withValues(alpha: 0.97),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: OroColors.accentGold.withValues(alpha: 0.40),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: OroColors.accentGold.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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

                // Título y Reset
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.tune_rounded,
                          color: OroColors.accentGold,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Filtros & Ordenamiento',
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
                    TextButton(
                      onPressed: () async {
                        await OroMotion.selectionHaptic();
                        setState(() {
                          _selectedCategory = null;
                          _selectedSort = 'relevance';
                          _priceRange = const RangeValues(0, 5000);
                          _onlyDiscount = false;
                          _highRating = false;
                        });
                      },
                      child: const Text(
                        'Restablecer',
                        style: TextStyle(
                          color: OroColors.accentGold,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 1. Categorías
                Text(
                  'CATEGORÍA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    color: isDark ? OroColors.turquoise : OroColors.waterBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat['id'];
                    return InkWell(
                      onTap: () async {
                        await OroMotion.selectionHaptic();
                        setState(() {
                          _selectedCategory = cat['id'];
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? OroColors.goldGradient
                              : null,
                          color: isSelected
                              ? null
                              : (isDark
                                  ? OroColors.surfaceDarkElevated
                                  : const Color(0xFFF3EFE6)),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark
                                    ? OroColors.borderDark
                                    : OroColors.borderLight),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              cat['icon'] as IconData,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                      ? OroColors.crystalWhite
                                      : OroColors.nightBlue),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              cat['label'] as String,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? OroColors.crystalWhite
                                        : OroColors.nightBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // 2. Ordenar por
                Text(
                  'ORDENAR POR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    color: isDark ? OroColors.turquoise : OroColors.waterBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _sortOptions.map((opt) {
                    final isSelected = _selectedSort == opt['id'];
                    return InkWell(
                      onTap: () async {
                        await OroMotion.selectionHaptic();
                        setState(() {
                          _selectedSort = opt['id'];
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? OroColors.emeraldGradient
                              : null,
                          color: isSelected
                              ? null
                              : (isDark
                                  ? OroColors.surfaceDarkElevated
                                  : const Color(0xFFF3EFE6)),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark
                                    ? OroColors.borderDark
                                    : OroColors.borderLight),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              opt['icon'] as IconData,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                      ? OroColors.crystalWhite
                                      : OroColors.nightBlue),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              opt['label'] as String,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? OroColors.crystalWhite
                                        : OroColors.nightBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // 3. Rango de Precios
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RANGO DE PRECIO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                        color:
                            isDark ? OroColors.turquoise : OroColors.waterBlue,
                      ),
                    ),
                    Text(
                      '${OroMoney.format(_priceRange.start)} - ${OroMoney.format(_priceRange.end)}',
                      style: const TextStyle(
                        color: OroColors.accentGold,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 200000000,
                  divisions: 100,
                  activeColor: OroColors.accentGold,
                  inactiveColor: isDark
                      ? OroColors.borderDark
                      : OroColors.borderLight,
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
                const SizedBox(height: 8),

                // 4. Filtros Rápidos (Descuentos y Calificación)
                Row(
                  children: [
                    Expanded(
                      child: FilterChip(
                        selected: _onlyDiscount,
                        label: const Text('Solo Ofertas %'),
                        labelStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _onlyDiscount
                              ? Colors.white
                              : (isDark
                                  ? OroColors.crystalWhite
                                  : OroColors.nightBlue),
                        ),
                        selectedColor: OroColors.emerald,
                        checkmarkColor: Colors.white,
                        backgroundColor: isDark
                            ? OroColors.surfaceDarkElevated
                            : const Color(0xFFF3EFE6),
                        onSelected: (val) async {
                          await OroMotion.selectionHaptic();
                          setState(() {
                            _onlyDiscount = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilterChip(
                        selected: _highRating,
                        label: const Text('Rating 4.5+ ★'),
                        labelStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _highRating
                              ? Colors.white
                              : (isDark
                                  ? OroColors.crystalWhite
                                  : OroColors.nightBlue),
                        ),
                        selectedColor: OroColors.accentGold,
                        checkmarkColor: Colors.white,
                        backgroundColor: isDark
                            ? OroColors.surfaceDarkElevated
                            : const Color(0xFFF3EFE6),
                        onSelected: (val) async {
                          await OroMotion.selectionHaptic();
                          setState(() {
                            _highRating = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón Aplicar
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      await OroMotion.successHaptic();
                      widget.onApply(
                        category: _selectedCategory,
                        sort: _selectedSort,
                        minPrice: _priceRange.start,
                        maxPrice: _priceRange.end,
                        onlyDiscount: _onlyDiscount,
                        highRating: _highRating,
                      );
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OroColors.accentGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Aplicar Filtros',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
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
