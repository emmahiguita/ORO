import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/search/searchcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_card.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/common/oro_staggered_item.dart';
import 'package:oro/view/widgets/search/oro_search_filter_sheet.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  void _openFilterSheet(BuildContext context, SearchControllerImp controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OroSearchFilterSheet(
        initialCategory: controller.selectedCategory,
        initialSort: controller.selectedSort,
        initialMinPrice: controller.minPrice,
        initialMaxPrice: controller.maxPrice,
        initialOnlyDiscount: controller.onlyDiscount,
        initialHighRating: controller.highRating,
        onApply: ({
          category,
          required sort,
          required minPrice,
          required maxPrice,
          required onlyDiscount,
          required highRating,
        }) {
          controller.applyFilters(
            category: category,
            sort: sort,
            minP: minPrice,
            maxP: maxPrice,
            discountOnly: onlyDiscount,
            ratingHigh: highRating,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<SearchControllerImp>(
      init: SearchControllerImp(),
      builder: (searchControllerImp) {
        final queryText = searchControllerImp.textEditingController?.text.trim() ?? '';
        final isInputEmpty = queryText.isEmpty;
        final results = searchControllerImp.filteredResults;

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Fondo Global Selva Líquida
              Positioned.fill(
                child: Image.asset(
                  'assets/images/store_liquid_jungle_background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'images/store_liquid_jungle_background.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (_, __, ___) => Container(
                      color: OroColors.nightBlue,
                    ),
                  ),
                ),
              ),
              // Capa de Protección Sutil
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: OroColors.protectionGradient,
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // ── 1. App Bar / Input de Búsqueda Flotante de Lujo ────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: OroColors.accentGold,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 14, sigmaY: 14),
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? OroColors.nightBlue
                                            .withValues(alpha: 0.88)
                                        : Colors.white
                                            .withValues(alpha: 0.95),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: OroColors.accentGold
                                          .withValues(alpha: 0.70),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: OroColors.accentGold
                                            .withValues(alpha: 0.18),
                                        blurRadius: 14,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller:
                                        searchControllerImp.textEditingController ??=
                                            TextEditingController(),
                                    onChanged: (val) {
                                      searchControllerImp.update();
                                    },
                                    style: TextStyle(
                                      color: isDark
                                          ? OroColors.crystalWhite
                                          : OroColors.nightBlue,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Buscar Rolex, Cartier, joyas, moda...",
                                      hintStyle: TextStyle(
                                        color: isDark
                                            ? OroColors.accentGoldSoft
                                                .withValues(alpha: 0.75)
                                            : OroColors.textSecondaryLight,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search_rounded,
                                        color: OroColors.accentGold,
                                        size: 20,
                                      ),
                                      suffixIcon: searchControllerImp
                                              .textEditingController!
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(
                                                Icons.clear_rounded,
                                                color: OroColors.accentGold,
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                searchControllerImp
                                                    .textEditingController
                                                    ?.clear();
                                                searchControllerImp.results
                                                    .clear();
                                                searchControllerImp
                                                    .statusRequest =
                                                    StatusRequest.none;
                                                searchControllerImp.update();
                                              },
                                            )
                                          : null,
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 13,
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.trim().isNotEmpty) {
                                        searchControllerImp
                                            .search(value.trim());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Botón Filtros con Badge Activo
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              InkWell(
                                onTap: () {
                                  OroMotion.selectionHaptic();
                                  _openFilterSheet(context, searchControllerImp);
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    gradient: OroColors.goldGradient,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: OroColors.accentGold
                                            .withValues(alpha: 0.30),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.tune_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              if (searchControllerImp.activeFiltersCount > 0)
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: OroColors.emerald,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${searchControllerImp.activeFiltersCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ── 2. Riel de Categorías Rápidas ─────────────────────────
                    SizedBox(
                      height: 38,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          _buildQuickCategoryChip(
                            label: 'Todos',
                            isSelected: searchControllerImp.selectedCategory == null,
                            onTap: () => searchControllerImp.setCategory(null),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Oro & Joyería',
                            icon: Icons.diamond_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'oro',
                            onTap: () => searchControllerImp.setCategory('oro'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Electrónica',
                            icon: Icons.devices_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'electronica',
                            onTap: () => searchControllerImp.setCategory('electronica'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Moda',
                            icon: Icons.checkroom_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'moda',
                            onTap: () => searchControllerImp.setCategory('moda'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Calzado',
                            icon: Icons.snowshoeing_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'calzado',
                            onTap: () => searchControllerImp.setCategory('calzado'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Bolsos & Accesorios',
                            icon: Icons.shopping_bag_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'bolsos',
                            onTap: () => searchControllerImp.setCategory('bolsos'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Perfumería',
                            icon: Icons.spa_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'belleza',
                            onTap: () => searchControllerImp.setCategory('belleza'),
                            isDark: isDark,
                          ),
                          _buildQuickCategoryChip(
                            label: 'Hogar',
                            icon: Icons.home_rounded,
                            isSelected: searchControllerImp.selectedCategory == 'hogar',
                            onTap: () => searchControllerImp.setCategory('hogar'),
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── 3. Contenido Principal / Resultados, Carga o Búsquedas Recientes
                    Expanded(
                      child: (isInputEmpty && searchControllerImp.selectedCategory == null)
                          ? _buildRecentAndTrendingGlassView(
                              context, searchControllerImp, isDark)
                          : _buildSearchBody(
                              context,
                              searchControllerImp,
                              results,
                              queryText.isNotEmpty
                                  ? queryText
                                  : (searchControllerImp.selectedCategory ?? 'Categoría'),
                              isDark,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBody(
    BuildContext context,
    SearchControllerImp controller,
    List<dynamic> results,
    String queryText,
    bool isDark,
  ) {
    if (controller.statusRequest == StatusRequest.loding) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(OroColors.accentGold),
        ),
      );
    }

    if (results.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark
                      ? OroColors.nightBlue.withValues(alpha: 0.88)
                      : Colors.white.withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: OroColors.accentGold.withValues(alpha: 0.40),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 48,
                      color: OroColors.accentGold,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sin resultados para "$queryText"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? OroColors.crystalWhite
                            : OroColors.nightBlue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Prueba buscando "Oro", "Collar", "Anillo", "iPhone" o selecciona una categoría.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? OroColors.accentGoldSoft
                            : OroColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.textEditingController?.text = 'Oro';
                        controller.search('Oro');
                      },
                      icon: const Icon(Icons.diamond_rounded, size: 16),
                      label: const Text('Ver Joyas de Oro'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: OroColors.accentGold,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Barra de Conteo y Alternador Cuadrícula / Lista
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${results.length} productos encontrados',
                  style: TextStyle(
                    color: isDark
                        ? OroColors.crystalWhite
                        : OroColors.nightBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.toggleViewMode();
                  },
                  icon: Icon(
                    controller.isGridView
                        ? Icons.view_list_rounded
                        : Icons.grid_view_rounded,
                    color: OroColors.accentGold,
                    size: 22,
                  ),
                  tooltip: controller.isGridView
                      ? 'Ver en Lista'
                      : 'Ver en Cuadrícula 3D',
                ),
              ],
            ),
          ),
        ),

        // Grid 3D o Lista
        if (controller.isGridView)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = results[index];
                  return OroProductCard(
                    itemsModel: item,
                    heroTag: 'search-grid-${item.itemId}-$index',
                    enableInteractive360: true,
                    onTap: () => controller.goToItemDetails(item),
                  );
                },
                childCount: results.length,
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            sliver: SliverList.separated(
              itemCount: results.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = results[index];
                final price = (item.itemFinalPrice ?? item.itemPrice ?? 0.0).toDouble();
                final name = databaseTranslation(
                  item.itemName,
                  item.itemNameAr,
                  item.itemNameEs,
                );
                final category = databaseTranslation(
                  item.categoryName,
                  item.categoryNameAr,
                  item.categoryNameEs,
                );
                final rating = double.tryParse('${item.itemAvgRating}') ?? 0;

                return OroStaggeredItem(
                  index: index,
                  delayBase: 35,
                  child: OroPressable(
                    onTap: () async {
                      await OroMotion.selectionHaptic();
                      controller.goToItemDetails(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F2030) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: OroColors.accentGold.withValues(alpha: 0.65),
                          width: 1.1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: OroColors.accentGold.withValues(alpha: 0.10),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.black26 : const Color(0xFFF8F6F0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: OroProductImage(
                              imageUrl: item.itemImg,
                              productName: name,
                              categoryName: item.categoryName,
                              fit: BoxFit.contain,
                              memCacheWidth: 320,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (category.trim().isNotEmpty)
                                  Text(
                                    category.toUpperCase(),
                                    style: TextStyle(
                                      color: isDark
                                          ? OroColors.turquoise
                                          : OroColors.waterBlue,
                                      fontSize: 8.5,
                                      letterSpacing: 0.7,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (category.trim().isNotEmpty)
                                  const SizedBox(height: 2),
                                Text(
                                  name,
                                  style: TextStyle(
                                    color: isDark
                                        ? OroColors.crystalWhite
                                        : OroColors.nightBlue,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    height: 1.18,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (rating > 0) ...[
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 13,
                                        color: OroColors.accentGold,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        rating.toStringAsFixed(1),
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 4),
                                Text(
                                  OroMoney.format(price),
                                  style: TextStyle(
                                    color: isDark
                                        ? OroColors.crystalWhite
                                        : OroColors.nightBlue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: OroColors.accentGold,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 70),
        ),
      ],
    );
  }

  Widget _buildQuickCategoryChip({
    required String label,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: () {
          OroMotion.selectionHaptic();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            gradient: isSelected ? OroColors.goldGradient : null,
            color: isSelected
                ? null
                : (isDark
                    ? OroColors.nightBlue.withValues(alpha: 0.70)
                    : Colors.white.withValues(alpha: 0.85)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : (isDark
                      ? OroColors.accentGold.withValues(alpha: 0.35)
                      : OroColors.borderLight),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 13,
                  color: isSelected
                      ? Colors.white
                      : (isDark
                          ? OroColors.crystalWhite
                          : OroColors.nightBlue),
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
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
      ),
    );
  }

  Widget _buildRecentAndTrendingGlassView(
      BuildContext context, SearchControllerImp controller, bool isDark) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            decoration: BoxDecoration(
              color: isDark
                  ? OroColors.nightBlue.withValues(alpha: 0.88)
                  : Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: 0.45),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: OroColors.accentGold.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Búsquedas Recientes
                if (controller.recentSearches.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.history_rounded,
                            color: OroColors.accentGold,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'BÚSQUEDAS RECIENTES',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                              color: isDark
                                  ? OroColors.turquoise
                                  : OroColors.waterBlue,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => controller.clearRecentSearches(),
                        child: const Text(
                          'Borrar todo',
                          style: TextStyle(
                            fontSize: 11,
                            color: OroColors.accentGold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.recentSearches.map((query) {
                      return InkWell(
                        onTap: () {
                          controller.textEditingController?.text = query;
                          controller.search(query);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Chip(
                          label: Text(query),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? OroColors.crystalWhite
                                : OroColors.nightBlue,
                          ),
                          backgroundColor: isDark
                              ? const Color(0xFF132738)
                              : const Color(0xFFF3EFE6),
                          side: BorderSide(
                            color: OroColors.accentGold.withValues(alpha: 0.40),
                          ),
                          deleteIcon: const Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: OroColors.accentGold,
                          ),
                          onDeleted: () => controller.removeRecentSearch(query),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: isDark
                        ? OroColors.borderDark
                        : OroColors.borderLight,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                ],

                // 2. Tendencias en ORO
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: OroColors.warning,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'TENDENCIAS EN ORO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                        color: isDark ? OroColors.turquoise : OroColors.waterBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.trendingSearches.map((trend) {
                    return ActionChip(
                      avatar: const Icon(
                        Icons.trending_up_rounded,
                        color: OroColors.accentGold,
                        size: 14,
                      ),
                      label: Text(trend),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? OroColors.crystalWhite
                            : OroColors.nightBlue,
                      ),
                      backgroundColor: isDark
                          ? const Color(0xFF132738)
                          : const Color(0xFFF3EFE6),
                      side: BorderSide(
                        color: OroColors.accentGold.withValues(alpha: 0.50),
                      ),
                      onPressed: () {
                        controller.textEditingController?.text = trend;
                        controller.search(trend);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
