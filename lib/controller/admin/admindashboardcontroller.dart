import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/dashboardmodel.dart';

abstract class AdminDashboardController extends GetxController {
  getDashboardInfo();
}

class AdminDashboardControllerImp extends AdminDashboardController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  DashboardModel dashboardInfo = DashboardModel();

  @override
  getDashboardInfo() async {
    statusRequest = StatusRequest.loding;
    var response = await adminData.getDashboardInfo();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        var data = response;
        dashboardInfo = DashboardModel.fromJson(data);
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getDashboardInfo();
    super.onInit();
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

  String getStatusText(double statusCode) {
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
      case 2:
        return 'On The Way';
      case 3:
        return 'Entregado';
      case 4:
        return 'Ready for Pickup';
    }
    return 'Unknown Status';
  }
}
