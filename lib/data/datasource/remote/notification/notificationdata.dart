import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class NotificationData {
  Curd curd;
  NotificationData(this.curd);
  getNotification(String userid) async {
    var resp = await curd.postData(AppLink.viewNotification, {
      "id": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  deleteNotification(String userid, String notificationID) async {
    var resp = await curd.postData(AppLink.deleteNotification, {
      "userID": userid,
      "notificationID": notificationID,
    });
    return resp.fold((s) => s, (r) => r);
  }

  readNotification(String userid, String notificationid) async {
    var resp = await curd.postData(AppLink.readNotification, {
      "userid": userid,
      "notificationid": notificationid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getNotificationCount(String userid) async {
    var resp = await curd.postData(AppLink.newNotificationsCount, {
      "id": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
