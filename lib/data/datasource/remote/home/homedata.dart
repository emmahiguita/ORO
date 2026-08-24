import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class HomeData {
  Curd curd;
  HomeData(this.curd);
  postData() async {
    var resp = await curd.postData(AppLink.home, {});
    return resp.fold((s) => s, (r) => r);
  }
}
