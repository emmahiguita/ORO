import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';

class ItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemscontrollerImp>(() => ItemscontrollerImp(), fenix: true);
    Get.lazyPut<FavouritesControllerImp>(() => FavouritesControllerImp(),
        fenix: true);
  }
}
