import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/rating/ratingdata.dart';
import 'package:oro/data/model/viewratingmodel.dart';
import 'package:oro/view/screens/items/itemdetails.dart';

abstract class ViewRatingController extends GetxController {
  getAllRating();
  goToItemDetails(ViewRatingModel model);
  deleteRating(ratingId, index);
}

class ViewRatingControllerImp extends ViewRatingController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  RatingData ratingData = RatingData(Get.find());

  String? id;
  String? username;
  String? pfp;

  List<ViewRatingModel> allRating = [];

  @override
  getAllRating() async {
    allRating.clear();
    statusRequest = StatusRequest.loding;
    update();
    var response = await ratingData.viewAllRating(id!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        allRating.addAll(
          data.map(
            (e) => ViewRatingModel.fromJson(e),
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
    id = services.sharedPreferences.getString("id")!;
    username = services.sharedPreferences.getString("username")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    getAllRating();

    super.onInit();
  }

  @override
  goToItemDetails(model) {
    Get.to(
      () => const ItemDetails(),
      arguments: {"itemsModel": model},
    );
  }

  @override
  deleteRating(ratingId, index) async {
    Get.defaultDialog(
      title: 'Delete Rating',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      middleText:
          'Are you sure you want to delete this rating? This action cannot be undone.',
      middleTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      backgroundColor: Colors.white,
      radius: 12,
      barrierDismissible: false,
      textCancel: 'Cancelar',
      textConfirm: 'Delete',
      cancelTextColor: Colors.grey[600],
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        var response = await ratingData.deleteRating(id!, ratingId);
        allRating.removeAt(index);
        update();
        Get.back();
        statusRequest = handlingdata(response);
        if (statusRequest == StatusRequest.success) {
          if (response["status"] == "success") {
          } else if (response["status"] == "failure") {
            statusRequest = StatusRequest.failure;
            Get.snackbar(
              "Error",
              "Something wrong happened",
              colorText: Appcolor.charcoalGray,
              backgroundColor: Appcolor.rosePompadour,
              icon: const Icon(Icons.error),
            );
          }
        }
      },
    );
  }
}
