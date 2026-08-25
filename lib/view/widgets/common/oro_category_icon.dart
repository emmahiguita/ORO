import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oro/core/constant/color.dart';

class OroCategoryIcon extends StatelessWidget {
  final String? categoryImg;
  final String? categoryName;
  final double size;

  const OroCategoryIcon({
    super.key,
    required this.categoryImg,
    this.categoryName,
    this.size = 28,
  });

  static IconData getCategoryIcon(String? name) {
    final cat = (name ?? '').toLowerCase();
    if (cat.contains('elect') ||
        cat.contains('phone') ||
        cat.contains('tech')) {
      return Icons.devices_other_rounded;
    }
    if (cat.contains('fash') ||
        cat.contains('moda') ||
        cat.contains('calzado') ||
        cat.contains('ropa')) {
      return Icons.checkroom_rounded;
    }
    if (cat.contains('home') ||
        cat.contains('hogar') ||
        cat.contains('cocina')) {
      return Icons.home_rounded;
    }
    if (cat.contains('beauty') ||
        cat.contains('belleza') ||
        cat.contains('cuidado') ||
        cat.contains('perfume')) {
      return Icons.spa_rounded;
    }
    if (cat.contains('sport') ||
        cat.contains('deporte') ||
        cat.contains('fitness')) {
      return Icons.sports_tennis_rounded;
    }
    if (cat.contains('book') ||
        cat.contains('libro') ||
        cat.contains('lectura')) {
      return Icons.auto_stories_rounded;
    }
    return Icons.category_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = getCategoryIcon(categoryName);

    // If SVG URL is absolute http/https
    final img = categoryImg ?? '';
    final isNetwork = img.startsWith('http://') || img.startsWith('https://');

    if (isNetwork && img.endsWith('.svg')) {
      return SvgPicture.network(
        img,
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => Icon(
          iconData,
          size: size,
          color: theme.colorScheme.primary,
        ),
      );
    }

    // Default ultra-clean, reliable vector icon
    return Icon(
      iconData,
      size: size,
      color: Appcolor.berry,
    );
  }
}
