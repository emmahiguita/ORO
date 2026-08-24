import 'package:get/get.dart';
import 'package:oro/view/screens/admin/settings/createnewadminaccount.dart';
import 'package:oro/core/functions/disablenotification.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/view/screens/admin/settings/createnewdeliveryaccount.dart';
import 'package:oro/view/screens/settings/updateaccountinformation.dart';

abstract class AdminSettingsController extends GetxController {
  disableNotification();
  goToCreateNewDeliveryAccount();
  goToCreateNewAdminAccount();
  goToUpdateAccountInformation();
  updateAccount();
}

class AdminSettingsControllerImp extends AdminSettingsController {
  Services services = Get.find();

  String? username;
  String? email;
  String? pfp;
  String? banner;

  bool? isNotificationEnabled;

  @override
  void onInit() {
    username = services.sharedPreferences.getString("username")!;
    email = services.sharedPreferences.getString("email")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    banner = services.sharedPreferences.getString("banner")!;
    isNotificationEnabled =
        services.sharedPreferences.getBool("isNotificationEnabled");

    super.onInit();
  }

  @override
  disableNotification() {
    disableNotifications();
    isNotificationEnabled =
        services.sharedPreferences.getBool("isNotificationEnabled");
    update();
  }

  @override
  goToCreateNewDeliveryAccount() {
    Get.to(
      () => const CreateNewDeliveryAccount(),
      transition: Transition.leftToRight,
    );
  }

  @override
  goToCreateNewAdminAccount() {
    Get.to(
      () => const CreateNewAdminAccount(),
      transition: Transition.leftToRight,
    );
  }

  @override
  goToUpdateAccountInformation() {
    Get.to(
      () => const UpdateAccountInformation(),
      transition: Transition.leftToRight,
    );
  }

  @override
  updateAccount() {
    username = services.sharedPreferences.getString("username")!;
    email = services.sharedPreferences.getString("email")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    banner = services.sharedPreferences.getString("banner")!;
    update();
  }
}
