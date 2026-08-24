import 'dart:async';

import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/constant/apikey.dart';

abstract class UpdateMapController extends GetxController {
  getUserLocation();
  addMarker(LatLng position);
  goToEditMap();
  changeMapType();
}

class UpdateMapControllerImp extends UpdateMapController {
  LatLng? currentPosition;
  Completer<GoogleMapController>? googleMapController;
  Set<Marker> markers = {};
  double? latitude;
  double? longitude;
  bool isUserLocationMarked = false;
  String? placeName;
  final String googleApiKey = ApiKeys.gMap;
  bool isDone = false;
  double? oldlat;
  double? oldlong;
  bool isMapUpdated = false;
  CameraPosition? initialCameraPosition;
  bool loding = false;
  MapType mapType = MapType.normal;

  @override
  getUserLocation() async {
    loding = true;
    update();
    await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).then((value) async {
      final GoogleMapController controller = await googleMapController!.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 19.151926040649414,
          ),
        ),
      );
      update();
    }).catchError((error) {
      print("Error getting location: $error");
    });
    loding = false;
    update();
  }

  @override
  void changeMapType() {
    mapType = MapType.values[(mapType.index + 1) % MapType.values.length];
    update();
  }

  Future<void> _getPlaceName(LatLng position) async {
    try {
      final places = GoogleMapsPlaces(apiKey: googleApiKey);
      final response = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        10,
      );

      if (response.isOkay && response.results.isNotEmpty) {
        placeName = response.results.first.name;
      } else {
        placeName = "Unknown Location";
      }
    } catch (e) {
      placeName = "Unknown Location";
    }
    update();
  }

  @override
  void addMarker(LatLng position) async {
    isMapUpdated = true;
    markers.clear();
    currentPosition = position;
    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(310),
      ),
    );
    isUserLocationMarked = true;
    latitude = position.latitude;
    longitude = position.longitude;

    await _getPlaceName(position);
    update();
  }

  @override
  Future<void> goToEditMap() async {
    if (currentPosition == null) {
      Get.snackbar("Error", "Please select a location on the map");
      return;
    }

    isDone = true;
    update();

    if (placeName == null) {
      await _getPlaceName(currentPosition!);
    }

    Get.back(result: {
      "isMapUpdated": true,
      "newlat": latitude,
      "newlong": longitude,
      "newplacename": placeName,
      "newmarker": markers,
    });
  }

  @override
  void onInit() {
    googleMapController = Completer<GoogleMapController>();
    oldlat = Get.arguments['oldlat'];
    oldlong = Get.arguments['oldlong'];
    markers = Get.arguments['oldmarker'] ?? {};

    if (oldlat != null && oldlong != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(oldlat!, oldlong!),
        zoom: 14.4746,
      );
      currentPosition = LatLng(oldlat!, oldlong!);

      if (markers.isEmpty) {
        markers.add(
          Marker(
            markerId: const MarkerId("1"),
            position: currentPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(310),
          ),
        );
      }
    }

    super.onInit();
  }
}
