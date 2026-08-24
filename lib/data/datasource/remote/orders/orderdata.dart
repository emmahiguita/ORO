import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class OrderData {
  Curd curd;
  OrderData(this.curd);
  getPendingOrders(String userid) async {
    var resp = await curd.postData(AppLink.viewPendingOrders, {
      "userID": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getArchivedOrders(String userid) async {
    var resp = await curd.postData(AppLink.viewArchivedOrders, {
      "userID": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getOrderDetails(String userid, String orderid) async {
    var resp = await curd.postData(AppLink.getOrderDetails, {
      "userID": userid,
      "orderID": orderid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  cancelorder(String orderid) async {
    var resp = await curd.postData(AppLink.cancelOrder, {
      "orderid": orderid,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
