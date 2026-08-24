import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class CartData {
  Curd curd;
  CartData(this.curd);
  cartAdd(String userId, String itemId) async {
    var resp = await curd.postData(AppLink.cartAdd, {
      "userId": userId,
      "itemId": itemId,
    });
    return resp.fold((s) => s, (r) => r);
  }

  cartDelete(String userId, String itemId) async {
    var resp = await curd.postData(AppLink.cartDelete, {
      "userId": userId,
      "itemId": itemId,
    });
    return resp.fold((s) => s, (r) => r);
  }

  cartCount(String userId, String itemId) async {
    var resp = await curd.postData(AppLink.cartCount, {
      "userId": userId,
      "itemId": itemId,
    });
    return resp.fold((s) => s, (r) => r);
  }

  cartView(String userId) async {
    var resp = await curd.postData(AppLink.cartView, {
      "userId": userId,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
