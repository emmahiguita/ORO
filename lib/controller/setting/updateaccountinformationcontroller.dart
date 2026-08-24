import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/adminsettingscontroller.dart';
import 'package:oro/controller/delivery/deliverysettingscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/addimage.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/settings/settingsdata.dart';
import 'package:oro/view/screens/auth/verifycodesignup.dart';

abstract class UpdateAccountInformationController extends GetxController {
  updateAccountInformation();
}

class UpdateAccountInformationControllerImp
    extends UpdateAccountInformationController {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  final SettingsData settingsData = SettingsData(Get.find());
  final Services services = Get.find();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController currentPassword;
  late TextEditingController newPassword;
  String oldpfp = 'default.png';
  String oldbanner = 'default.png';
  String key = '0';
  File? pfp;
  File? banner;

  Future<File?> getImageByGallery(File? file, bool isProfile) async {
    file = await uploadImage();
    if (file != null) {
      file = isProfile
          ? await cropImageWithRatio(file, 1, 1, 'Recortar foto de perfil')
          : await cropImageWithRatio(file, 3, 1, 'Recortar portada');
    }
    update();
    return file;
  }

  Future<File?> getImageByCamera(File? file, bool isProfile) async {
    file = await pickImageFromCamera();
    if (file != null) {
      file = isProfile
          ? await cropImageWithRatio(file, 1, 1, 'Recortar foto de perfil')
          : await cropImageWithRatio(file, 3, 1, 'Recortar portada');
    }
    update();
    return file;
  }

  @override
  void onInit() {
    username = TextEditingController(
        text: services.sharedPreferences.getString('username') ?? '');
    email = TextEditingController(
        text: services.sharedPreferences.getString('email') ?? '');
    phoneNumber = TextEditingController(
        text: services.sharedPreferences.getString('phone') ?? '');
    currentPassword = TextEditingController();
    newPassword = TextEditingController();
    oldpfp = services.sharedPreferences.getString('pfp') ?? 'default.png';
    oldbanner = services.sharedPreferences.getString('banner') ?? 'default.png';
    key = services.sharedPreferences.getString('key') ?? '0';
    super.onInit();
  }

  @override
  Future<void> updateAccountInformation() async {
    if (!(globalKey.currentState?.validate() ?? false)) return;
    final oldEmail = services.sharedPreferences.getString('email') ?? '';
    final sensitiveChange = newPassword.text.isNotEmpty ||
        email.text.trim().toLowerCase() != oldEmail.toLowerCase();
    if (sensitiveChange && currentPassword.text.isEmpty) {
      Get.snackbar('Confirma tu identidad',
          'Ingresa tu contraseña actual para cambiar el correo o la contraseña.');
      return;
    }

    statusRequest = StatusRequest.loding;
    update();
    final response = await settingsData.updateAccountInformation(
      services.sharedPreferences.getString('id') ?? '',
      username.text.trim(),
      email.text.trim(),
      phoneNumber.text.trim(),
      currentPassword.text,
      newPassword.text,
      oldpfp,
      oldbanner,
      pfp,
      banner,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success' && response['data'] is Map) {
        final data = response['data'] as Map;
        services.sharedPreferences.setString(
            'username', '${data['user_name'] ?? username.text.trim()}');
        services.sharedPreferences
            .setString('email', '${data['user_email'] ?? email.text.trim()}');
        services.sharedPreferences.setString(
            'phone', '${data['user_phone'] ?? phoneNumber.text.trim()}');
        services.sharedPreferences
            .setString('pfp', '${data['user_pfp'] ?? oldpfp}');
        services.sharedPreferences
            .setString('banner', '${data['user_banner'] ?? oldbanner}');

        final token = response['token'];
        if (token is String && token.isNotEmpty)
          await services.setAuthToken(token);

        if (response['requires_verification'] == true && key == '0') {
          await services.unregisterPushToken();
          await services.clearAuthToken();
          services.sharedPreferences.setString('approve', '0');
          services.sharedPreferences.setString('step', '1');
          Get.offAll(
            () => const VerifyCodeSignUp(),
            arguments: {'email': '${data['user_email'] ?? email.text.trim()}'},
          );
          return;
        }

        if (key == '1' && Get.isRegistered<DeliverySettingsControllerImp>()) {
          Get.find<DeliverySettingsControllerImp>().updateAccount();
        } else if (key == '2' &&
            Get.isRegistered<AdminSettingsControllerImp>()) {
          Get.find<AdminSettingsControllerImp>().updateAccount();
        }
        Get.back();
        Get.snackbar('Cambios guardados',
            'La información de tu cuenta fue actualizada.');
      } else {
        statusRequest = StatusRequest.failure;
        final errors = response['errors'];
        final currentPasswordFailed =
            errors is List && errors.contains('currentpasswordfail');
        Get.defaultDialog(
          title: 'No pudimos guardar los cambios',
          middleText: currentPasswordFailed
              ? 'La contraseña actual no es correcta.'
              : 'Revisa los datos ingresados. El correo, usuario o teléfono pueden estar en uso.',
        );
      }
    }
    update();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    currentPassword.dispose();
    newPassword.dispose();
    super.onClose();
  }
}
