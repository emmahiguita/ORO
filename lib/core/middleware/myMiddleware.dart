import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  final Services services = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final step = services.sharedPreferences.getString('step');
    final token = services.authToken;

    // Las sesiones antiguas de Sire no tenían token servidor. Forzamos un
    // nuevo login una sola vez para no dejar una sesión insegura o rota.
    if ((step == '2' || step == '3' || step == '4') &&
        (token == null || token.isEmpty)) {
      services.sharedPreferences.setString('step', '1');
      return const RouteSettings(name: Approutes.login);
    }

    if (step == '2') return const RouteSettings(name: Approutes.homescreen);
    if (step == '3') return const RouteSettings(name: Approutes.deliveryHome);
    if (step == '4') return const RouteSettings(name: Approutes.adminHome);
    if (step == '1') return const RouteSettings(name: Approutes.login);
    return null;
  }
}
