import 'package:flutter/material.dart';
import 'package:oro/core/class/statusrequest.dart';

class CartFloatingButton extends StatelessWidget {
  final double price;
  final int shippingPrice;
  final void Function()? onTap;
  final StatusRequest statusRequest;
  final bool isDisabled;

  const CartFloatingButton({
    super.key,
    required this.price,
    required this.shippingPrice,
    this.statusRequest = StatusRequest.none,
    this.onTap,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        // Main content
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: .7)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .14),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: theme.textTheme.bodyMedium),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Costo de envío", style: theme.textTheme.bodyMedium),
                  Text(
                    "\$$shippingPrice",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: theme.colorScheme.outlineVariant),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total a Pagar",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${(price + shippingPrice).toStringAsFixed(2)}",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Material(
                color: isDisabled
                    ? theme.colorScheme.primary.withValues(alpha: 0.38)
                    : theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
                child: IgnorePointer(
                  ignoring: isDisabled,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(16),
                    splashColor:
                        theme.colorScheme.onPrimary.withValues(alpha: .16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        "Continuar con el pedido",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Loading overlay
        if (statusRequest == StatusRequest.loding)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
