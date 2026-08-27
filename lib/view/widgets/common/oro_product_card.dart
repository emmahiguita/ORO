import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/discount_badge.dart';
import 'package:oro/view/widgets/common/favorite_button.dart';
import 'package:oro/view/widgets/common/oro_product_visualizer_3d.dart';
import 'package:oro/view/widgets/common/price_label.dart';

/// Tarjeta Canónica Universal de Producto ORO (Clean Architecture & SOLID)
/// Garantiza un tamaño 100% uniforme en cuadrículas y rieles horizontales,
/// integrando el visualizador 3D/360°, favoritos, descuentos y carrito.
class OroProductCard extends StatefulWidget {
  final ItemsModel itemsModel;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool loading;
  final int colorIndex;
  final String? heroTag;
  final bool enableInteractive360;

  const OroProductCard({
    super.key,
    required this.itemsModel,
    this.onTap,
    this.onAddToCart,
    this.loading = false,
    this.colorIndex = 0,
    this.heroTag,
    this.enableInteractive360 = true,
  });

  @override
  State<OroProductCard> createState() => _OroProductCardState();
}

class _OroProductCardState extends State<OroProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.975).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final productName = databaseTranslation(
      widget.itemsModel.itemName,
      widget.itemsModel.itemNameAr,
      widget.itemsModel.itemNameEs,
    );
    final category = databaseTranslation(
      widget.itemsModel.categoryName,
      widget.itemsModel.categoryNameAr,
      widget.itemsModel.categoryNameEs,
    );
    final currentPrice = (widget.itemsModel.itemFinalPrice ??
            widget.itemsModel.itemPrice ??
            0)
        .toDouble();
    final originalPrice =
        (widget.itemsModel.itemPrice ?? currentPrice).toDouble();
    final rating =
        double.tryParse('${widget.itemsModel.itemAvgRating}') ?? 0.0;
    final discount = widget.itemsModel.itemDiscount ?? 0;

    return Semantics(
      button: true,
      label: productName,
      child: RepaintBoundary(
        child: GestureDetector(
          onTapDown: (_) => _scaleController.forward(),
          onTapUp: (_) => _scaleController.reverse(),
          onTapCancel: () => _scaleController.reverse(),
          onTap: () async {
            await OroMotion.selectionHaptic();
            widget.onTap?.call();
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: isDark
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0F2030),
                          Color(0xFF091622),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFBF9F4),
                        ],
                      ),
                border: Border.all(
                  color: isDark
                      ? OroColors.accentGold.withValues(alpha: 0.70)
                      : OroColors.accentGold.withValues(alpha: 0.80),
                  width: 1.2,
                ),
                boxShadow: [
                  // Resplandor de Borde Dorado de Lujo
                  BoxShadow(
                    color: OroColors.accentGold.withValues(alpha: isDark ? 0.22 : 0.14),
                    blurRadius: 14,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── 1. Escenario Visual 3D / 360 del Producto ───────────────
                    AspectRatio(
                      aspectRatio: 1.15,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Resplandor Radial de Vitrina de Lujo (Spotlight)
                          Center(
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    (isDark
                                            ? OroColors.accentGold
                                            : OroColors.accentGold)
                                        .withValues(
                                            alpha: isDark ? 0.15 : 0.08),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 1.0],
                                ),
                              ),
                            ),
                          ),

                          // Visualizador 3D / 360 con padding perfecto
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
                              child: OroProductVisualizer3D(
                                imageUrl: widget.itemsModel.itemImg,
                                productName: productName,
                                categoryName: widget.itemsModel.categoryName,
                                fit: BoxFit.contain,
                                memCacheWidth: 512,
                                heroTag: widget.heroTag,
                                enableInteractive360:
                                    widget.enableInteractive360,
                              ),
                            ),
                          ),

                          // Badge de Descuento Flotante
                          if (discount > 0)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: DiscountBadge(discount: discount),
                            ),

                          // Botón de Favorito Circular con Rebote
                          Positioned(
                            top: 2,
                            right: 2,
                            child: FavoriteButton(
                              itemId: widget.itemsModel.itemId,
                              size: 38,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── 2. Zona de Información del Producto (Integrada) ─────
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Fila: Categoría y Rating
                            Row(
                              children: [
                                if (category.trim().isNotEmpty)
                                  Expanded(
                                    child: Text(
                                      category.toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isDark
                                            ? OroColors.turquoise
                                            : OroColors.waterBlue,
                                        fontSize: 7.5,
                                        letterSpacing: 0.6,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                if (rating > 0) ...[
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 10.5,
                                    color: OroColors.accentGold,
                                  ),
                                  const SizedBox(width: 1.5),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? OroColors.textSecondaryDark
                                          : OroColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),

                            // Nombre del producto (2 líneas uniformes)
                            Text(
                              productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 11.0,
                                height: 1.15,
                                letterSpacing: -0.2,
                                color: isDark
                                    ? OroColors.crystalWhite
                                    : OroColors.nightBlue,
                              ),
                            ),

                            const Spacer(),

                            // Fila Inferior: Precio y Botón de Carrito
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: PriceLabel(
                                    currentPrice: currentPrice,
                                    originalPrice: originalPrice,
                                    discount: discount,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                _AddToCartButton(
                                  itemId: widget.itemsModel.itemId,
                                  loading: widget.loading,
                                  onAddToCart: widget.onAddToCart,
                                  onTap: widget.onTap,
                                ),
                              ],
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
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({
    required this.itemId,
    required this.loading,
    this.onAddToCart,
    this.onTap,
  });
  final int? itemId;
  final bool loading;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Agregar al carrito',
      button: true,
      child: Tooltip(
        message: 'Agregar al carrito',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: loading || itemId == null
                ? null
                : () async {
                    await OroMotion.selectionHaptic();
                    if (onAddToCart != null) {
                      onAddToCart!();
                    } else {
                      onTap?.call();
                    }
                  },
            borderRadius: BorderRadius.circular(9),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: OroColors.emeraldGradient,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: OroColors.emerald.withValues(alpha: 0.35),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: loading
                    ? const SizedBox(
                        width: 13,
                        height: 13,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.add_shopping_cart_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
