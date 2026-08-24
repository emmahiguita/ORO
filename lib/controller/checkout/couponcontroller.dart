import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/checkout/coupondata.dart';
import 'package:oro/data/model/couponmodel.dart';

abstract class CouponController extends GetxController {
  Future<void> checkCoupon();
}

class CouponControllerImp extends CouponController {
  StatusRequest statusRequest = StatusRequest.none;
  final CouponData couponData = CouponData(Get.find());
  final List<CouponModel> couponList = [];
  late final TextEditingController couponTextEditingController;
  bool isCouponUsed = false;
  double totalprice = 0;
  double subtotal = 0;

  @override
  Future<void> checkCoupon() async {
    final code = couponTextEditingController.text.trim();
    if (code.isEmpty) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await couponData.checkCoupon(code);
    statusRequest = handlingdata(response);
    couponList.clear();
    isCouponUsed = false;
    totalprice = subtotal;

    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      final rows = response['data'];
      if (rows is List && rows.isNotEmpty) {
        couponList.add(
            CouponModel.fromJson(Map<String, dynamic>.from(rows.first as Map)));
        final discount = couponList.first.couponDiscount ?? 0;
        isCouponUsed = true;
        totalprice = subtotal - (subtotal * discount / 100);
        Get.snackbar(
            'Cupón aplicado', 'Descuento del $discount% aplicado al pedido.');
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar('Cupón no válido',
          'Revisa el código o verifica que aún esté vigente.');
    }
    update();
  }

  @override
  void onInit() {
    couponTextEditingController = TextEditingController();
    final initial = Get.arguments?['totalprice'];
    subtotal =
        initial is num ? initial.toDouble() : double.tryParse('$initial') ?? 0;
    totalprice = subtotal;
    super.onInit();
  }

  @override
  void onClose() {
    couponTextEditingController.dispose();
    super.onClose();
  }
}
