import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:oro/controller/setting/settingcontroller.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/SectionHeader.dart';
import 'package:oro/view/widgets/settings/contactdialog.dart';
import 'package:oro/view/widgets/settings/logoutbutton.dart';
import 'package:oro/view/widgets/settings/notificationtile.dart';
import 'package:oro/view/widgets/settings/settingstile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<SettingControllerImp>(
      init: SettingControllerImp(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 100,
                floating: false,
                pinned: true,
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Ajustes',
                    style: TextStyle(
                      color: isDark ? Colors.white : Appcolor.berry,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),

              // Settings Content
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.03)
                        : const Color.fromARGB(245, 245, 245, 245),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Preferences Section
                      const SectionHeader(title: 'Preferencias'),
                      const SizedBox(height: 15),

                      // Notification Toggle
                      GetBuilder<SettingControllerImp>(
                        builder: (controller) =>
                            NotificationTile(controller: controller),
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Idiomas",
                        icon: Icons.language,
                        iconColor: Appcolor.indigoBlue,
                        onTap: () => controller.changeLanguages(),
                      ),

                      const SizedBox(height: 25),

                      // Account Section
                      const SectionHeader(title: 'Cuenta'),
                      const SizedBox(height: 15),

                      SettingsTile(
                        title: "Tus valoraciones",
                        icon: Iconsax.heart,
                        iconColor: Appcolor.deepRed,
                        onTap: () => controller.goToAllRating(),
                      ),

                      const SizedBox(height: 10),

                      if (controller.isApprove != true) ...[
                        SettingsTile(
                          title: "Verifica tu cuenta",
                          subtitle:
                              "Completa la verificación para acceder a todas las funciones",
                          icon: Icons.verified,
                          iconColor: Appcolor.lightRed,
                          showBadge: true,
                          onTap: () => controller.goToVerify(),
                        ),
                        const SizedBox(height: 10),
                      ],

                      SettingsTile(
                        title: "Direcciones de Entrega",
                        icon: Icons.location_on_rounded,
                        iconColor: Appcolor.amaranthpink,
                        onTap: () => controller.goToAddress(),
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Editar Información de la Cuenta",
                        icon: Icons.edit,
                        iconColor: Appcolor.teal,
                        onTap: () => controller.goToUpdateAccountInformation(),
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Video de Presentación ORO",
                        subtitle: "Ver video cinemático oficial",
                        icon: Icons.play_circle_fill_rounded,
                        iconColor: Appcolor.berry,
                        onTap: () => Get.toNamed(Approutes.introVideo),
                      ),

                      const SizedBox(height: 25),

                      // Support Section
                      const SectionHeader(title: 'Soporte y Marca'),
                      const SizedBox(height: 15),

                      SettingsTile(
                        title: "Acerca de ORO",
                        subtitle: "Plataforma de comercio premium",
                        icon: Icons.info_outline,
                        iconColor: Appcolor.berry,
                        onTap: () {
                          Get.defaultDialog(
                            title: "ORO Commerce",
                            middleText:
                                "Plataforma de comercio de alta fidelidad desarrollada para una experiencia de compra fluida, rápida y segura.\n\nVersión 1.0.0",
                            textConfirm: "Aceptar",
                            confirmTextColor: Colors.white,
                            buttonColor: Appcolor.berry,
                            onConfirm: () => Get.back(),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Contáctanos",
                        subtitle: "Obtén ayuda y soporte personalizado",
                        icon: Icons.phone_rounded,
                        iconColor: Appcolor.indigoBlue,
                        onTap: () => ContactDialog.show(controller),
                      ),

                      const SizedBox(height: 25),

                      // Logout Button
                      LogoutButton(controller: controller),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
