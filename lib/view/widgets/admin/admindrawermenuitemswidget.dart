import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/view/widgets/admin/adminmenuitemwidget.dart';

class AdminDrawerMenuItemsWidget extends StatelessWidget {
  final AdminHomeControllerImp controller;

  const AdminDrawerMenuItemsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        AdminMenuItemWidget(
          icon: Iconsax.home,
          title: 'Dashboard',
          isSelected: controller.currentpage == 0,
          onTap: () {
            controller.changePage(0);
            Get.back();
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.shop,
          title: 'Products',
          isSelected: controller.currentpage == 1,
          onTap: () {
            controller.changePage(1);
            Navigator.pop(context);
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.category,
          title: 'Categories',
          isSelected: controller.currentpage == 2,
          onTap: () {
            controller.changePage(2);
            Navigator.pop(context);
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.shopping_cart,
          title: 'Pedidos',
          isSelected: controller.currentpage == 3,
          onTap: () {
            controller.changePage(3);
            Navigator.pop(context);
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.discount_shape,
          title: 'Coupons',
          isSelected: controller.currentpage == 4,
          onTap: () {
            controller.changePage(4);
            Navigator.pop(context);
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.gift,
          title: 'Offers',
          isSelected: controller.currentpage == 5,
          onTap: () {
            controller.changePage(5);
            Navigator.pop(context);
          },
        ),
        AdminMenuItemWidget(
          icon: Iconsax.notification,
          title: 'Notificaciones',
          isSelected: controller.currentpage == 6,
          badge: (controller.data.isNotEmpty &&
                  controller.data[0]["unread_count"] > 0)
              ? controller.data[0]["unread_count"].toString()
              : null,
          onTap: () {
            controller.changePage(6);
            Navigator.pop(context);
          },
        ),
        const DividerWidget(),
        AdminMenuItemWidget(
          icon: Iconsax.setting_2,
          title: 'Settings',
          isSelected: controller.currentpage == 7,
          onTap: () {
            controller.changePage(7);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 1,
      color: Colors.grey[200],
    );
  }
}
