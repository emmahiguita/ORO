import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class RatingData {
  Curd curd;
  RatingData(this.curd);
  addRating(String userid, String itemid, String stars, String comment) async {
    var resp = await curd.postData(AppLink.addRating, {
      "userid": userid,
      "itemid": itemid,
      "stars": stars,
      "comment": comment,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getRating(String itemid) async {
    var resp = await curd.postData(AppLink.getRating, {
      "itemid": itemid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  isOrdered(String userid, String itemid) async {
    var resp = await curd.postData(AppLink.getIsOrdered, {
      "userid": userid,
      "itemid": itemid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  deleteRating(String userid, String rateid) async {
    var resp = await curd.postData(AppLink.deleteRating, {
      "userid": userid,
      "rateid": rateid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  viewAllRating(String userId) async {
    var resp = await curd.postData(AppLink.viewAllRating, {
      "userId": userId,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
