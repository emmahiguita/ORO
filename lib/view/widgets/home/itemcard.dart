import 'package:flutter/material.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/itemcardcontent.dart';

class ItemCard extends StatefulWidget {
  final ItemsModel itemsModel;
  final Function() onTap;
  final int colorIndex;

  const ItemCard({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.colorIndex,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _hovered = false;
  bool _pressed = false;

  double get discountPercentage {
    final original =
        double.tryParse((widget.itemsModel.itemPrice ?? '0').toString()) ?? 0;
    final finalPrice =
        double.tryParse((widget.itemsModel.itemFinalPrice ?? '0').toString()) ??
            0;
    if (original <= 0 || finalPrice >= original) return 0;
    return ((original - finalPrice) / original) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = _pressed ? .985 : (_hovered ? 1.015 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: .07),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _hovered ? .11 : .055),
                  blurRadius: _hovered ? 28 : 18,
                  offset: Offset(0, _hovered ? 14 : 9),
                ),
              ],
            ),
            child: ItemCardContent(
              itemsModel: widget.itemsModel,
              colorIndex: widget.colorIndex,
              discountPercentage: discountPercentage,
            ),
          ),
        ),
      ),
    );
  }
}
