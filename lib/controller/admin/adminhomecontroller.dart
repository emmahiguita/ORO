import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/notification/notificationdata.dart';
import 'package:oro/view/screens/admin/categories/categories.dart';
import 'package:oro/view/screens/admin/coupon/admincoupon.dart';
import 'package:oro/view/screens/admin/dashboardhome.dart';
import 'package:oro/view/screens/admin/items/itemsview.dart';
import 'package:oro/view/screens/admin/offermessage/offer.dart';
import 'package:oro/view/screens/admin/orders/vieworders.dart';
import 'package:oro/view/screens/admin/settings/adminsetting.dart';
import 'package:oro/view/screens/auth/login.dart';
import 'package:oro/view/screens/notification/viewnotification.dart';

abstract class AdminHomeController extends GetxController {
  void changePage(int i);
  logout();
  getNotificationsCount();
}

class AdminHomeControllerImp extends AdminHomeController {
  StatusRequest statusRequest = StatusRequest.none;
  final NotificationData notificationData = NotificationData(Get.find());
  final List data = [];
  final Services services = Get.find();
  String? username, email, pfp, banner;
  int currentpage = 0;
  final List<Widget> listpages = const [
    DashboardHome(),
    AdminItemsView(),
    Categories(),
    ViewOrders(),
    AdminCoupon(),
    Offer(),
    ViewNotification(visableAppBar: false),
    AdminSetting()
  ];
  final List<String> namepages = const [
    'Panel',
    'Productos',
    'Categorías',
    'Pedidos',
    'Cupones',
    'Ofertas',
    'Notificaciones',
    'Ajustes'
  ];
  final List<IconData> iconpages = const [
    Iconsax.home,
    Iconsax.shop,
    Iconsax.category,
    Iconsax.shopping_cart,
    Iconsax.gift,
    Iconsax.shop,
    Iconsax.notification,
    Iconsax.setting
  ];
  @override
  void changePage(int i) {
    if (i < 0 || i >= listpages.length) return;
    currentpage = i;
    update();
  }

  @override
  void onInit() {
    username = services.sharedPreferences.getString('username');
    email = services.sharedPreferences.getString('email');
    pfp = services.sharedPreferences.getString('pfp');
    banner = services.sharedPreferences.getString('banner');
    currentpage = Get.arguments?['num'] ?? 0;
    getNotificationsCount();
    super.onInit();
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
  Future<void> getNotificationsCount() async {
    data.clear();
    statusRequest = StatusRequest.loding;
    final id = services.sharedPreferences.getString('id');
    if (id == null) {
      statusRequest = StatusRequest.none;
      update();
      return;
    }
    final response = await notificationData.getNotificationCount(id);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success' &&
        response['data'] is List) {
      data.addAll(response['data']);
    }
    update();
  }
}
