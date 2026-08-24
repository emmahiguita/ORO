import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/home/homedata.dart';
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
  final List mainPage = [];
  TextEditingController? textEditingController;

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
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController?.dispose();
    super.onClose();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loding;
    update();
    final response = await homeData.postData();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        categories
          ..clear()
          ..addAll(response['categories']);
        items
          ..clear()
          ..addAll(response['items']);
        mainPage
          ..clear()
          ..addAll(response['mainpage']);
      } else if (response['status'] == 'failure') {
        statusRequest = StatusRequest.failure;
      }
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
