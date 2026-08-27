import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class FavoriteButton extends StatefulWidget {
  final int? itemId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.itemId,
    this.size = 48,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.22).animate(
      CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<FavouritesControllerImp>(
      init: Get.isRegistered<FavouritesControllerImp>()
          ? Get.find<FavouritesControllerImp>()
          : Get.put(FavouritesControllerImp()),
      builder: (controller) {
        final active =
            widget.itemId != null && controller.favourites[widget.itemId] == 1;

        return Semantics(
          label: active ? 'Quitar de favoritos' : 'Agregar a favoritos',
          button: true,
          child: Tooltip(
            message: active ? 'Quitar de favoritos' : 'Agregar a favoritos',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.itemId == null
                    ? null
                    : () async {
                        await OroMotion.selectionHaptic();
                        _scaleCtrl.forward().then((_) => _scaleCtrl.reverse());

                        controller.setFavourites(
                          widget.itemId!,
                          active ? 0 : 1,
                        );
                        if (active) {
                          controller.deleteFavourites('${widget.itemId}');
                        } else {
                          controller.addFavourites('${widget.itemId}');
                        }
                      },
                borderRadius: BorderRadius.circular(widget.size / 2),
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: Center(
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.50)
                                : Colors.white.withValues(alpha: 0.85),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.22)
                                  : OroColors.waterBlue.withValues(alpha: 0.20),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withValues(alpha: isDark ? 0.3 : 0.10),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ScaleTransition(
                              scale: _scaleAnim,
                              child: Icon(
                                active
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 17,
                                color: active
                                    ? OroColors.error
                                    : (isDark
                                        ? OroColors.crystalWhite
                                        : OroColors.nightBlue),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
