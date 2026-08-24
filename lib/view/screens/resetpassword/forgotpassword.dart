import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/resetpassword/forgotController.dart';
import 'package:oro/core/class/handlingdatareq.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/constant/imageasset.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/auth/appbar.dart';
import 'package:oro/view/widgets/auth/button.dart';
import 'package:oro/view/widgets/auth/textForm.dart';
import 'package:oro/view/widgets/auth/titleText.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordcontrollerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Recuperar contraseña',
            controller: Get.find<ForgotPasswordcontrollerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<ForgotPasswordcontrollerImp>(
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
                          Image.asset(
                            AppImage.authforgotpassword,
                            height: 200,
                          ),
                          const SizedBox(height: 10),
                          const AUTHTText(text: 'Ingresa tu correo electrónico'),
                          const SizedBox(height: 50),
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
                          AUTHButton(
                            text: "Enviar",
                            ontap: () {
                              controller.forgotPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
