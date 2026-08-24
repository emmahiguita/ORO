import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class CheckEmailData {
  Curd curd;
  CheckEmailData(this.curd);
  postData(String email) async {
    var resp = await curd.postData(AppLink.checkemail, {
      "email": email,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
