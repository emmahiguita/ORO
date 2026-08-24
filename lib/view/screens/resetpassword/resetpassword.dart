import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/resetpassword/RestPasswordController.dart';
import 'package:oro/core/class/handlingdatareq.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/auth/appbar.dart';
import 'package:oro/view/widgets/auth/button.dart';
import 'package:oro/view/widgets/auth/textForm.dart';
import 'package:oro/view/widgets/auth/titleText.dart';

class RestPassword extends StatelessWidget {
  const RestPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RestPasswordControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Restablecer contraseña',
            controller: Get.find<RestPasswordControllerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<RestPasswordControllerImp>(
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
                          const AUTHTText(text: 'Bienvenido'),
                          const SizedBox(height: 50),
                          GetBuilder<RestPasswordControllerImp>(
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
                                    icon: Icons.lock_outlined,
                                    hint: 'Ingresa tu contraseña',
                                  )),
                          GetBuilder<RestPasswordControllerImp>(
                              builder: (controller) => AUTHForm(
                                    obscureText: controller.obscureText2,
                                    onTap: () {
                                      controller.showPassword2();
                                    },
                                    type: "password",
                                    validator: (p0) {
                                      return vaildInput(p0!, "password");
                                    },
                                    controller: controller.repassword,
                                    label: 'Contraseña',
                                    icon: Icons.lock_open_outlined,
                                    hint: 'Confirma tu contraseña',
                                  )),
                          AUTHButton(
                            text: "Continuar",
                            ontap: () {
                              controller.restPassword();
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
