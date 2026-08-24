import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/delivery/deliverydata.dart';
import 'package:oro/data/model/deliveryrequestmodel.dart';
import 'package:oro/view/screens/delivery/orderdetails.dart';

abstract class DeliveryRequestsController extends GetxController {
  getUndeliveredOrders();
  String getPaymentType(int paymentCode);
  goToOrderDetails(String orderid, int index);
  acceptorder(String userid, String orderid);
}

class DeliveryRequestsControllerImp extends DeliveryRequestsController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<DeliveryRequestModel> undeliveredOrders = [];
  bool loading = false;
  Services services = Get.find();

  @override
  getUndeliveredOrders() async {
    statusRequest = StatusRequest.loding;
    update();
    undeliveredOrders.clear();
    var response = await deliveryData.getUndeliveredOrders();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        undeliveredOrders.addAll(
          data.map(
            (e) => DeliveryRequestModel.fromJson(e),
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
    getUndeliveredOrders();
    super.onInit();
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
  goToOrderDetails(orderid, index) {
    Get.to(() => const DeliveryOrderDetails(), arguments: {
      'orderid': orderid,
      'undeliveredOrder': undeliveredOrders[index]
    });
  }

  @override
  acceptorder(userid, orderid) async {
    loading = true;
    update();
    var response = await deliveryData.acceptOrder(
        userid, orderid, services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      getUndeliveredOrders();
      if (response["status"] == "success") {
        await Get.find<AcceptedOrdersControllerImp>().getAcceptedOrders();
        Get.find<AcceptedOrdersControllerImp>().sendDeliveryLocation();
        Get.snackbar(
          "Éxito",
          "Order accepted successfully",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        Get.snackbar(
          "Error",
          "an error occurred please try again later",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }
}
