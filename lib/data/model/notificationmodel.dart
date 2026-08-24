class NotificationModel {
  int? notificationId;
  String? notificationTitle;
  String? notificationBody;
  String? notificationImage;
  String? notificationIcon;
  int? isRead;
  int? notificationUserid;
  String? notificationDatetime;

  NotificationModel(
      {this.notificationId,
      this.notificationTitle,
      this.notificationBody,
      this.notificationImage,
      this.notificationIcon,
      this.isRead,
      this.notificationUserid,
      this.notificationDatetime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationTitle = json['notification_title'];
    notificationBody = json['notification_body'];
    notificationImage = json['notification_image'];
    notificationIcon = json['notification_icon'];
    isRead = json['is_read'];
    notificationUserid = json['notification_userid'];
    notificationDatetime = json['notification_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = notificationId;
    data['notification_title'] = notificationTitle;
    data['notification_body'] = notificationBody;
    data['notification_image'] = notificationImage;
    data['notification_icon'] = notificationIcon;
    data['is_read'] = isRead;
    data['notification_userid'] = notificationUserid;
    data['notification_datetime'] = notificationDatetime;
    return data;
  }
}
