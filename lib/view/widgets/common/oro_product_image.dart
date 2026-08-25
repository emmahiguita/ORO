import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/design/oro_colors.dart';

class OroProductImage extends StatelessWidget {
  final String? imageUrl;
  final String? productName;
  final String? categoryName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const OroProductImage({
    super.key,
    required this.imageUrl,
    this.productName,
    this.categoryName,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.memCacheWidth = 560,
    this.memCacheHeight,
  });

  String _formatUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '${AppLink.itemimage}$raw';
  }

  IconData _getCategoryIcon(String? category) {
    final cat = (category ?? '').toLowerCase();
    if (cat.contains('elect') ||
        cat.contains('phone') ||
        cat.contains('audio')) {
      return Icons.devices_other_rounded;
    }
    if (cat.contains('fash') ||
        cat.contains('moda') ||
        cat.contains('calzado')) {
      return Icons.checkroom_rounded;
    }
    if (cat.contains('home') ||
        cat.contains('hogar') ||
        cat.contains('cocina')) {
      return Icons.home_rounded;
    }
    if (cat.contains('beauty') ||
        cat.contains('belleza') ||
        cat.contains('perfume')) {
      return Icons.spa_rounded;
    }
    if (cat.contains('sport') || cat.contains('deporte')) {
      return Icons.sports_tennis_rounded;
    }
    if (cat.contains('book') || cat.contains('libro')) {
      return Icons.auto_stories_rounded;
    }
    return Icons.shopping_bag_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final formatted = _formatUrl(imageUrl);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget imageContent;

    if (formatted.isNotEmpty) {
      imageContent = CachedNetworkImage(
        imageUrl: formatted,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: Duration.zero,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color:
              isDark ? OroColors.surfaceDarkElevated : const Color(0xFFEBE6DC),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(context),
      );
    } else {
      imageContent = _buildFallback(context);
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageContent,
      );
    }

    return imageContent;
  }

  Widget _buildFallback(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icon = _getCategoryIcon(categoryName ?? productName);
    final name = (productName ?? 'ORO Exclusive').trim();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? OroColors.surfaceDarkElevated : const Color(0xFFF3EFE6),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? OroColors.surfaceDark : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isDark ? OroColors.borderDark : OroColors.borderLight,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: OroColors.forest,
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? OroColors.textPrimaryDark
                        : OroColors.textPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: OroColors.accentGold,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'ORO',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
