import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/widgets/items/bottombar.dart';
import 'package:oro/view/widgets/items/comparable_products_section.dart';
import 'package:oro/view/widgets/items/productdetailsappbartitle.dart';
import 'package:oro/view/widgets/items/productimagesection.dart';
import 'package:oro/view/widgets/items/productinfocard.dart';
import 'package:oro/view/widgets/items/reviewsection.dart';
import 'package:oro/view/widgets/items/sharebutton.dart';
import 'package:oro/view/widgets/items/specificationscard.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsDetailsControllerImp>(
      init: ItemsDetailsControllerImp(),
      builder: (controller) {
        if (controller.data == null) {
          return const Scaffold(
            backgroundColor: OroColors.nightBlue,
            body: Center(
              child: CircularProgressIndicator(
                color: OroColors.turquoise,
              ),
            ),
          );
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: OroColors.nightBlue.withValues(alpha: 0.65),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: OroColors.crystalWhite,
                  size: 18,
                ),
              ),
              onPressed: () => Get.back(),
            ),
            title: const ProductDetailsAppBarTitle(),
            centerTitle: true,
            actions: [ShareButton(controller: controller)],
          ),
          body: Stack(
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

              // 2. Capa de Protección Gradiente Vertical
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: OroColors.protectionGradient,
                  ),
                ),
              ),

              // 3. Contenido Scrollable del Producto
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: ProductImageSection(controller: controller),
                  ),
                  SliverToBoxAdapter(
                    child: ProductInfoCard(controller: controller),
                  ),
                  SliverToBoxAdapter(
                    child: SpecificationsCard(controller: controller),
                  ),
                  SliverToBoxAdapter(
                    child: ComparableProductsSection(controller: controller),
                  ),
                  SliverToBoxAdapter(
                    child: ReviewSection(controller: controller),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 120),
                  ),
                ],
              ),
            ],
          ),
          bottomSheet: BottomBar(controller: controller),
        );
      },
    );
  }
}

