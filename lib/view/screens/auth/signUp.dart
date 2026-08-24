import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/auth/signUpController.dart';
import 'package:oro/core/class/handlingdatareq.dart';

import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/alertexitapp.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/auth/appbar.dart';
import 'package:oro/view/widgets/auth/bodyText.dart';
import 'package:oro/view/widgets/auth/button.dart';
import 'package:oro/view/widgets/auth/doordont.dart';
import 'package:oro/core/constant/imageasset.dart';
import 'package:oro/view/widgets/auth/textForm.dart';
import 'package:oro/view/widgets/auth/titleText.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpcontrollerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AUTHAppbar(
          text: 'Crear cuenta',
          controller: Get.find<SignUpcontrollerImp>(),
          statusRequest: (controller) => controller.statusRequest),
      body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            alertExitApp();
          },
          child: GetBuilder<SignUpcontrollerImp>(
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
                                  'Regístrate con tu correo y contraseña para comenzar',
                            ),
                            const SizedBox(height: 24),
                            AUTHForm(
                              type: "usernam",
                              validator: (p0) {
                                return vaildInput(p0!, "username");
                              },
                              controller: controller.username,
                              label: 'Usuario',
                              icon: Icons.person_2_outlined,
                              hint: 'Ingresa tu usuario',
                            ),
                            AUTHForm(
                              type: "email",
                              validator: (p0) {
                                return vaildInput(p0!, "email");
                              },
                              controller: controller.email,
                              label: 'Correo electrónico',
                              icon: Icons.email_outlined,
                              hint: 'Ingresa tu correo electrónico',
                            ),
                            AUTHForm(
                              type: "phone",
                              validator: (p0) {
                                return vaildInput(p0!, "PhoneNumber");
                              },
                              controller: controller.phoneNumber,
                              label: 'Número de teléfono',
                              icon: Icons.phone_android_outlined,
                              hint: 'Ingresa tu teléfono',
                            ),
                            GetBuilder<SignUpcontrollerImp>(
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
                            AUTHButton(
                              text: "Continuar",
                              ontap: () {
                                controller.signUp();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            dodont(
                              text: "¿Ya tienes una cuenta? ",
                              auth: "Iniciar sesión",
                              onTap: () {
                                controller.goToLogin();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ))),
    );
  }
}
