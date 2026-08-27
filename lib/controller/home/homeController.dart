import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/home/homedata.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/screens/items/ItemsView.dart';
import 'package:oro/view/screens/items/itemdetails.dart';
import 'package:oro/view/screens/search/search.dart';

abstract class HomeController extends GetxController {
  intiialiData();
  getData();
  goToItem(List categories, int selected, String catId);
  goToSearch();
  goToItemDetails(model);
}

class HomeControllerImp extends HomeController {
  final Services services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  final HomeData homeData = HomeData(Get.find());
  final List categories = [];
  final List items = [];
  final List<ItemsModel> itemsList = [];
  final List mainPage = [];
  TextEditingController? textEditingController;

  static Map? _cachedHomeData;

  String? username;
  String? id;
  String? pfp;

  @override
  intiialiData() {
    username = services.sharedPreferences.getString('username');
    pfp = services.sharedPreferences.getString('pfp');
    id = services.sharedPreferences.getString('id');
    update();
  }

  @override
  void onInit() {
    textEditingController = TextEditingController();
    intiialiData();
    if (_cachedHomeData != null) {
      _applyData(_cachedHomeData!);
    } else {
      _applyData(OfflineDataProvider.getMockResponse(AppLink.home, {}));
    }
    statusRequest = StatusRequest.success;
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController?.dispose();
    super.onClose();
  }

  void _applyData(Map response) {
    if (response['categories'] != null && response['categories'] is List) {
      categories
        ..clear()
        ..addAll(response['categories']);
    }
    if (response['items'] != null && response['items'] is List) {
      items.clear();
      itemsList.clear();
      for (final raw in response['items']) {
        items.add(raw);
        itemsList.add(ItemsModel.fromJson(raw));
      }
    }
    if (response['mainpage'] != null && response['mainpage'] is List) {
      mainPage
        ..clear()
        ..addAll(response['mainpage']);
    }
  }

  @override
  getData() async {
    final hasCachedData = itemsList.isNotEmpty;
    if (!hasCachedData) {
      statusRequest = StatusRequest.loding;
      update();
    }
    final response = await homeData.postData();
    var status = handlingdata(response);
    if (status == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      _cachedHomeData = response;
      _applyData(response);
      statusRequest = StatusRequest.success;
    } else {
      final mock = OfflineDataProvider.getMockResponse(AppLink.home, {});
      _applyData(mock);
      statusRequest = StatusRequest.success;
    }
    update();
  }

  @override
  goToItem(categories, selected, catId) {
    Get.to(
      () => const ItemsView(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 320),
      arguments: {
        'categories': categories,
        'selected': selected,
        'catId': catId,
      },
    );
  }

  @override
  goToSearch() {
    Get.to(
      const Search(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 320),
      arguments: {'input': textEditingController?.text ?? ''},
    );
  }

  @override
  goToItemDetails(model) {
    if (Get.isRegistered<ItemsDetailsControllerImp>()) {
      Get.delete<ItemsDetailsControllerImp>();
    }
    Get.to(
      () => const ItemDetails(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 380),
      arguments: {'itemsModel': model},
    );
  }

  /// Tonos editoriales usados como acentos suaves de cada producto.
  final List<Color> gradientColors = const [
    Appcolor.oxblood,
    Appcolor.forest,
    Appcolor.navy,
    Appcolor.camel,
    Appcolor.plum,
    Appcolor.clay,
    Appcolor.sage,
    Appcolor.bronze,
  ];
}
