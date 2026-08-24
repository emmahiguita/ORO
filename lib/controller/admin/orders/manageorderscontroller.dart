import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/admindetails.dart';
import 'package:oro/view/screens/admin/orders/orderdetails.dart';

abstract class ManageOrdersController extends GetxController {
  getOrders();
  String getPaymentType(int paymentCode);
  String getOrderType(int typeCode);
  goToOrderDetails(String orderid, int index);
  approveOrder(String userid, String orderid);
  finishPreparing(String userid, String orderid, int orderType);
  markAsPickedUp(String userid, String orderid);
  cancelOrder(String userid, String orderid);
  archiveOrder(String userid, String orderid);
}

class ManageOrdersControllerImp extends ManageOrdersController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<AdminDetails> ordersDefault = [];
  List<AdminDetails> orders = [];
  int? currentFilter; // This tracks the current filter status
  int? activeSortType; // 0 = status, 1 = date ascending, 2 = date descending
  bool loading = false;
  bool cLoading = false;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  @override
  Future<void> getOrders() async {
    statusRequest = StatusRequest.loding;
    update();

    ordersDefault.clear();
    var response = await adminData.getOrders();
    statusRequest = handlingdata(response);

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        ordersDefault.addAll(data.map((e) => AdminDetails.fromJson(e)));

        applyFilterAndSort();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  void setFilter(int? status) {
    currentFilter = status;
    applyFilterAndSort();
    update();
  }

  void applyFilter() {
    if (currentFilter == null) {
      orders = List.from(ordersDefault);
    } else {
      orders = ordersDefault
          .where((order) => order.orderStatus == currentFilter)
          .toList();
    }
  }

  void applyFilterAndSort() {
    applyFilter();

    if (activeSortType != null) {
      switch (activeSortType) {
        case 0:
          orders.sort(
              (a, b) => (a.orderStatus ?? 0).compareTo(b.orderStatus ?? 0));
          break;
        case 1:
          orders.sort((a, b) => a.orderDatetime!.compareTo(b.orderDatetime!));
          break;
        case 2:
          orders.sort((a, b) => b.orderDatetime!.compareTo(a.orderDatetime!));
          break;
      }
    }
  }

  void sortByStatus() {
    activeSortType = activeSortType == 0 ? null : 0;
    applyFilterAndSort();
    update();
  }

  void sortByDate({bool ascending = true}) {
    activeSortType = ascending && activeSortType == 1
        ? null
        : !ascending && activeSortType == 2
            ? null
            : ascending
                ? 1
                : 2;
    applyFilterAndSort();
    update();
  }

  Future<void> refreshOrders() async {
    await getOrders();
  }

  @override
  getPaymentType(paymentCode) {
    switch (paymentCode) {
      case 0:
        return 'Visa';
      case 1:
        return 'Master Card';
      case 2:
        return 'American Express';
      case 3:
        return 'PayPal';
      case 4:
        return 'Cash';
      default:
        return 'Método de pago desconocido';
    }
  }

  @override
  getOrderType(typeCode) {
    switch (typeCode) {
      case 0:
        return 'Delivery';
      case 1:
        return 'Pick Up';
      default:
        return 'Unknown Order Method';
    }
  }

  @override
  goToOrderDetails(orderid, index) {
    AdminDetails orderDetail = orders[index];
    Get.to(() => const AdminOrderDetails(),
        arguments: {'orderid': orderid, 'orderDetail': orderDetail});
  }

  Color getStatusColor(double statusCode) {
    switch (statusCode) {
      case 0: // Pending
        return Colors.orange;
      case 1: // Preparing
        return Colors.blue;
      case 1.5:
        return Colors.pinkAccent;
      case -1: // Cancelled
        return Colors.red;
      case 2: // On the way
      case 3: // Delivered
        return Colors.purple;
      case 4: // Ready for pickup
        return Colors.green;
      case 5: // Picked up
        return Colors.teal;
      case 6: // Archived
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String getStatusText(double statusCode, int orderType) {
    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case 1.5:
        return 'Waiting for delivery';
      case -1:
        return 'Cancelado';
      case 5:
        return 'Picked Up';
      case 6:
        return 'Archived';
    }

    if (orderType == 0) {
      switch (statusCode) {
        case 2:
          return 'On The Way';
        case 3:
          return 'Entregado';
      }
    } else {
      if (statusCode == 4) return 'Ready for Pickup';
    }

    return 'Unknown Status';
  }

  @override
  approveOrder(userid, orderid) async {
    loading = true;
    update();
    var response = await adminData.approveOrder(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      await refreshOrders(); // Use refreshOrders instead of getOrders
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }

  @override
  finishPreparing(String userid, String orderid, orderType) async {
    loading = true;
    update();
    var response = await adminData.finishPreparing(orderid, userid, orderType);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      await refreshOrders(); // Use refreshOrders instead of getOrders
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }

  @override
  markAsPickedUp(String userid, String orderid) async {
    loading = true;
    update();
    var response = await adminData.markAsPickedUp(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      await refreshOrders(); // Use refreshOrders instead of getOrders
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }

  @override
  cancelOrder(String userid, String orderid) async {
    cLoading = true;
    update();
    var response = await adminData.cancelOrder(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      await refreshOrders(); // Use refreshOrders instead of getOrders
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    cLoading = false;
    update();
  }

  @override
  archiveOrder(String userid, String orderid) async {
    loading = true;
    update();
    var response = await adminData.archiveOrder(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      await refreshOrders(); // Use refreshOrders instead of getOrders
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }
}
