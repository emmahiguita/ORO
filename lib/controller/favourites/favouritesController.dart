import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/functions/oro_toast.dart';
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
    var response = await favouritesData.favouritesAdd(services.userId, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        OroToast.favoriteAdded();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  deleteFavourites(String itemId) async {
    statusRequest = StatusRequest.loding;
    var response =
        await favouritesData.favouritesDelete(services.userId, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        OroToast.favoriteRemoved();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }
}
