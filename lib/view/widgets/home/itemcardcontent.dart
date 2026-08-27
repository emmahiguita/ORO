import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/cart/cartController.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_discount_badge.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class ItemCardContent extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;
  final double discountPercentage;

  const ItemCardContent({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final productName = databaseTranslation(
      itemsModel.itemName,
      itemsModel.itemNameAr,
      itemsModel.itemNameEs,
    );
    final price = itemsModel.itemFinalPrice?.toString().trim();
    final originalPrice = itemsModel.itemPrice?.toString().trim();
    final displayPrice = price == null || price.isEmpty ? originalPrice : price;

    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'product-${itemsModel.itemId ?? itemsModel.hashCode}',
          child: Material(
            type: MaterialType.transparency,
            child: OroProductImage(
              imageUrl: itemsModel.itemImg,
              productName: productName,
              categoryName: itemsModel.categoryName,
              fit: BoxFit.cover,
              memCacheWidth: 560,
              showFallbackLabel: false,
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x05000000), Color(0x1F000000), Color(0xF0000000)],
              stops: [0, .33, 1],
            ),
          ),
        ),
        if (discountPercentage > 0)
          Positioned(
            top: 10,
            left: 10,
            child: OroDiscountBadge.compact(percentage: discountPercentage),
          ),
        Positioned(
          top: 11,
          right: 11,
          child: _FavouriteCardAction(itemId: itemsModel.itemId),
        ),
        Positioned(
          left: 8,
          right: 8,
          bottom: 8,
          height: 78,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xA8121714),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.white.withValues(alpha: .16)),
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: _CartCardAction(itemId: itemsModel.itemId),
        ),
        Positioned(
          left: 18,
          right: 62,
          bottom: 18,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  height: 1.14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.2,
                  shadows: const [Shadow(color: Colors.black, blurRadius: 7)],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '\$${displayPrice ?? '0'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: OroColors.accentGoldSoft,
                  fontWeight: FontWeight.w800,
                  shadows: const [Shadow(color: Colors.black, blurRadius: 7)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavouriteCardAction extends StatelessWidget {
  const _FavouriteCardAction({required this.itemId});

  final int? itemId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesControllerImp>(
      init: Get.isRegistered<FavouritesControllerImp>()
          ? Get.find<FavouritesControllerImp>()
          : Get.put(FavouritesControllerImp()),
      builder: (controller) {
        final isFavourite =
            itemId != null && controller.favourites[itemId] == 1;
        return _CardActionButton(
          tooltip: isFavourite ? 'Quitar de favoritos' : 'Añadir a favoritos',
          icon: isFavourite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          iconColor: isFavourite ? const Color(0xFFFF6B6B) : Colors.white,
          onTap: itemId == null
              ? null
              : () {
                  controller.setFavourites(itemId!, isFavourite ? 0 : 1);
                  if (isFavourite) {
                    controller.deleteFavourites('$itemId');
                  } else {
                    controller.addFavourites('$itemId');
                  }
                },
        );
      },
    );
  }
}

class _CartCardAction extends StatelessWidget {
  const _CartCardAction({required this.itemId});

  final int? itemId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartControllerImp>(
      init: Get.isRegistered<CartControllerImp>()
          ? Get.find<CartControllerImp>()
          : Get.put(CartControllerImp()),
      builder: (controller) => _CardActionButton(
        tooltip: 'Agregar al carrito',
        icon: Icons.shopping_bag_outlined,
        iconColor: OroColors.accentGoldSoft,
        filled: true,
        onTap: itemId == null ? null : () => controller.addCart('$itemId'),
      ),
    );
  }
}

class _CardActionButton extends StatelessWidget {
  const _CardActionButton({
    required this.tooltip,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.filled = false,
  });

  final String tooltip;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: filled ? const Color(0xD9141715) : const Color(0x70000000),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: .35)),
            ),
            child: Icon(icon, color: iconColor, size: 21),
          ),
        ),
      ),
    );
  }
}
