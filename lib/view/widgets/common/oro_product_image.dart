import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/constant/color.dart';

class OroProductImage extends StatelessWidget {
  final String? imageUrl;
  final String? productName;
  final String? categoryName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const OroProductImage({
    super.key,
    required this.imageUrl,
    this.productName,
    this.categoryName,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  String _formatUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '${AppLink.itemimage}$raw';
  }

  IconData _getCategoryIcon(String? category) {
    final cat = (category ?? '').toLowerCase();
    if (cat.contains('elect') || cat.contains('phone') || cat.contains('audio')) {
      return Icons.devices_other_rounded;
    }
    if (cat.contains('fash') || cat.contains('moda') || cat.contains('calzado')) {
      return Icons.checkroom_rounded;
    }
    if (cat.contains('home') || cat.contains('hogar') || cat.contains('cocina')) {
      return Icons.home_rounded;
    }
    if (cat.contains('beauty') || cat.contains('belleza') || cat.contains('perfume')) {
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
    final theme = Theme.of(context);

    Widget imageContent;

    if (formatted.isNotEmpty) {
      imageContent = CachedNetworkImage(
        imageUrl: formatted,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(theme),
      );
    } else {
      imageContent = _buildFallback(theme);
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageContent,
      );
    }

    return imageContent;
  }

  Widget _buildFallback(ThemeData theme) {
    final icon = _getCategoryIcon(categoryName ?? productName);
    final name = (productName ?? 'ORO Exclusive').trim();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Appcolor.berry.withValues(alpha: 0.08),
            Appcolor.rosePompadour.withValues(alpha: 0.15),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Appcolor.berry.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Appcolor.berry,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Appcolor.inkSoft,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Appcolor.accentGold.withValues(alpha: 0.85),
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
