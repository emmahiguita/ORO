import 'package:get/get.dart';
import 'package:oro/core/services/services.dart';

Future<void> disableNotifications() async {
  final services = Get.find<Services>();
  final enabled =
      services.sharedPreferences.getBool('isNotificationEnabled') ?? true;
  await services.setNotificationsEnabled(!enabled);
}
