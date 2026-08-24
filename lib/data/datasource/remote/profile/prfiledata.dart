import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class ProfileData {
  Curd curd;
  ProfileData(this.curd);

  getCountOrders(String userid) async {
    var resp = await curd.postData(AppLink.getTotalOrders, {"id": userid});
    return resp.fold((s) => s, (r) => r);
  }
}
