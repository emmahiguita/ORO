import 'package:get/get.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/controller/delivery/deliveryhomecontroller.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/notification/notificationdata.dart';
import 'package:oro/data/model/notificationmodel.dart';

abstract class NotificationController extends GetxController {
  getNotification();
  deleteNotification(String notificationID, int index);
  markNotificationAsRead();
}

class NotificationControllerImp extends NotificationController {
  final Services services = Get.find();
  final NotificationData notificationData = NotificationData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  final List<NotificationModel> allNotification = [];

  @override
  Future<void> getNotification() async {
    final id = services.sharedPreferences.getString('id');
    allNotification.clear();
    if (id == null) {
      statusRequest = StatusRequest.none;
      update();
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    final response = await notificationData.getNotification(id);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      final rows = response['data'];
      if (response['status'] == 'success' && rows is List) {
        allNotification.addAll(rows.whereType<Map>().map(
            (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e))));
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  @override
  Future<void> deleteNotification(String notificationID, int index) async {
    final id = services.sharedPreferences.getString('id');
    if (id == null ||
        notificationID.isEmpty ||
        index < 0 ||
        index >= allNotification.length) {
      return;
    }
    final response =
        await notificationData.deleteNotification(id, notificationID);
    final state = handlingdata(response);
    if (state == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      allNotification.removeAt(index);
      update();
      await _refreshBadge();
    }
  }

  @override
  Future<void> markNotificationAsRead() async {
    final id = services.sharedPreferences.getString('id');
    if (id == null) return;
    for (final notification in allNotification.where((n) => n.isRead == 0)) {
      final notificationId = notification.notificationId;
      if (notificationId == null) continue;
      final response = await notificationData.readNotification(
          id, notificationId.toString());
      if (handlingdata(response) == StatusRequest.success &&
          response is Map &&
          response['status'] == 'success') {
        notification.isRead = 1;
      }
    }
    update();
    await _refreshBadge();
  }

  Future<void> _refreshBadge() async {
    final key = services.sharedPreferences.getString('key');
    if (key == '0' && Get.isRegistered<HomeScreenControllerImp>()) {
      await Get.find<HomeScreenControllerImp>().getNotificationsCount();
    } else if (key == '1' && Get.isRegistered<DeliveryHomeControllerImp>()) {
      await Get.find<DeliveryHomeControllerImp>().getNotificationsCount();
    } else if (key == '2' && Get.isRegistered<AdminHomeControllerImp>()) {
      await Get.find<AdminHomeControllerImp>().getNotificationsCount();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNotification().then((_) => markNotificationAsRead());
  }
}
