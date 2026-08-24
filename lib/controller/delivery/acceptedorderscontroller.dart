import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/delivery/deliverydata.dart';
import 'package:oro/data/model/deliveryrequestmodel.dart';
import 'package:oro/view/screens/delivery/orderdetails.dart';

abstract class AcceptedOrdersController extends GetxController {
  getAcceptedOrders();
  String getPaymentType(int paymentCode);
  goToOrderDetails(String orderid, int index);
  markAsDelivered(String userid, String orderid);
  sendDeliveryLocation();
  saveToFirestore(int index, double latitude, double longitude);
}

class AcceptedOrdersControllerImp extends AcceptedOrdersController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<DeliveryRequestModel> acceptedOrders = [];
  bool loading = false;
  Services services = Get.find();

  @override
  getAcceptedOrders() async {
    statusRequest = StatusRequest.loding;
    update();
    acceptedOrders.clear();
    var response = await deliveryData
        .getAcceptedOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        acceptedOrders.addAll(
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
  void onInit() async {
    await getAcceptedOrders();
    sendDeliveryLocation();
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
      'undeliveredOrder': acceptedOrders[index]
    });
  }

  @override
  markAsDelivered(userid, orderid) async {
    loading = true;
    update();
    var response = await deliveryData.markAsDelivered(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      getAcceptedOrders();
      if (response["status"] == "success") {
        Get.snackbar(
          "Éxito",
          "Order delivered successfully",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }

  @override
  sendDeliveryLocation() {
    if (acceptedOrders.isNotEmpty) {
      Timer.periodic(
        const Duration(seconds: 10),
        (timer) {
          Geolocator.getPositionStream().listen(
            (Position position) {
              for (int i = 0; i < acceptedOrders.length; i++) {
                saveToFirestore(i, position.latitude, position.longitude);
              }
            },
          );
        },
      );
    }
  }

  @override
  saveToFirestore(int index, double latitude, double longitude) {
    FirebaseFirestore.instance
        .collection("delivery")
        .doc(acceptedOrders[index].orderId.toString())
        .set({
      "lat": latitude,
      "long": longitude,
      "deliveryid": services.sharedPreferences.getString("id"),
    });
  }
}
