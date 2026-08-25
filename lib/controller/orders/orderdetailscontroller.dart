import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/orders/orderdata.dart';
import 'package:oro/data/model/orderdetailsmodel.dart';

abstract class OrderDetailsController extends GetxController {
  getOrderDetails(orderid);
  getStatusColor(int status, int orderType);
  getStatusText(int statusCode, int orderType);
}

class OrderDetailsControllerImp extends OrderDetailsController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  OrderData orderData = OrderData(Get.find());

  List<OrderDetailsModel> orderDetails = [];

  String? orderid;

  Set<Marker>? markers;

  @override
  getOrderDetails(orderid) async {
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await orderData.getOrderDetails(
        services.userId, orderid?.toString() ?? "");
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        orderDetails.addAll(
          data.map(
            (e) => OrderDetailsModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    orderid = Get.arguments["orderid"];

    getOrderDetails(orderid);
    super.onInit();
  }

  @override
  String getStatusText(int statusCode, int orderType) {
    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case -1:
        return 'Cancelado';
      case 5:
        return 'User Picked Up';
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

  List<Map<String, dynamic>> getSteps(int orderType) {
    if (orderType == 0) {
      return [
        {'title': getStatusText(0, orderType), 'icon': Icons.access_time},
        {'title': getStatusText(1, orderType), 'icon': Icons.build},
        {'title': getStatusText(2, orderType), 'icon': Icons.delivery_dining},
        {'title': getStatusText(3, orderType), 'icon': Icons.check_circle},
        if (orderDetails[0].orderStatus == 6)
          {'title': getStatusText(6, orderType), 'icon': Icons.archive},
      ];
    } else {
      return [
        {'title': getStatusText(0, orderType), 'icon': Icons.access_time},
        {'title': getStatusText(1, orderType), 'icon': Icons.restaurant},
        {'title': getStatusText(4, orderType), 'icon': Icons.store},
        {'title': getStatusText(5, orderType), 'icon': Icons.check_circle},
        if (orderDetails[0].orderStatus == 6)
          {'title': getStatusText(6, orderType), 'icon': Icons.archive},
      ];
    }
  }

  @override
  Color getStatusColor(int status, int orderType) {
    if (status == -1) return Colors.red;
    if (status == 6) return Colors.grey.shade600;

    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 5:
        return orderType == 1 ? Colors.green : Colors.grey.shade600;
    }

    if (orderType == 0) {
      switch (status) {
        case 2:
          return Colors.purple;
        case 3:
          return Colors.green;
      }
    } else {
      if (status == 4) return Colors.teal;
    }

    return Colors.grey;
  }
}
