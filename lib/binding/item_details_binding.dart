import 'package:get/get.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class ItemDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemsDetailsControllerImp>(() => ItemsDetailsControllerImp(),
        fenix: true);
  }
}
