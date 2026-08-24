import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/auth/loginController.dart';
import 'package:oro/core/class/handlingdatareq.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/auth/appbar.dart';
import 'package:oro/view/widgets/auth/bodyText.dart';
import 'package:oro/view/widgets/auth/button.dart';
import 'package:oro/view/widgets/auth/doordont.dart';
import 'package:oro/view/widgets/auth/restremember.dart';
import 'package:oro/core/constant/imageasset.dart';
import 'package:oro/view/widgets/auth/textForm.dart';
import 'package:oro/view/widgets/auth/titleText.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogincontrollerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Iniciar sesión',
            controller: Get.find<LogincontrollerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            alertExitApp();
          },
          child: GetBuilder<LogincontrollerImp>(
            builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: controller.formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Appcolor.berry.withValues(alpha: 0.12),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              AppImage.authLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const AUTHTText(text: 'Bienvenido'),
                        const SizedBox(height: 10),
                        const AUTHBText(
                          text:
                              'Inicia sesión con tu usuario y contraseña para continuar',
                        ),
                        const SizedBox(height: 24),
                        AUTHForm(
                            type: "username_or_email",
                            validator: (p0) {
                              return vaildInput(p0!, "username_or_email");
                            },
                            controller: controller.username,
                            label: 'Usuario o Correo',
                            icon: Icons.person_outline,
                            hint: 'Ingresa tu usuario o correo'),
                        GetBuilder<LogincontrollerImp>(
                          builder: (controller) => AUTHForm(
                              obscureText: controller.obscureText,
                              onTap: () {
                                controller.showPassword();
                              },
                              type: "password",
                              validator: (p0) {
                                return vaildInput(p0!, "password");
                              },
                              controller: controller.password,
                              label: 'Contraseña',
                              icon: controller.obscureText
                                  ? Icons.lock_outlined
                                  : Icons.lock_open_outlined,
                              hint: 'Ingresa tu contraseña'),
                        ),
                        Restremember(
                          onTap: () {
                            controller.goToForgotPassword();
                          },
                          rememberMe: controller.rememberMe,
                          onChanged: (bool? value) {
                            controller.changeLoginRemember(value!);
                          },
                        ),
                        AUTHButton(
                          text: "Continuar",
                          ontap: () {
                            controller.login();
                          },
                        ),
                        const SizedBox(height: 14),
                        OutlinedButton.icon(
                          onPressed: () {
                            controller.enterOfflineDemoMode(0);
                          },
                          icon: const Icon(Icons.cloud_off_rounded, size: 18),
                          label: const Text(
                            "Explorar sin conexión (Modo Offline)",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Appcolor.berry,
                            side: const BorderSide(
                                color: Appcolor.berry, width: 1.2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        dodont(
                          auth: "Regístrate",
                          text: "¿No tienes una cuenta? ",
                          onTap: () {
                            controller.goToSignUp();
                          },
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }
}
