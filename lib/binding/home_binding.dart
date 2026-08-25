import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/controller/home/homescreenController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeControllerImp>(() => HomeControllerImp(), fenix: true);
    Get.lazyPut<HomeScreenControllerImp>(() => HomeScreenControllerImp(),
        fenix: true);
  }
}
