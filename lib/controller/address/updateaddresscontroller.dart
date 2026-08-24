import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/address/addressdata.dart';
import 'package:oro/data/model/addressmodel.dart';
import 'package:oro/view/screens/address/updateadressmap.dart';
import 'package:oro/view/screens/address/viewaddress.dart';
import 'package:oro/view/screens/settings/settings.dart';

abstract class UpdateAddressController extends GetxController {
  goToMap();
  updateData();
  double calculateDistance(double lat1, double lon1, double lat2, double lon2);
  String estimateDeliveryTime(double distanceKm);
  Future<String> getDeliveryEstimate(double userlat, double userlong);
}

class UpdateAddressControllerImp extends UpdateAddressController {
  final Services services = Get.find<Services>();
  AddressModel? addressMode;

  double? lat;
  double? long;
  String? placeName;
  Set<Marker>? markers;
  bool isMapUpdated = false;
  late String deliverytime;

  late GlobalKey<FormState> formkey;

  late TextEditingController addressName;
  late TextEditingController buildingName;
  late TextEditingController aptNumber;
  late TextEditingController floor;
  late TextEditingController street;
  late TextEditingController block;
  late TextEditingController way;
  late TextEditingController additionalDetails;

  final AddressData addressData = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    formkey = GlobalKey<FormState>();
    addressMode = Get.arguments["addressMode"];

    addressName = TextEditingController();
    buildingName = TextEditingController();
    aptNumber = TextEditingController();
    floor = TextEditingController();
    street = TextEditingController();
    block = TextEditingController();
    way = TextEditingController();
    additionalDetails = TextEditingController();

    addressName.text = addressMode!.addressName ?? '';
    buildingName.text = addressMode!.addressBuilding ?? '';
    aptNumber.text = addressMode!.addressApt ?? '';
    floor.text = addressMode!.addressFloor ?? '';
    street.text = addressMode!.addressStreet ?? '';
    block.text = addressMode!.addressBlock ?? '';
    way.text = addressMode!.addressWay ?? '';
    additionalDetails.text = addressMode!.addressAdditional ?? '';

    isMapUpdated = Get.arguments["isMapUpdated"] ?? false;

    if (!isMapUpdated) {
      placeName = addressMode!.addressBymap;
      if (addressMode!.addressLat != null && addressMode!.addressLong != null) {
        try {
          Marker marker = Marker(
              markerId: const MarkerId('1'),
              position:
                  LatLng(addressMode!.addressLat!, addressMode!.addressLong!));
          markers = {marker};
        } catch (e) {
          markers = {};
        }
      } else {
        markers = {};
      }
      lat = addressMode!.addressLat;
      long = addressMode!.addressLong;
      getDeliveryEstimate(lat!, long!);
    } else {
      placeName = Get.arguments["newplacename"] ?? addressMode!.addressBymap;
      markers = Get.arguments["newmarker"] ?? {};
      lat = Get.arguments["newlat"] ?? addressMode!.addressLat;
      long = Get.arguments["newlong"] ?? addressMode!.addressLong;
      getDeliveryEstimate(lat!, long!);
    }

    super.onInit();
  }

  @override
  void dispose() {
    addressName.dispose();
    buildingName.dispose();
    aptNumber.dispose();
    floor.dispose();
    street.dispose();
    block.dispose();
    way.dispose();
    additionalDetails.dispose();
    super.dispose();
  }

  @override
  updateData() async {
    if (formkey.currentState?.validate() ?? false) {
      if (lat == null || long == null) {
        Get.snackbar(
          "Error",
          "Please select a location on the map",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.error),
        );
      }

      statusRequest = StatusRequest.loding;
      update();

      try {
        var response = await addressData.updateAddress(
          addressMode!.addressId.toString(),
          addressName.text,
          buildingName.text,
          aptNumber.text,
          floor.text,
          street.text,
          block.text,
          way.text,
          additionalDetails.text,
          placeName ?? "Unknown Location",
          deliverytime,
          markers.toString(),
          lat!.toString(),
          long!.toString(),
        );

        statusRequest = handlingdata(response);
        update();

        if (statusRequest == StatusRequest.success) {
          if (response["status"] == "success") {
            Get.offAll(() => const Settings(), transition: Transition.fade);
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.to(() => const ViewAddress(), transition: Transition.fade);
            });
          } else {
            Get.snackbar(
              "Error",
              "Failed to update address",
              colorText: Appcolor.charcoalGray,
              backgroundColor: Appcolor.rosePompadour,
              icon: const Icon(Icons.error),
            );
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        statusRequest = StatusRequest.serverfailure;
        Get.snackbar(
          "Error",
          "An error occurred while updating address",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.error),
        );
        update();
      }
    }
  }

  void updateMapLocation(double newLat, double newLong, String newPlaceName,
      Set<Marker> newMarkers) {
    lat = newLat;
    long = newLong;
    placeName = newPlaceName;
    markers = newMarkers;
    isMapUpdated = true;
    getDeliveryEstimate(lat!, long!);
    update();
  }

  @override
  goToMap() {
    Get.to(() => const UpdateAddressMap(), arguments: {
      "oldlat": lat ?? addressMode?.addressLat,
      "oldlong": long ?? addressMode?.addressLong,
      "oldmarker": markers ?? {},
    });
  }

  @override
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  @override
  String estimateDeliveryTime(double distanceKm) {
    const averageSpeedKmPerHour = 60.0;
    const basePreparationTime = 120.0;

    double travelTimeMinutes = (distanceKm / averageSpeedKmPerHour) * 60;
    double totalTimeMinutes = basePreparationTime + travelTimeMinutes;

    totalTimeMinutes = (totalTimeMinutes / 5).ceil() * 5;

    if (totalTimeMinutes < 60) {
      return '${totalTimeMinutes.toInt()} - ${(totalTimeMinutes + 10).toInt()} minutes';
    } else if (totalTimeMinutes < 1440) {
      int hours = (totalTimeMinutes / 60).floor();
      int remainingMinutes = (totalTimeMinutes % 60).round();
      if (remainingMinutes > 15) {
        return '$hours - ${hours + 1} hours';
      } else {
        return '$hours hours';
      }
    } else {
      int days = (totalTimeMinutes / 1440).floor();
      int remainingHours = ((totalTimeMinutes % 1440) / 60).round();

      if (remainingHours > 4) {
        return '$days - ${days + 1} days';
      } else {
        return '$days days';
      }
    }
  }

  @override
  Future<String> getDeliveryEstimate(userlat, userlong) async {
    try {
      const storeLat = 25.217831827869052;
      const storeLng = 55.31375885009766;

      double distance =
          calculateDistance(storeLat, storeLng, userlat, userlong);

      deliverytime = estimateDeliveryTime(distance);

      return estimateDeliveryTime(distance);
    } catch (e) {
      return "Delivery time unavailable";
    }
  }
}
