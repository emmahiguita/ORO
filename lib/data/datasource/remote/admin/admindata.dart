import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';
import 'package:oro/core/class/statusrequest.dart';

class AdminData {
  Curd curd;
  AdminData(this.curd);
  getCategories() async {
    var resp = await curd.postData(AppLink.getCategories, {});
    return resp.fold((s) => s, (r) => r);
  }

  addCategory(
    String categoryName,
    String categoryNameAr,
    String categoryNameEs,
    File file,
  ) async {
    var resp = await curd.addRequestWithImageOne(
      AppLink.addCategories,
      {
        "nameen": categoryName,
        "namear": categoryNameAr,
        "namees": categoryNameEs,
      },
      file,
    );
    return resp.fold((s) => s, (r) => r);
  }

  deleteCategory(String id, String imgname) async {
    var resp = await curd.postData(AppLink.deleteCategories, {
      "id": id,
      "imgname": imgname,
    });
    return resp.fold((s) => s, (r) => r);
  }

  updateCategory(
    String id,
    String categoryName,
    String categoryNameAr,
    String categoryNameEs,
    File? file,
    String oldimg,
  ) async {
    Either<StatusRequest, Map> resp;
    if (file == null) {
      resp = await curd.postData(AppLink.updateCategories, {
        "id": id,
        "nameen": categoryName,
        "namear": categoryNameAr,
        "namees": categoryNameEs,
      });
    } else {
      resp = await curd.addRequestWithImageOne(
        AppLink.updateCategories,
        {
          "id": id,
          "nameen": categoryName,
          "namear": categoryNameAr,
          "namees": categoryNameEs,
          "oldimg": oldimg,
        },
        file,
      );
    }

    return resp.fold((s) => s, (r) => r);
  }

  getItems() async {
    var resp = await curd.postData(AppLink.getItems, {});
    return resp.fold((s) => s, (r) => r);
  }

  addItem(
    String name,
    String namear,
    String namees,
    String desc,
    String descar,
    String desces,
    String count,
    String active,
    String price,
    String discount,
    String catgoryId,
    File file,
  ) async {
    var resp = await curd.addRequestWithImageOne(
      AppLink.addItems,
      {
        "name": name,
        "namear": namear,
        "namees": namees,
        "desc": desc,
        "descar": descar,
        "desces": desces,
        "count": count,
        "active": active,
        "price": price,
        "discount": discount,
        "catid": catgoryId,
      },
      file,
    );
    return resp.fold((s) => s, (r) => r);
  }

  deleteItem(String id, String imgname) async {
    var resp = await curd.postData(AppLink.deleteItems, {
      "id": id,
      "imgname": imgname,
    });
    return resp.fold((s) => s, (r) => r);
  }

  updateItem(
    String id,
    String name,
    String namear,
    String namees,
    String desc,
    String descar,
    String desces,
    String count,
    String active,
    String price,
    String discount,
    String catgoryId,
    File? file,
    String oldimg,
  ) async {
    Either<StatusRequest, Map> resp;
    if (file == null) {
      resp = await curd.postData(AppLink.updateItems, {
        "id": id,
        "name": name,
        "namear": namear,
        "namees": namees,
        "desc": desc,
        "descar": descar,
        "desces": desces,
        "count": count,
        "active": active,
        "price": price,
        "discount": discount,
        "catid": catgoryId
      });
    } else {
      resp = await curd.addRequestWithImageOne(
          AppLink.updateItems,
          {
            "id": id,
            "name": name,
            "namear": namear,
            "namees": namees,
            "desc": desc,
            "descar": descar,
            "desces": desces,
            "count": count,
            "active": active,
            "price": price,
            "discount": discount,
            "catid": catgoryId,
            "oldimg": oldimg,
          },
          file);
    }
    return resp.fold((s) => s, (r) => r);
  }

  getOrders() async {
    var resp = await curd.postData(AppLink.getOrders, {});
    return resp.fold((s) => s, (r) => r);
  }

  getOrderDetails(String orderid) async {
    var resp = await curd.postData(AppLink.adminOrderDetails, {
      "orderid": orderid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  approveOrder(String orderid, String userid) async {
    var resp = await curd.postData(AppLink.approveOrder, {
      "orderid": orderid,
      "userid": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  finishPreparing(String orderid, String userid, int orderType) async {
    Either<StatusRequest, Map> resp;
    orderType == 0
        ? resp = await curd.postData(AppLink.informdelivery, {
            "orderid": orderid,
            "userid": userid,
          })
        : resp = await curd.postData(AppLink.readytopickup, {
            "orderid": orderid,
            "userid": userid,
          });
    return resp.fold((s) => s, (r) => r);
  }

  markAsPickedUp(String orderid, String userid) async {
    var resp = await curd.postData(AppLink.userpickedup, {
      "orderid": orderid,
      "userid": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  cancelOrder(String orderid, String userid) async {
    var resp = await curd.postData(AppLink.cancelOrder, {
      "orderid": orderid,
      "userid": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  archiveOrder(String orderid, String userid) async {
    var resp = await curd.postData(AppLink.archiveOrder, {
      "orderid": orderid,
      "userid": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getDashboardInfo() async {
    var resp = await curd.postData(AppLink.dashboardInfo, {});
    return resp.fold((s) => s, (r) => r);
  }

  getCoupons() async {
    var resp = await curd.postData(AppLink.getCoupons, {});
    return resp.fold((s) => s, (r) => r);
  }

  addCoupon(
    String code,
    String count,
    String discount,
    String expirydate,
  ) async {
    var resp = await curd.postData(AppLink.addCoupon, {
      "code": code,
      "count": count,
      "discount": discount,
      "expirydate": expirydate,
    });
    return resp.fold((s) => s, (r) => r);
  }

  editCoupon(
    String id,
    String code,
    String count,
    String discount,
    String expirydate,
  ) async {
    var resp = await curd.postData(AppLink.editCoupon, {
      "id": id,
      "code": code,
      "count": count,
      "discount": discount,
      "expirydate": expirydate,
    });
    return resp.fold((s) => s, (r) => r);
  }

  announceCoupon(String title, String body, File file) async {
    var resp = await curd.addRequestWithImageOne(
      AppLink.announceCoupon,
      {
        "title": title,
        "body": body,
      },
      file,
    );
    return resp.fold((s) => s, (r) => r);
  }

  getOfferMessage() async {
    var resp = await curd.postData(AppLink.getOfferMessage, {});
    return resp.fold((s) => s, (r) => r);
  }

  editOfferMessage(String title, String body, String oldimg, File? file) async {
    Either<StatusRequest, Map> resp;
    if (file == null) {
      resp = await curd.postData(AppLink.editOfferMessage, {
        "title": title,
        "body": body,
      });
    } else {
      resp = await curd.addRequestWithImageOne(
          AppLink.editOfferMessage,
          {
            "title": title,
            "body": body,
            "oldimg": oldimg,
          },
          file);
    }
    return resp.fold((s) => s, (r) => r);
  }

  createNewDeliveryAccount(
    String username,
    String email,
    String phoneNumber,
    String password,
  ) async {
    var resp = await curd.postData(AppLink.createNewDeliveryAccount, {
      "username": username,
      "email": email,
      "phonenumber": phoneNumber,
      "password": password,
    });
    return resp.fold((s) => s, (r) => r);
  }

  createNewAdminAccount(
    String username,
    String email,
    String phoneNumber,
    String password,
  ) async {
    var resp = await curd.postData(AppLink.createNewAdminAccount, {
      "username": username,
      "email": email,
      "phonenumber": phoneNumber,
      "password": password,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
