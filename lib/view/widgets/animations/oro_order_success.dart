import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/animations/oro_animated_button.dart';
import 'package:oro/view/widgets/animations/oro_animation_assets.dart';
import 'package:oro/view/widgets/animations/oro_lottie_view.dart';

class OroOrderSuccess extends StatelessWidget {
  final String orderId;
  final double? totalPrice;
  final String? deliveryTime;
  final VoidCallback? onTrackOrder;
  final VoidCallback? onContinueShopping;

  const OroOrderSuccess({
    super.key,
    required this.orderId,
    this.totalPrice,
    this.deliveryTime = '25 - 40 min',
    this.onTrackOrder,
    this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OroLottieView(
              assetName: OroAnimationAssets.orderPlaced,
              width: 200,
              height: 200,
              repeat: false,
            ),
            const SizedBox(height: 12),
            Text(
              '¡Pedido Confirmado!',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Appcolor.berry,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tu orden #$orderId ha sido procesada con éxito y está siendo preparada con la máxima dedicación.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Número de Pedido',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        '#$orderId',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiempo estimado',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Appcolor.forest,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            deliveryTime ?? '30 min',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Appcolor.forest,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (totalPrice != null) ...[
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pagado',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        Text(
                          '\$${totalPrice!.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Appcolor.oxblood,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (onTrackOrder != null)
              OroAnimatedButton(
                text: 'Seguir mi Pedido',
                icon: Icons.local_shipping_outlined,
                onPressed: onTrackOrder,
                height: 52,
              ),
            if (onContinueShopping != null) ...[
              const SizedBox(height: 12),
              OroAnimatedButton(
                text: 'Volver a la Tienda',
                icon: Icons.storefront_outlined,
                isOutlined: true,
                onPressed: onContinueShopping,
                height: 50,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
