import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';
import 'package:oro/core/class/statusrequest.dart';

class SettingsData {
  final Curd curd;
  SettingsData(this.curd);

  Future<dynamic> updateAccountInformation(
    String id,
    String username,
    String email,
    String phonenumber,
    String currentPassword,
    String newPassword,
    String oldpfp,
    String oldbanner,
    File? pfp,
    File? banner,
  ) async {
    final data = {
      'id': id,
      'username': username,
      'email': email,
      'phonenumber': phonenumber,
      'currentpassword': currentPassword,
      'password': newPassword,
      'oldpfp': oldpfp,
      'oldbanner': oldbanner,
    };
    Either<StatusRequest, Map> resp;
    if (pfp == null && banner == null) {
      resp = await curd.postData(AppLink.updateAccountInformation, data);
    } else {
      resp = await curd.addRequestWithTwoImages(
        AppLink.updateAccountInformation,
        data,
        pfp,
        banner,
      );
    }
    return resp.fold((s) => s, (r) => r);
  }
}
