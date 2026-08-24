import 'dart:io';

import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: "Atención",
    middleText: "¿Realmente deseas salir de la aplicación?",
    backgroundColor: Appcolor.white,
    buttonColor: Appcolor.berry,
    cancelTextColor: Appcolor.black,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      exit(0);
    },
  );
  return Future.value(true);
}
