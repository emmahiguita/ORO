import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/functions/polyline.dart';
import 'package:oro/data/model/deliveryrequestmodel.dart';

abstract class DeliveryNavigationController extends GetxController {
  drawPolyline();
}

class DeliveryNavigationControllerImp extends DeliveryNavigationController {
  DeliveryRequestModel undeliveredOrders = DeliveryRequestModel();
  String? orderid;

  StreamSubscription<Position>? positionStream;

  double? deliveryLatitude;
  double? deliveryLongitude;

  List<Marker> markers = [];

  GoogleMapController? googleMapController;

  Set<Polyline>? polylineSet;

  @override
  drawPolyline() async {
    polylineSet = await getPolyLine(deliveryLatitude, deliveryLongitude,
        undeliveredOrders.addressLat, undeliveredOrders.addressLong);
    update();
  }

  @override
  void onInit() {
    orderid = Get.arguments['orderid'];
    undeliveredOrders = Get.arguments['undeliveredOrder'];

    markers.add(Marker(
      markerId: const MarkerId("Destination"),
      position:
          LatLng(undeliveredOrders.addressLat!, undeliveredOrders.addressLong!),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ));

    positionStream =
        Geolocator.getPositionStream().listen((Position? position) async {
      deliveryLatitude = position!.latitude;
      deliveryLongitude = position.longitude;
      markers
          .removeWhere((marker) => marker.markerId.value == "DeliveryLocation");
      markers.add(Marker(
        markerId: const MarkerId("DeliveryLocation"),
        infoWindow: const InfoWindow(
          title: "Delivery Location",
          snippet: "Your current delivery location",
        ),
        position: LatLng(
          deliveryLatitude ?? 0,
          deliveryLongitude ?? 0,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ));
      if (googleMapController != null) {
        await drawPolyline();

        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              deliveryLatitude ?? 0,
              deliveryLongitude ?? 0,
            ),
            zoom: 15,
          ),
        ));
      }
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    positionStream?.cancel();
    googleMapController?.dispose();
    super.onClose();
  }
}
