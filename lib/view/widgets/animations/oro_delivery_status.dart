import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/animations/oro_animation_assets.dart';
import 'package:oro/view/widgets/animations/oro_lottie_view.dart';

enum OroDeliveryStep {
  preparing,
  ready,
  pickedUp,
  onTheWay,
  nearby,
  delivered,
}

class OroDeliveryStatus extends StatelessWidget {
  final OroDeliveryStep currentStep;
  final String orderId;
  final String? riderName;
  final String? riderPhone;
  final String? destinationAddress;
  final VoidCallback? onContactRider;
  final VoidCallback? onViewMap;

  const OroDeliveryStatus({
    super.key,
    required this.currentStep,
    required this.orderId,
    this.riderName,
    this.riderPhone,
    this.destinationAddress,
    this.onContactRider,
    this.onViewMap,
  });

  int get _stepIndex {
    switch (currentStep) {
      case OroDeliveryStep.preparing:
        return 0;
      case OroDeliveryStep.ready:
        return 1;
      case OroDeliveryStep.pickedUp:
        return 2;
      case OroDeliveryStep.onTheWay:
        return 3;
      case OroDeliveryStep.nearby:
        return 4;
      case OroDeliveryStep.delivered:
        return 5;
    }
  }

  String get _statusTitle {
    switch (currentStep) {
      case OroDeliveryStep.preparing:
        return 'Preparando tu pedido';
      case OroDeliveryStep.ready:
        return 'Pedido empacado y listo';
      case OroDeliveryStep.pickedUp:
        return 'Repartidor asignado';
      case OroDeliveryStep.onTheWay:
        return 'En camino a tu dirección';
      case OroDeliveryStep.nearby:
        return '¡Tu repartidor está cerca!';
      case OroDeliveryStep.delivered:
        return '¡Pedido entregado con éxito!';
    }
  }

  String get _statusSubtitle {
    switch (currentStep) {
      case OroDeliveryStep.preparing:
        return 'Nuestro equipo está seleccionando tus productos.';
      case OroDeliveryStep.ready:
        return 'El paquete está sellado y listo para recoger.';
      case OroDeliveryStep.pickedUp:
        return '$riderName ha recogido tu paquete.';
      case OroDeliveryStep.onTheWay:
        return 'El pedido va en ruta con seguimiento en tiempo real.';
      case OroDeliveryStep.nearby:
        return 'Por favor prepárate para recibir tu entrega.';
      case OroDeliveryStep.delivered:
        return 'Esperamos que disfrutes tus productos ORO.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalSteps = OroDeliveryStep.values.length;
    final progress = (_stepIndex + 1) / totalSteps;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 48,
                height: 48,
                child: OroLottieView(
                  assetName: OroAnimationAssets.notification,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _statusTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Appcolor.berry,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _statusSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  theme.colorScheme.onSurface.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation<Color>(Appcolor.forest),
            ),
          ),
          const SizedBox(height: 16),
          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final isPassed = index <= _stepIndex;
              final isCurrent = index == _stepIndex;

              return Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isPassed ? Appcolor.forest : Colors.grey.shade300,
                      border: isCurrent
                          ? Border.all(color: Appcolor.accentGold, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        isPassed ? Icons.check : Icons.circle,
                        size: isPassed ? 14 : 6,
                        color: isPassed ? Colors.white : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          if (riderName != null || destinationAddress != null) ...[
            const Divider(height: 32),
            if (riderName != null)
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Appcolor.forest.withValues(alpha: 0.15),
                    child: const Icon(
                      Icons.delivery_dining_rounded,
                      color: Appcolor.forest,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          riderName!,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Repartidor Oficial ORO',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onContactRider != null)
                    IconButton.filledTonal(
                      onPressed: onContactRider,
                      icon: const Icon(Icons.phone_outlined, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor:
                            Appcolor.forest.withValues(alpha: 0.12),
                        foregroundColor: Appcolor.forest,
                      ),
                    ),
                  if (onViewMap != null) ...[
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: onViewMap,
                      icon: const Icon(Icons.map_outlined, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: Appcolor.berry.withValues(alpha: 0.12),
                        foregroundColor: Appcolor.berry,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ],
      ),
    );
  }
}
