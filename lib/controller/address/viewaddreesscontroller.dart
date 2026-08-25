import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/address/addressdata.dart';
import 'package:oro/data/model/addressmodel.dart';
import 'package:oro/view/screens/address/addadress.dart';
import 'package:oro/view/screens/address/updateadress.dart';

abstract class ViewAddressController extends GetxController {
  getUserAddresses();
  determinePosition();
  goToAddAddress();
  deleteAddress(int addressId);
  goToUpdate(AddressModel addressMode);
}

class ViewAddressControllerImp extends ViewAddressController {
  Services services = Get.find<Services>();
  AddressData addressData = AddressData(Get.find());
  List<AddressModel> addresses = [];
  late StatusRequest statusRequest;

  @override
  getUserAddresses() async {
    statusRequest = StatusRequest.loding;
    var response = await addressData.getAddress(services.userId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        addresses.addAll(data.map(
          (e) => AddressModel.fromJson(e),
        ));
        print("done");
      } else if (response["status"] == "failure") {}
    }
    update();
  }

  @override
  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDisabledSnackbar();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationPermissionDeniedSnackbar();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationPermissionPermanentlyDeniedSnackbar();
      return;
    }
  }

  void _showLocationServiceDisabledSnackbar() {
    Get.snackbar(
      '📍 Location Services',
      'Please enable location services',
      backgroundColor: Appcolor.mimiPink,
      colorText: Appcolor.textColor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 12,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      icon: const Icon(Icons.location_off, color: Appcolor.rosePompadour),
      mainButton: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Appcolor.rosePompadour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () async {
          await Geolocator.openLocationSettings();
          Get.back();
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Text(
              'SETTINGS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPermissionDeniedSnackbar() {
    Get.snackbar(
      '🔒 Permission Needed',
      'Allow location access for full features',
      backgroundColor: Appcolor.mimiPink,
      colorText: Appcolor.textColor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 12,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      icon: const Icon(Icons.lock_outline, color: Appcolor.rosePompadour),
      mainButton: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Appcolor.amaranthpink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () async {
          await Geolocator.openAppSettings();
          Get.back();
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_open, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Text(
              'ALLOW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPermissionPermanentlyDeniedSnackbar() {
    Get.snackbar(
      '⚠️ Permission Blocked',
      'Enable in app settings to continue',
      backgroundColor: Appcolor.mimiPink,
      colorText: Appcolor.textColor,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 12,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 5),
      isDismissible: true,
      icon: const Icon(Icons.warning, color: Appcolor.rosePompadour),
      mainButton: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Appcolor.rosePompadour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () async {
          await Geolocator.openAppSettings();
          Get.back();
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings, color: Colors.white, size: 18),
            SizedBox(width: 4),
            Text(
              'FIX NOW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  deleteAddress(addressId) {
    addressData.deleteAddress(addressId.toString());
    addresses.removeWhere(
      (element) => element.addressId == addressId,
    );
    update();
  }

  @override
  goToUpdate(addressMode) {
    Get.to(() => const UpdateAdress(), arguments: {"addressMode": addressMode});
  }

  @override
  void onInit() {
    determinePosition();
    getUserAddresses();
    super.onInit();
  }

  @override
  goToAddAddress() {
    Get.to(() => const AddAdress());
  }
}
