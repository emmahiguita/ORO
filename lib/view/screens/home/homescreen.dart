import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/view/screens/cart/cart.dart';
import 'package:oro/view/widgets/home/custombottomnavigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      init: Get.isRegistered<HomeScreenControllerImp>()
          ? Get.find<HomeScreenControllerImp>()
          : Get.put(HomeScreenControllerImp()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: OroColors.nightBlue,
          extendBody: true,
          floatingActionButton: SizedBox(
            width: 52,
            height: 52,
            child: FloatingActionButton(
              elevation: 8,
              tooltip: 'open_cart'.tr,
              backgroundColor: OroColors.forest,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
                side: const BorderSide(
                  color: OroColors.turquoise,
                  width: 1.5,
                ),
              ),
              onPressed: () {
                Get.to(
                  () => const Cart(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: const Icon(Icons.shopping_bag_outlined, size: 24),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomNavigationBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // ── 1. Fondo Global Único en la Raíz de la Tienda (Por debajo) ──
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

              // ── 2. Velo Oscuro Protector para Garantizar Lectura Completa ──
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x73071420), // 45% opacidad
                        Color(0x99071420), // 60% opacidad
                        Color(0xCC071420), // 80% opacidad
                      ],
                    ),
                  ),
                ),
              ),

              // ── 3. Pantallas Principales Flotando con IndexedStack ──────────
              Positioned.fill(
                child: PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {
                    alertExitApp();
                  },
                  child: IndexedStack(
                    index: controller.currentpage,
                    children: controller.listpages,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
