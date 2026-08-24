import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class LoginData {
  Curd curd;
  LoginData(this.curd);
  postData(String username, String password) async {
    var resp = await curd.postData(AppLink.login, {
      "username": username,
      "password": password,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
