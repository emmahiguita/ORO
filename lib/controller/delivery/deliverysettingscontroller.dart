import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/disablenotification.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/delivery/deliverydata.dart';
import 'package:oro/view/screens/auth/login.dart';
import 'package:oro/view/screens/delivery/viewdelivered.dart';
import 'package:oro/view/screens/settings/updateaccountinformation.dart';

abstract class DeliverySettingsController extends GetxController {
  disableNotification();
  goToDeliveredOrders();
  goToUpdateAccountInformation();
  updateAccount();
  logout();
  getDeliveredCount();
}

class DeliverySettingsControllerImp extends DeliverySettingsController {
  final Services services = Get.find();
  final DeliveryData deliveryData = DeliveryData(Get.find());
  String? username, email, phoneNumber, pfp, banner;
  bool isNotificationEnabled = false;
  int deliveredCount = 0;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    _loadCachedUser();
    getDeliveredCount();
    super.onInit();
  }

  void _loadCachedUser() {
    username = services.sharedPreferences.getString('username');
    email = services.sharedPreferences.getString('email');
    pfp = services.sharedPreferences.getString('pfp');
    banner = services.sharedPreferences.getString('banner');
    phoneNumber = services.sharedPreferences.getString('phone');
    isNotificationEnabled =
        services.sharedPreferences.getBool('isNotificationEnabled') ?? false;
  }

  @override
  Future<void> disableNotification() async {
    if (services.firebaseReady) await disableNotifications();
    isNotificationEnabled =
        services.sharedPreferences.getBool('isNotificationEnabled') ?? false;
    update();
  }

  @override
  void goToUpdateAccountInformation() =>
      Get.to(() => const UpdateAccountInformation(),
          transition: Transition.cupertino);
  @override
  void goToDeliveredOrders() =>
      Get.to(() => const ViewDelivered(), transition: Transition.cupertino);
  @override
  void updateAccount() {
    _loadCachedUser();
    update();
  }

  @override
  Future<void> logout() async {
    await services.unregisterPushToken();
    await services.clearAuthToken();
    final lang = services.sharedPreferences.getString('langcode') ?? 'es';
    await services.sharedPreferences.clear();
    await services.sharedPreferences.setString('langcode', lang);
    await services.sharedPreferences.setString('step', '1');
    Get.offAll(() => const Login(), transition: Transition.fadeIn);
  }

  @override
  Future<void> getDeliveredCount() async {
    final id = services.sharedPreferences.getString('id');
    if (id == null) return;
    statusRequest = StatusRequest.loding;
    update();
    final response = await deliveryData.getCountDelivered(id);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      final rows = response['data'];
      if (rows is List && rows.isNotEmpty)
        deliveredCount = int.tryParse('${rows.first['count_total']}') ?? 0;
    }
    update();
  }
}
