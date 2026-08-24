import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/profile/prfiledata.dart';
import 'package:oro/view/screens/orders/archivedorders.dart';
import 'package:oro/view/screens/orders/pendingorders.dart';

abstract class ProfileController extends GetxController {
  getTotalOrdersCount();
  goToUnDeliverdOrders();
  goToArchivedOrder();
}

class ProfileControllerImp extends ProfileController {
  String? username;
  String? email;
  String? number;
  String? pfp;
  String? banner;
  bool? approve;

  Services services = Get.find();

  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List data = [];

  @override
  void onInit() {
    username = services.sharedPreferences.getString("username");
    email = services.sharedPreferences.getString("email");
    number = services.sharedPreferences.getString("phone");
    pfp = services.sharedPreferences.getString("pfp");
    banner = services.sharedPreferences.getString("banner");
    approve = services.sharedPreferences.getString("approve") == "1";
    getTotalOrdersCount();

    super.onInit();
  }

  @override
  getTotalOrdersCount() async {
    data.clear();
    statusRequest = StatusRequest.loding;
    update();
    var response = await profileData
        .getCountOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        data = response['data'];
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToUnDeliverdOrders() {
    Get.to(
      () => const PendingOrders(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  goToArchivedOrder() {
    Get.to(
      () => const ArchivedOrders(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 800),
    );
  }
}
