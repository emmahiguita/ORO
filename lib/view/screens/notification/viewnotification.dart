import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/notification/notificationcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/notification/notificationcard.dart';
import 'package:oro/view/widgets/notification/notificationemptystate.dart';
import 'package:oro/view/widgets/notification/notificationshimmerloading.dart';

class ViewNotification extends StatelessWidget {
  final bool visableAppBar;
  const ViewNotification({super.key, this.visableAppBar = true});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NotificationControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: visableAppBar
            ? AppBar(
                title: const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                surfaceTintColor: Colors.transparent,
              )
            : null,
        body: GetBuilder<NotificationControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loding) {
              return const NotificationShimmerLoading();
            }

            if (controller.allNotification.isEmpty) {
              return NotificationEmptyState(controller: controller);
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getNotification();
                controller.markNotificationAsRead();
              },
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: controller.allNotification.length,
                itemBuilder: (context, index) {
                  final notification = controller.allNotification[index];
                  return NotificationCard(
                    notification: notification,
                    controller: controller,
                    index: index,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
