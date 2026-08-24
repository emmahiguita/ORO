import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class ViewFavouritesData {
  Curd curd;
  ViewFavouritesData(this.curd);
  viewFavouritesData(
    String userId,
  ) async {
    var resp = await curd.postData(AppLink.favouritesView, {
      "id": userId,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
