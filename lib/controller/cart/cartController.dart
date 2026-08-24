import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/cart/cartdata.dart';
import 'package:oro/data/model/cartmodel.dart';
import 'package:oro/view/screens/checkout/checkout.dart';

abstract class CartController extends GetxController {
  addCart(String itemId);
  deleteCart(String itemId);
  countCart(String itemId);
  viewCart();
  add(String itemId, int index);
  remove(String itemId, int index);
  placeOrder();
}

class CartControllerImp extends CartController {
  StatusRequest statusRequest = StatusRequest.none;
  final CartData cartData = CartData(Get.find());
  final Services services = Get.find();
  final List<CartModel> data = [];
  double totalprice = 0.0;
  int countitem = 0;
  int counter = 0;
  bool get isNotVerified =>
      services.sharedPreferences.getString('approve') == '0';
  String? get _userId => services.sharedPreferences.getString('id');

  @override
  void onInit() {
    super.onInit();
    viewCart();
  }

  @override
  Future<void> addCart(String itemId) async {
    final userId = _userId;
    if (userId == null || itemId.isEmpty) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await cartData.cartAdd(userId, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success') {
        await viewCart();
        Get.snackbar(
          'Agregado al carrito',
          'El producto fue agregado correctamente.',
          colorText: Appcolor.ink,
          backgroundColor: Appcolor.surface,
          icon: const Icon(Icons.add_shopping_cart_rounded),
        );
      } else if (response['status'] == 'insufficient_stock') {
        statusRequest = StatusRequest.failure;
        Get.snackbar('Stock insuficiente',
            'No hay más unidades disponibles de este producto.');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  Future<void> deleteCart(String itemId) async {
    final userId = _userId;
    if (userId == null || itemId.isEmpty) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await cartData.cartDelete(userId, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      await viewCart();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  Future<int> countCart(String itemId) async {
    final userId = _userId;
    if (userId == null || itemId.isEmpty) return 0;
    final response = await cartData.cartCount(userId, itemId);
    final state = handlingdata(response);
    if (state == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      return int.tryParse('${response['data']}') ?? 0;
    }
    return 0;
  }

  @override
  Future<void> viewCart() async {
    final userId = _userId;
    data.clear();
    totalprice = 0;
    countitem = 0;
    if (userId == null) {
      statusRequest = StatusRequest.none;
      update();
      return;
    }

    statusRequest = StatusRequest.loding;
    update();
    final response = await cartData.cartView(userId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      if (response['status'] == 'success') {
        final rows = response['datacart'];
        if (rows is List) {
          data.addAll(rows
              .whereType<Map>()
              .map((e) => CartModel.fromJson(Map<String, dynamic>.from(e))));
        }
        final totals = response['totalCountAndPrice'];
        if (totals is Map) {
          totalprice = double.tryParse('${totals['carttotal'] ?? 0}') ?? 0;
          countitem = int.tryParse('${totals['itemstotal'] ?? 0}') ?? 0;
        }
        statusRequest = StatusRequest.success;
      } else {
        // Carrito vacío es un estado válido de UI, no un error de aplicación.
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  @override
  Future<void> add(String itemId, int index) async {
    if (index < 0 || index >= data.length) return;
    await addCart(itemId);
  }

  @override
  Future<void> remove(String itemId, int index) async {
    if (index < 0 || index >= data.length) return;
    await deleteCart(itemId);
  }

  @override
  void placeOrder() {
    if (data.isEmpty) {
      Get.snackbar(
          'Carrito vacío', 'Agrega al menos un producto antes de continuar.');
      return;
    }
    Get.to(() => const Checkout(), arguments: {
      'orderDetails': List<CartModel>.unmodifiable(data),
      'totalprice': totalprice,
    });
  }
}
