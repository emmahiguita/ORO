import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oro/controller/checkout/couponcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/address/addressdata.dart';
import 'package:oro/data/datasource/remote/checkout/checkoutdata.dart';
import 'package:oro/data/model/addressmodel.dart';
import 'package:oro/data/model/cartmodel.dart';
import 'package:oro/view/screens/home/homescreen.dart';

abstract class CheckoutController extends GetxController {
  Future<void> getUserAddresses();
  void chooseAddressId(int id);
  void changeDeliveryType(int id);
  void changePaymentType(int id);
  Future<void> placeOrder();
}

class CheckoutControllerImp extends CheckoutController {
  final CouponControllerImp couponController = Get.put(CouponControllerImp());
  final CheckoutData checkoutData = CheckoutData(Get.find());
  final Services services = Get.find<Services>();
  final AddressData addressData = AddressData(Get.find());

  int? addressId;
  int deliveryType = 0;
  int paymentType =
      4; // Único método realmente implementado: contra entrega/recogida.
  int shippingFee = 0;
  String currency = 'COP';
  final List<AddressModel> addresses = [];
  StatusRequest statusRequest = StatusRequest.none;
  List<CartModel> orderDetails = [];
  bool get isLoading => statusRequest == StatusRequest.loding;
  double get previewTotal =>
      couponController.totalprice + (deliveryType == 0 ? shippingFee : 0);

  @override
  void onInit() {
    final rawDetails = Get.arguments?['orderDetails'];
    if (rawDetails is List<CartModel>) orderDetails = rawDetails;
    _loadPublicConfig();
    getUserAddresses();
    super.onInit();
  }

  Future<void> _loadPublicConfig() async {
    final response = await checkoutData.getPublicConfig();
    if (response is Map &&
        response['status'] == 'success' &&
        response['data'] is Map) {
      final data = response['data'] as Map;
      final rawFee = data['delivery_fee'];
      shippingFee =
          rawFee is num ? rawFee.round() : int.tryParse('$rawFee') ?? 0;
      currency = '${data['currency'] ?? 'COP'}';
      update();
    }
  }

  @override
  Future<void> getUserAddresses() async {
    statusRequest = StatusRequest.loding;
    update();
    final id = services.sharedPreferences.getString('id');
    if (id == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }
    final response = await addressData.getAddress(id);
    statusRequest = handlingdata(response);
    addresses.clear();
    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      final rows = response['data'];
      if (rows is List) {
        addresses.addAll(rows.map(
            (e) => AddressModel.fromJson(Map<String, dynamic>.from(e as Map))));
      }
    }
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void chooseAddressId(int id) {
    addressId = id;
    update();
  }

  @override
  void changeDeliveryType(int id) {
    if (id != 0 && id != 1) return;
    deliveryType = id;
    if (deliveryType == 1) addressId = null;
    update();
  }

  @override
  void changePaymentType(int id) {
    if (id == 4) {
      paymentType = 4;
      update();
    }
  }

  String formatMoney(num value) {
    final rounded = value.round();
    final negative = rounded < 0;
    final digits = rounded.abs().toString();
    final parts = <String>[];
    for (int end = digits.length; end > 0; end -= 3) {
      final start = (end - 3).clamp(0, digits.length).toInt();
      parts.insert(0, digits.substring(start, end));
    }
    final formatted = parts.join('.');
    return '${negative ? '-' : ''}\$ $formatted $currency';
  }

  void _message(String title, String body) =>
      Get.snackbar(title, body, snackPosition: SnackPosition.BOTTOM);

  @override
  Future<void> placeOrder() async {
    if (deliveryType == 0 && addressId == null) {
      _message('Falta la dirección',
          'Selecciona una dirección de entrega para continuar.');
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    final userId = services.sharedPreferences.getString('id') ?? '';
    final response = await checkoutData.placeOrder(
      userId,
      addressId?.toString() ?? '0',
      deliveryType.toString(),
      couponController.totalprice.toString(),
      shippingFee.toString(),
      paymentType.toString(),
      couponController.isCouponUsed && couponController.couponList.isNotEmpty
          ? '${couponController.couponList.first.couponId ?? 0}'
          : '0',
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      final data = response['data'] is Map ? response['data'] as Map : const {};
      final orderId = data['order_id'];
      final total = data['total'] ?? previewTotal;
      statusRequest = StatusRequest.none;
      update();
      Get.offAll(() => const HomeScreen());
      Get.dialog(
        AlertDialog(
          title: const Text('Pedido confirmado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 110,
                  child: Lottie.asset('lottie/orederplaced.json',
                      fit: BoxFit.contain)),
              const SizedBox(height: 12),
              Text('Pedido #${orderId ?? '-'} creado correctamente.'),
              const SizedBox(height: 8),
              Text(
                  'Total confirmado: ${formatMoney(num.tryParse('$total') ?? 0)}'),
              const SizedBox(height: 8),
              const Text(
                  'El pago se realizará contra entrega o al recoger el pedido.'),
            ],
          ),
          actions: [
            TextButton(onPressed: Get.back, child: const Text('Continuar'))
          ],
        ),
      );
      return;
    }

    statusRequest = StatusRequest.none;
    update();
    final code = response is Map ? '${response['status']}' : '';
    final message = switch (code) {
      'empty_cart' => 'Tu carrito está vacío.',
      'insufficient_stock' =>
        'Uno de los productos ya no tiene unidades suficientes.',
      'invalid_coupon' =>
        'El cupón dejó de estar disponible. Revisa el total e inténtalo otra vez.',
      'invalid_address' => 'La dirección seleccionada ya no es válida.',
      'payment_not_supported' =>
        'El método de pago seleccionado no está habilitado.',
      _ =>
        'No pudimos completar el pedido. Revisa tu conexión e inténtalo nuevamente.',
    };
    _message('Pedido no procesado', message);
  }
}
