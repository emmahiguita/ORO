import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:oro/controller/resetpassword/verifyCodeController.dart';
import 'package:oro/core/class/handlingdatareq.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/auth/appbar.dart';
import 'package:oro/view/widgets/auth/button.dart';
import 'package:oro/view/widgets/auth/resendbutton.dart';
import 'package:oro/view/widgets/auth/titleText.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    Color accentPurpleColor = const Color(0xFF6A53A1);
    Color accentPinkColor = const Color(0xFFF99BBD);
    Color accentDarkGreenColor = const Color(0xFF115C49);
    Color accentYellowColor = const Color(0xFFFFB612);
    Color accentOrangeColor = const Color(0xFFEA7A3B);

    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.displaySmall
          ?.copyWith(color: color, fontFamily: "Sw");
    }

    String codes = "";

    Get.put(VerifyCodeControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Verificación',
            controller: Get.find<VerifyCodeControllerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<VerifyCodeControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10),
                  const AUTHTText(text: 'Ingresa el código de verificación'),
                  const SizedBox(height: 50),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: accentPurpleColor,
                    focusedBorderColor: Appcolor.lightblue,
                    styles: [
                      createStyle(accentPurpleColor),
                      createStyle(accentYellowColor),
                      createStyle(accentDarkGreenColor),
                      createStyle(accentOrangeColor),
                      createStyle(accentPinkColor),
                      createStyle(accentPurpleColor),
                    ],
                    showFieldAsBox: false,
                    borderWidth: 4.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      codes = code;
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      controller.verifyCode(verificationCode);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AUTHButton(
                    text: "Verificar",
                    ontap: () {
                      controller.verifyCode(codes);
                    },
                  ),
                  ResendButton(
                    onTap: () {
                      controller.resendCode();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
