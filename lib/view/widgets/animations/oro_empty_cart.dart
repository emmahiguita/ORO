import 'package:flutter/material.dart';
import 'package:oro/view/widgets/animations/oro_animated_button.dart';
import 'package:oro/view/widgets/animations/oro_animation_assets.dart';
import 'package:oro/view/widgets/animations/oro_lottie_view.dart';

class OroEmptyCart extends StatelessWidget {
  final VoidCallback? onExplorePressed;
  final String title;
  final String description;
  final String buttonText;

  const OroEmptyCart({
    super.key,
    this.onExplorePressed,
    this.title = 'Tu Carrito está Vacío',
    this.description =
        'Parece que aún no has añadido artículos a tu bolsa de compra. Descubre nuestras colecciones exclusivas.',
    this.buttonText = 'Explorar Catálogo',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OroLottieView(
              assetName: OroAnimationAssets.empty,
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                height: 1.45,
              ),
            ),
            if (onExplorePressed != null) ...[
              const SizedBox(height: 28),
              OroAnimatedButton(
                text: buttonText,
                icon: Icons.storefront_outlined,
                onPressed: onExplorePressed,
                height: 50,
                width: 240,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
