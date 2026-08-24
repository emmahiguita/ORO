// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/search/searchdata.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/data/model/suggestionmodel.dart';

abstract class SearchController extends GetxController {
  search(String input);
  suggestion();
  goToItemDetails(itemModel);
}

class SearchControllerImp extends SearchController {
  late StatusRequest statusRequest;
  SearchData searchData = SearchData(Get.find());
  List<ItemsModel> results = [];
  List<SuggestionModel> suggestions = [];
  String input = "";
  TextEditingController? textEditingController;

  @override
  search(input) async {
    statusRequest = StatusRequest.loding;
    var response = await searchData.search(input);
    statusRequest = handlingdata(response);
    // print(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        results.clear();
        List responsedata = response["data"];
        results.addAll(responsedata.map(
          (e) => ItemsModel.fromJson(e),
        ));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  suggestion() async {
    var response = await searchData.suggestion();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        suggestions.clear();
        List responsedata = response["data"];
        suggestions.addAll(responsedata.map(
          (e) => SuggestionModel.fromJson(e),
        ));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  static List<String> getSuggestions(String query, List<SuggestionModel> all) {
    List<String> matches = [];
    matches.addAll(all.map((e) => e.itemName!));
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void onInit() async {
    input = Get.arguments['input'];
    suggestion();
    textEditingController = TextEditingController();
    await search(input);
    super.onInit();
  }

  @override
  goToItemDetails(itemModel) {
    Get.toNamed(Approutes.itemDetails, arguments: {"itemsModel": itemModel});
  }
}
