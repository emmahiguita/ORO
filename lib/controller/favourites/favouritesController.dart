import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/favourites/favouritesdata.dart';

abstract class FavouritesController extends GetxController {
  Map favourites = {};
  setFavourites(int id, int value);
  addFavourites(String itemId);
  deleteFavourites(String itemId);
}

class FavouritesControllerImp extends FavouritesController {
  late StatusRequest statusRequest;
  Services services = Get.find();
  FavouritesData favouritesData = FavouritesData(Get.find());

  @override
  setFavourites(id, value) {
    favourites[id] = value;
    update();
  }

  @override
  addFavourites(String itemId) async {
    statusRequest = StatusRequest.loding;
    var response = await favouritesData.favouritesAdd(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Added to Favorites",
          "This item has been successfully added to your favorites!",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.favorite),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  deleteFavourites(String itemId) async {
    statusRequest = StatusRequest.loding;
    var response = await favouritesData.favouritesDelete(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Removed from Favorites",
          "This item has been successfully removed from your favorites.",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.favorite_border),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }
}
