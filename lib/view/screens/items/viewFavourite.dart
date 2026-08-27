import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/ViewFavouritesController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/widgets/items/favouriteslist.dart';

class ViewFavourite extends StatelessWidget {
  const ViewFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Favoritos",
          style: TextStyle(
            color: OroColors.crystalWhite,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
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

          // 2. Capa de Protección Sutil
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: OroColors.protectionGradient,
              ),
            ),
          ),

          // 3. Lista de Favoritos en Liquid Glass
          SafeArea(
            child: GetBuilder<ViewFavouritesControllerImp>(
              init: ViewFavouritesControllerImp(),
              builder: (controller) => FavouritesList(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
