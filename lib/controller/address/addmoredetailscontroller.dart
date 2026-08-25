import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/address/addressdata.dart';
import 'package:oro/view/screens/address/viewaddress.dart';
import 'package:oro/view/screens/home/homescreen.dart';

abstract class AddMoreDetailsController extends GetxController {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2);
  String estimateDeliveryTime(double distanceKm);
  Future<String> getDeliveryEstimate();
  sendData();
}

class AddMoreDetailsControllerImp extends AddMoreDetailsController {
  Services services = Get.find<Services>();

  double? lat;
  double? long;
  String? placeName;
  Set<Marker>? markers;
  late String deliverytime;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController? addressName;
  TextEditingController? buildingName;
  TextEditingController? aptNumber;
  TextEditingController? floor;
  TextEditingController? street;
  TextEditingController? block;
  TextEditingController? way;
  TextEditingController? additionalDetails;

  AddressData addressData = AddressData(Get.find());
  late StatusRequest statusRequest;

  @override
  void onInit() {
    lat = Get.arguments["latitude"];
    long = Get.arguments["longitude"];
    placeName = Get.arguments["placeName"];
    markers = Get.arguments["markers"];
    getDeliveryEstimate();

    addressName = TextEditingController();
    buildingName = TextEditingController();
    aptNumber = TextEditingController();
    floor = TextEditingController();
    street = TextEditingController();
    block = TextEditingController();
    way = TextEditingController();
    additionalDetails = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    addressName!.dispose();
    buildingName!.dispose();
    aptNumber!.dispose();
    floor!.dispose();
    street!.dispose();
    block!.dispose();
    way!.dispose();
    additionalDetails!.dispose();
    super.dispose();
  }

  @override
  sendData() async {
    var fomrstate = formkey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await addressData.addAddress(
        services.userId,
        addressName!.text,
        buildingName!.text,
        aptNumber!.text,
        floor!.text,
        street!.text,
        block!.text,
        way?.text ?? "",
        additionalDetails?.text ?? "",
        placeName ?? "Unknown Location",
        deliverytime,
        markers.toString(),
        lat!.toString(),
        long!.toString(),
      );
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.offAll(() => const HomeScreen(),
              transition: Transition.fade, arguments: {'num': 3});
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.to(() => const ViewAddress(), transition: Transition.fade);
          });
        } else if (response["status"] == "failure") {
          statusRequest = StatusRequest.failure;
        }
      }
    }
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
  Future<String> getDeliveryEstimate() async {
    try {
      const storeLat = 25.217831827869052;
      const storeLng = 55.31375885009766;

      double distance = calculateDistance(storeLat, storeLng, lat!, long!);

      deliverytime = estimateDeliveryTime(distance);

      return estimateDeliveryTime(distance);
    } catch (e) {
      return "Delivery time unavailable";
    }
  }
}
