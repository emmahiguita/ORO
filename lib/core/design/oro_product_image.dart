import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/design/oro_colors.dart';

/// Optimized image widget with hardware-accelerated memory cache sizing,
/// static/lightweight placeholders to avoid animation overhead, and fallback error states.
class OroProductImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const OroProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.memCacheWidth = 560,
    this.memCacheHeight,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  String _resolveUrl(String raw) {
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }
    return '${AppLink.itemimage}$raw';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fallbackBg =
        isDark ? OroColors.surfaceDarkElevated : const Color(0xFFF0EDE5);

    Widget imageContent;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      imageContent = errorWidget ??
          Container(
            width: width,
            height: height,
            color: fallbackBg,
            alignment: Alignment.center,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 32,
              color:
                  isDark ? OroColors.textMutedDark : OroColors.textMutedLight,
            ),
          );
    } else if (imageUrl!.startsWith('assets/') ||
        imageUrl!.startsWith('images/')) {
      imageContent = Image.asset(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: fallbackBg,
          child: const Icon(Icons.broken_image_outlined, size: 28),
        ),
      );
    } else {
      final resolved = _resolveUrl(imageUrl!.trim());
      imageContent = CachedNetworkImage(
        imageUrl: resolved,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: Duration.zero,
        filterQuality: FilterQuality.medium,
        placeholder: (_, __) =>
            placeholder ??
            Container(
              width: width,
              height: height,
              color: fallbackBg,
              alignment: Alignment.center,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    OroColors.accentGold.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
        errorWidget: (_, __, ___) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              color: fallbackBg,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 28,
                color:
                    isDark ? OroColors.textMutedDark : OroColors.textMutedLight,
              ),
            ),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageContent,
      );
    }

    return imageContent;
  }
}
