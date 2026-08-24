import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class SignUpData {
  Curd curd = Curd();
  SignUpData(this.curd);
  postData(String username, String email, String phoneNumber,
      String password) async {
    var resp = await curd.postData(AppLink.signup, {
      "username": username,
      "email": email,
      "phonenumber": phoneNumber,
      "password": password,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
