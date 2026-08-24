import 'package:get/get.dart';

vaildInput(String val, String type) {
  if (type == "username" || type == "username_or_email") {
    final clean = val.trim();
    if (clean.isEmpty) {
      return "Campo requerido";
    }
    if (clean.contains('@')) {
      if (!GetUtils.isEmail(clean)) {
        return "Correo electrónico no válido";
      }
    } else {
      if (clean.length < 3) {
        return "Usuario no válido";
      }
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Correo electrónico no válido";
    }
  }
  if (type == "password") {
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(val)) {
      return "Contraseña no válida";
    }
  }
  if (type == "PhoneNumber") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "Número de teléfono no válido";
    }
  }
}
