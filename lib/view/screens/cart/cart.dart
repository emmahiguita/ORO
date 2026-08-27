import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/cart/cartController.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/animations/animations.dart';
import 'package:oro/view/widgets/cart/cartfloatingbutton.dart';
import 'package:oro/view/widgets/cart/cartitem.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Carrito"),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: GetBuilder<CartControllerImp>(
        init: CartControllerImp(),
        builder: (controller) => Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  controller.data.isNotEmpty
                      ? Column(
                          children: List.generate(
                            controller.data.length,
                            (index) => CartItem(
                              img: controller.data[index].itemImg ?? '',
                              itemName: databaseTranslation(
                                controller.data[index].itemName,
                                controller.data[index].itemNameAr,
                                controller.data[index].itemNameEs,
                              ),
                              itemCategory: databaseTranslation(
                                controller.data[index].categoryName,
                                controller.data[index].categoryNameAr,
                                controller.data[index].categoryNameEs,
                              ),
                              itemPrice:
                                  "\$${(controller.data[index].itemFinalPrice ?? controller.data[index].itemPrice ?? 0).toStringAsFixed(2)}",
                              itemCount:
                                  controller.data[index].countitems.toString(),
                              onAdd: () => controller.add(
                                  "${controller.data[index].itemId}", index),
                              onRemove: () => controller.remove(
                                  "${controller.data[index].itemId}", index),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: OroEmptyCart(
                            onExplorePressed: () {
                              Get.offAllNamed(Approutes.homescreen);
                            },
                          ),
                        ),
                  const SizedBox(height: 220),
                ],
              ),
            ),
            if (controller.data.isNotEmpty)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Tooltip(
                  message: controller.isNotVerified
                      ? "Verifica tu cuenta para realizar pedidos"
                      : "Continuar con el Pedido",
                  child: CartFloatingButton(
                      statusRequest: controller.statusRequest,
                      price: controller.totalprice,
                      shippingPrice: 10,
                      isDisabled:
                          controller.data.isEmpty || controller.isNotVerified,
                      onTap: () {
                        controller.placeOrder();
                      }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
