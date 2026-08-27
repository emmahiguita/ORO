import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/notification/notificationdata.dart';
import 'package:oro/view/screens/delivery/acceptedorders.dart';
import 'package:oro/view/screens/delivery/deliveryrequests.dart';
import 'package:oro/view/screens/delivery/deliverysettings.dart';
import 'package:oro/view/screens/notification/viewnotification.dart';

abstract class DeliveryHomeController extends GetxController {
  void changePage(int i);
  getNotificationsCount();
  Color getIconColor(
      bool isActive, bool isNotificationTab, int unreadCount, ThemeData theme);
  int getUnreadCount();
  Future determinePosition();
}

class DeliveryHomeControllerImp extends DeliveryHomeController {
  late StatusRequest statusRequestNotification;
  NotificationData notificationData = NotificationData(Get.find());
  List data = [];
  Services services = Get.find();

  int currentpage = 0;
  List<Widget> listpages = [
    const DeliveryRequests(),
    const AcceptedOrders(),
    const ViewNotification(),
    const DeliverySettings()
  ];
  List<String> namepages = [
    "Pendiente",
    "Accepted",
    "Notification",
    "Settings",
  ];
  List<IconData> iconpages = [
    Icons.local_shipping,
    Icons.assignment_turned_in,
    Icons.notifications_active,
    Icons.settings,
  ];

  @override
  changePage(i) {
    currentpage = i;
    update();
  }

  @override
  void onInit() {
    determinePosition();
    currentpage = Get.arguments?['num'] ?? 0;
    getNotificationsCount();
    Get.put(AcceptedOrdersControllerImp());
    Get.put(DeliveryRequestsControllerImp());

    super.onInit();
  }

  @override
  getNotificationsCount() async {
    statusRequestNotification = StatusRequest.loding;
    data.clear();
    var response = await notificationData.getNotificationCount(services.userId);
    statusRequestNotification = handlingdata(response);
    if (statusRequestNotification == StatusRequest.success) {
      if (response["status"] == "success") {
        final rawData = response['data'];
        if (rawData is List) {
          data.addAll(rawData);
        } else if (rawData is Map) {
          data.add(rawData);
        } else if (rawData != null) {
          data.add({'unread_count': rawData});
        }
      } else if (response["status"] == "failure") {
        statusRequestNotification = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  int getUnreadCount() {
    try {
      if (data.isNotEmpty && data[0]["unread_count"] != null) {
        return data[0]["unread_count"] as int;
      }
    } catch (e) {
      debugPrint('Error getting unread count: $e');
    }
    return 0;
  }

  @override
  Color getIconColor(
    bool isActive,
    bool isNotificationTab,
    int unreadCount,
    ThemeData theme,
  ) {
    if (isNotificationTab && unreadCount > 0) {
      return Colors.amber.shade600;
    }
    if (isActive) {
      return Appcolor.berry;
    }
    return theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ??
        Colors.grey[600]!;
  }

  @override
  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServiceDisabledDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showLocationPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showLocationPermissionPermanentlyDeniedDialog();
      return;
    }
  }

  Future<void> _showLocationServiceDisabledDialog() async {
    await Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Appcolor.mimiPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolor.rosePompadour.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_off_rounded,
                  color: Appcolor.rosePompadour,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Location Services Disabled',
                  style: TextStyle(
                    color: Appcolor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location services are required to navigate to delivery addresses and provide accurate order tracking to customers.',
                style: TextStyle(
                  color: Appcolor.textColor.withValues(alpha: 0.8),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Appcolor.rosePompadour.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Appcolor.rosePompadour.withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Appcolor.rosePompadour,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This will open your device settings',
                        style: TextStyle(
                          color: Appcolor.textColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Appcolor.rosePompadour.withValues(alpha: 0.3),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      'Not Now',
                      style: TextStyle(
                        color: Appcolor.textColor.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.rosePompadour,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                      Get.back();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Enable Location',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _showLocationPermissionDeniedDialog() async {
    await Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Appcolor.mimiPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolor.amaranthpink.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_disabled_rounded,
                  color: Appcolor.amaranthpink,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Location Permission Required',
                  style: TextStyle(
                    color: Appcolor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location access is essential for delivery navigation and providing real-time updates to customers waiting for their orders.',
                style: TextStyle(
                  color: Appcolor.textColor.withValues(alpha: 0.8),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Appcolor.amaranthpink.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Appcolor.amaranthpink,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Navigate to delivery addresses',
                            style: TextStyle(
                              color: Appcolor.textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Appcolor.amaranthpink,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Provide real-time delivery tracking',
                            style: TextStyle(
                              color: Appcolor.textColor.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Appcolor.amaranthpink.withValues(alpha: 0.3),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      'Skip for Now',
                      style: TextStyle(
                        color: Appcolor.textColor.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.amaranthpink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      Get.back();
                      // Trigger permission request again
                      await Geolocator.requestPermission();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Enable for Delivery',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _showLocationPermissionPermanentlyDeniedDialog() async {
    await Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Appcolor.mimiPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.block_rounded,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Location Access Blocked',
                  style: TextStyle(
                    color: Appcolor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location permission is permanently blocked. To continue making deliveries, you must enable location access in app settings for navigation and order tracking.',
                style: TextStyle(
                  color: Appcolor.textColor.withValues(alpha: 0.8),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.orange,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'How to enable:',
                          style: TextStyle(
                            color: Appcolor.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Tap "App Settings" below\n2. Find "Permissions" or "Location"\n3. Enable "Allow all the time" for deliveries',
                      style: TextStyle(
                        color: Appcolor.textColor.withValues(alpha: 0.7),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Appcolor.rosePompadour.withValues(alpha: 0.3),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Appcolor.textColor.withValues(alpha: 0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.rosePompadour,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                      Get.back();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_applications_rounded, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Fix Location Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
