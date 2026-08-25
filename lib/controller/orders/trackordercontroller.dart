import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/orders/orderdetailscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/polyline.dart';
import 'package:oro/data/model/orderdetailsmodel.dart';

abstract class TrackOrderController extends GetxController {
  drawPolyline();
}

class TrackOrderControllerImp extends TrackOrderController {
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  String? orderid;

  double? deliveryLatitude;
  double? deliveryLongitude;

  List<Marker> markers = [];

  GoogleMapController? googleMapController;

  Set<Polyline>? polylineSet;

  OrderDetailsControllerImp orderDetailsControllerImp =
      Get.isRegistered<OrderDetailsControllerImp>()
          ? Get.find<OrderDetailsControllerImp>()
          : Get.put(OrderDetailsControllerImp());

  StatusRequest statusRequest = StatusRequest.none;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _deliverySubscription;

  @override
  drawPolyline() async {
    polylineSet = await getPolyLine(deliveryLatitude, deliveryLongitude,
        orderDetailsModel.addressLat, orderDetailsModel.addressLong);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    statusRequest = StatusRequest.loding;
    update();

    final args = Get.arguments;
    if (args is Map && args['orderid'] != null) {
      orderid = args['orderid'].toString();
    }

    if (orderid != null && orderid!.isNotEmpty) {
      await orderDetailsControllerImp.getOrderDetails(orderid);
      if (orderDetailsControllerImp.orderDetails.isNotEmpty) {
        orderDetailsModel = orderDetailsControllerImp.orderDetails[0];
      }
    }

    statusRequest = StatusRequest.none;
    update();

    final destLat = orderDetailsModel.addressLat;
    final destLong = orderDetailsModel.addressLong;
    if (destLat != null && destLong != null) {
      markers.add(Marker(
        markerId: const MarkerId("Destination"),
        position: LatLng(destLat, destLong),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ));
    }

    final currentOrderId = orderDetailsModel.orderId ?? orderid;
    if (currentOrderId != null) {
      _deliverySubscription = FirebaseFirestore.instance
          .collection("delivery")
          .doc(currentOrderId.toString())
          .snapshots()
          .listen(
        (event) async {
          if (event.exists) {
            final rawLat = event.data()?['lat'];
            final rawLong = event.data()?['long'];
            deliveryLatitude = rawLat is num
                ? rawLat.toDouble()
                : double.tryParse('$rawLat');
            deliveryLongitude = rawLong is num
                ? rawLong.toDouble()
                : double.tryParse('$rawLong');

            if (deliveryLatitude != null && deliveryLongitude != null) {
              markers.removeWhere(
                  (marker) => marker.markerId.value == "DeliveryLocation");
              markers.add(Marker(
                markerId: const MarkerId("DeliveryLocation"),
                infoWindow: const InfoWindow(
                  title: "Ubicación de entrega",
                  snippet: "Ubicación actual del repartidor",
                ),
                position: LatLng(deliveryLatitude!, deliveryLongitude!),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueYellow),
              ));
              await drawPolyline();
              googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(deliveryLatitude!, deliveryLongitude!),
                    zoom: 15,
                  ),
                ),
              );
              update();
            }
          }
        },
      );
    }
  }

  @override
  void onClose() {
    _deliverySubscription?.cancel();
    googleMapController?.dispose();
    super.onClose();
  }
}
