import 'dart:async';

import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/constant/apikey.dart';
import 'package:oro/view/screens/address/addmoredetails.dart';

abstract class AddAddressController extends GetxController {
  getUserLocation();
  addMarker(LatLng position);
  goToAddMoreDetails();
  changeMapType();
}

class AddAddressControllerImp extends AddAddressController {
  LatLng? currentPosition;
  Completer<GoogleMapController>? googleMapController;
  Set<Marker> markers = {};
  double? latitude;
  double? longitude;
  bool isUserLocationMarked = false;
  String? placeName;
  final String googleApiKey = ApiKeys.gMap;
  bool isDone = false;
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

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(23.5880, 58.3829),
    zoom: 14.4746,
  );

  // New method to get place name from coordinates
  Future<void> _getPlaceName(LatLng position) async {
    try {
      final places = GoogleMapsPlaces(apiKey: googleApiKey);
      final response = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        10, // Radius in meters
      );

      if (response.isOkay && response.results.isNotEmpty) {
        placeName = response.results.first.name;
        print("Place name: $placeName");
        update();
      }
    } catch (e) {
      print("Error getting place name: $e");
      placeName = "Unknown Location"; // Fallback name
      update();
    }
  }

  @override
  addMarker(position) async {
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
    update();
  }

  @override
  goToAddMoreDetails() async {
    isDone = true;
    update();
    await _getPlaceName(currentPosition!);
    Get.to(
      () => const AddMoreDetails(),
      arguments: {
        "latitude": latitude,
        "longitude": longitude,
        "placeName": placeName,
        "markers": markers,
      },
    );
    isDone = false;
    update();
  }

  @override
  void onInit() {
    googleMapController = Completer<GoogleMapController>();
    getUserLocation();
    super.onInit();
  }
}
