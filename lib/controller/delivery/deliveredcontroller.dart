import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/delivery/deliverydata.dart';
import 'package:oro/data/model/deliveredmodel.dart';
import 'package:oro/view/screens/delivery/orderdetails.dart';

abstract class DeliveredController extends GetxController {
  getDelivered();
  String getPaymentType(int paymentCode);
  goToOrderDetails(String orderid, int index);
}

class DeliveredControllerImp extends DeliveredController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<DeliveredModel> delivered = [];
  bool loading = false;
  Services services = Get.find();

  @override
  getDelivered() async {
    statusRequest = StatusRequest.loding;
    update();
    delivered.clear();
    var response = await deliveryData.getDeliveredOrders(services.userId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        delivered.addAll(
          data.map(
            (e) => DeliveredModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
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

  IconData getPaymentIcon(String paymentType) {
    switch (paymentType.toLowerCase()) {
      case 'cash':
        return Icons.money;
      case 'american express':
      case 'master card':
      case 'visa':
        return Icons.credit_card;
      case 'paypal':
      case 'online':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  @override
  void onInit() {
    getDelivered();
    super.onInit();
  }

  @override
  goToOrderDetails(orderid, index) {
    Get.to(() => const DeliveryOrderDetails(), arguments: {
      'orderid': orderid,
      'undeliveredOrder': delivered[index],
      'isDelivered': true,
    });
  }
}
