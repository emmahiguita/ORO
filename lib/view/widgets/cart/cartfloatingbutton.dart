import 'package:flutter/material.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';

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
    return Stack(
      children: [
        // Main content
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Appcolor.dustyPink,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Appcolor.blackShadow,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal"),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontFamily: "Sw",
                      color: Appcolor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Costo de Envío"),
                  Text(
                    "\$$shippingPrice",
                    style: const TextStyle(
                      fontFamily: "Sw",
                      color: Appcolor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Appcolor.black,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total a Pagar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${(price + shippingPrice).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontFamily: "Sw",
                      color: Appcolor.berry,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Material(
                color: isDisabled
                    ? Appcolor.berry.withValues(alpha: 0.4)
                    : Appcolor.berry,
                borderRadius: BorderRadius.circular(10),
                child: IgnorePointer(
                  ignoring: isDisabled,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Appcolor.shadowWhite,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: const Text(
                        "Continuar con el Pedido",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                borderRadius: BorderRadius.circular(10),
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
