import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class VerifycodeData {
  Curd curd;
  VerifycodeData(this.curd);
  postData(String email, String veridycode) async {
    var resp = await curd.postData(AppLink.verifycode, {
      "email": email,
      "veridycode": veridycode,
    });
    return resp.fold((s) => s, (r) => r);
  }

  resendCode(String email) async {
    var resp = await curd.postData(AppLink.resendcode, {
      "email": email,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
