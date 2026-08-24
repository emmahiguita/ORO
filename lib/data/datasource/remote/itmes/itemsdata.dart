import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class Itemsdata {
  Curd curd;
  Itemsdata(this.curd);
  postData(String catId, String userid) async {
    var resp =
        await curd.postData(AppLink.items, {"id": catId, "userid": userid});
    return resp.fold((s) => s, (r) => r);
  }
}
