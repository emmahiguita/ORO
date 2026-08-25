import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/notification/notificationdata.dart';
import 'package:oro/view/screens/home/home.dart';
import 'package:oro/view/screens/items/viewFavourite.dart';
import 'package:oro/view/screens/profile/profile.dart';
import 'package:oro/view/screens/settings/settings.dart';

abstract class HomeScreenController extends GetxController {
  void changePage(int i);
  getNotificationsCount();
}

class HomeScreenControllerImp extends HomeScreenController {
  late StatusRequest statusRequestNotification;
  final NotificationData notificationData = NotificationData(Get.find());
  final List data = [];
  final Services services = Get.find();

  int currentpage = 0;
  late PageController pageController;

  final List<Widget> listpages = const [
    Home(),
    ViewFavourite(),
    Profile(),
    Settings(),
  ];

  List<String> get namepages => [
        'nav_home'.tr,
        'nav_favorites'.tr,
        'nav_profile'.tr,
        'nav_settings'.tr,
      ];

  final List<IconData> iconpages = const [
    Icons.home_outlined,
    Icons.favorite_border_rounded,
    Icons.person_outline_rounded,
    Icons.tune_rounded,
  ];

  @override
  void changePage(int i) {
    if (currentpage == i) return;
    currentpage = i;
    if (pageController.hasClients) {
      pageController.animateToPage(
        i,
        duration: OroMotion.medium,
        curve: OroMotion.standard,
      );
    }
    update();
  }

  @override
  void onInit() {
    currentpage = Get.arguments?['num'] ?? 0;
    pageController = PageController(initialPage: currentpage);
    getNotificationsCount();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  getNotificationsCount() async {
    statusRequestNotification = StatusRequest.loding;
    data.clear();
    final id = services.sharedPreferences.getString('id');
    if (id == null) {
      statusRequestNotification = StatusRequest.none;
      update();
      return;
    }

    final response = await notificationData.getNotificationCount(id);
    statusRequestNotification = handlingdata(response);
    if (statusRequestNotification == StatusRequest.success) {
      if (response['status'] == 'success') {
        final rawData = response['data'];
        if (rawData is List) {
          data.addAll(rawData);
        } else if (rawData is Map) {
          data.add(rawData);
        } else if (rawData != null) {
          data.add({'unread_count': rawData});
        }
      } else if (response['status'] == 'failure') {
        statusRequestNotification = StatusRequest.failure;
      }
    }
    if (Get.isRegistered<HomeControllerImp>()) {
      Get.find<HomeControllerImp>().update();
    }
    update();
  }

  int getUnreadCount() {
    try {
      if (data.isNotEmpty && data[0]['unread_count'] != null) {
        return int.tryParse(data[0]['unread_count'].toString()) ?? 0;
      }
    } catch (e) {
      debugPrint('Error getting unread count: $e');
    }
    return 0;
  }
}
