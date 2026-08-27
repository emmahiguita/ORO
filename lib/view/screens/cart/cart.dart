import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/cart/cartController.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/animations/animations.dart';
import 'package:oro/view/widgets/cart/cartfloatingbutton.dart';
import 'package:oro/view/widgets/cart/cartitem.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Carrito",
          style: TextStyle(
            color: OroColors.crystalWhite,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: OroColors.crystalWhite,
            size: 18,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<CartControllerImp>(
        init: CartControllerImp(),
        builder: (controller) => Stack(
          fit: StackFit.expand,
          children: [
            // 1. Fondo Global Selva Líquida
            Positioned.fill(
              child: Image.asset(
                'assets/images/store_liquid_jungle_background.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => Image.asset(
                  'images/store_liquid_jungle_background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => Container(
                    color: OroColors.nightBlue,
                  ),
                ),
              ),
            ),

            // 2. Capa de Protección Sutil
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: OroColors.protectionGradient,
                ),
              ),
            ),

            // 3. Lista de Items del Carrito
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
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
                                    OroMoney.format((controller.data[index].itemFinalPrice ?? controller.data[index].itemPrice ?? 0)),
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
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),

            // 4. Botón Flotante para Confirmar Pedido
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
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
