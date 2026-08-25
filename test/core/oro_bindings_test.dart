import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:oro/binding/home_binding.dart';
import 'package:oro/binding/item_details_binding.dart';
import 'package:oro/binding/items_binding.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/class/curd.dart';
import 'package:oro/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.reset();
    SharedPreferences.setMockInitialValues(
        {'id': '1', 'username': 'Tester', 'pfp': 'avatar.jpg'});
    final sp = await SharedPreferences.getInstance();
    final services = Services();
    services.sharedPreferences = sp;
    Get.put(services);
    Get.put(Curd());
  });

  tearDown(() {
    Get.reset();
  });

  group('ORO Bindings Dependency Injection Tests', () {
    test(
        'HomeBinding registers HomeControllerImp and HomeScreenControllerImp lazily',
        () {
      final binding = HomeBinding();
      binding.dependencies();

      expect(Get.isPrepared<HomeControllerImp>(), isTrue);
      expect(Get.isPrepared<HomeScreenControllerImp>(), isTrue);
    });

    test(
        'ItemsBinding registers ItemscontrollerImp and FavouritesControllerImp',
        () {
      final binding = ItemsBinding();
      binding.dependencies();

      expect(Get.isPrepared<ItemscontrollerImp>(), isTrue);
      expect(Get.isPrepared<FavouritesControllerImp>(), isTrue);
    });

    test('ItemDetailsBinding registers ItemsDetailsControllerImp', () {
      final binding = ItemDetailsBinding();
      binding.dependencies();

      expect(Get.isPrepared<ItemsDetailsControllerImp>(), isTrue);
    });
  });
}
