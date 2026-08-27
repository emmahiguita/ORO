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
  final bool showFallbackLabel;

  const OroProductImage({
    super.key,
    required this.imageUrl,
    this.productName,
    this.categoryName,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.memCacheWidth = 560,
    this.memCacheHeight,
    this.showFallbackLabel = true,
  });

  String _getLuxuryCutoutAsset(String? name, String? category) {
    final combined = '${name ?? ''} ${category ?? ''}'.toLowerCase();
    if (combined.contains('reloj') || combined.contains('watch') || combined.contains('rolex') || combined.contains('patek')) {
      return 'images/real_rolex_submariner.png';
    }
    if (combined.contains('collar') || combined.contains('neck') || combined.contains('cadena') || combined.contains('vancleef')) {
      return 'images/real_vancleef_necklace.png';
    }
    if (combined.contains('anillo') || combined.contains('ring') || combined.contains('tiffany') || combined.contains('esmeralda')) {
      return 'images/real_tiffany_diamond_ring.png';
    }
    if (combined.contains('pulsera') || combined.contains('brazalete') || combined.contains('bracelet') || combined.contains('cartier')) {
      return 'images/real_cartier_love.png';
    }
    if (combined.contains('chaqueta') || combined.contains('jacket') || combined.contains('ropa') || combined.contains('saint')) {
      return 'images/real_saint_laurent_jacket.png';
    }
    if (combined.contains('zapato') || combined.contains('shoe') || combined.contains('bota') || combined.contains('jordan')) {
      return 'images/real_gucci_oxford_shoes.png';
    }
    if (combined.contains('bolso') || combined.contains('bag') || combined.contains('birkin') || combined.contains('chanel')) {
      return 'images/real_hermes_birkin.png';
    }
    return 'images/real_rolex_submariner.png';
  }

  @override
  Widget build(BuildContext context) {
    final raw = imageUrl ?? '';
    Widget imageContent;

    if (raw.startsWith('images/') || raw.startsWith('assets/')) {
      imageContent = Image.asset(
        raw,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: memCacheWidth,
        cacheHeight: memCacheHeight,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, __, ___) => _buildFallback(context),
      );
    } else if (raw.startsWith('product_') || raw.endsWith('.png') || raw.endsWith('.jpg')) {
      imageContent = Image.asset(
        'images/$raw',
        width: width,
        height: height,
        fit: fit,
        cacheWidth: memCacheWidth,
        cacheHeight: memCacheHeight,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/$raw',
          width: width,
          height: height,
          fit: fit,
          cacheWidth: memCacheWidth,
          cacheHeight: memCacheHeight,
          filterQuality: FilterQuality.medium,
          errorBuilder: (_, __, ___) => _buildFallback(context),
        ),
      );
    } else if (raw.isNotEmpty && (raw.startsWith('http://') || raw.startsWith('https://'))) {
      imageContent = CachedNetworkImage(
        imageUrl: raw,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        fadeInDuration: const Duration(milliseconds: 150),
        fadeOutDuration: Duration.zero,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.transparent,
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: OroColors.accentGold,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(context),
      );
    } else if (raw.isNotEmpty) {
      final formatted = '${AppLink.itemimage}$raw';
      imageContent = CachedNetworkImage(
        imageUrl: formatted,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        fadeInDuration: const Duration(milliseconds: 150),
        fadeOutDuration: Duration.zero,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.transparent,
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: OroColors.accentGold,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(context),
      );
    } else {
      imageContent = _buildFallback(context);
    }

    final effectiveRadius = borderRadius ?? BorderRadius.circular(14);
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: imageContent,
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    final assetPath = _getLuxuryCutoutAsset(productName, categoryName);
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: memCacheWidth,
      cacheHeight: memCacheHeight,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(
          Icons.auto_awesome_rounded,
          size: 24,
          color: OroColors.accentGold,
        ),
      ),
    );
  }
}

