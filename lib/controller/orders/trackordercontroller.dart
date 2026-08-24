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
      Get.put(OrderDetailsControllerImp());

  StatusRequest statusRequest = StatusRequest.none;

  @override
  drawPolyline() async {
    polylineSet = await getPolyLine(deliveryLatitude, deliveryLongitude,
        orderDetailsModel.addressLat, orderDetailsModel.addressLong);
    update();
  }

  @override
  void onInit() async {
    statusRequest = StatusRequest.loding;
    orderid = Get.arguments['orderid'];
    await orderDetailsControllerImp.getOrderDetails(orderid);
    orderDetailsModel = orderDetailsControllerImp.orderDetails[0];
    statusRequest = StatusRequest.none;
    update();

    markers.add(Marker(
      markerId: const MarkerId("Destination"),
      position:
          LatLng(orderDetailsModel.addressLat!, orderDetailsModel.addressLong!),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ));

    FirebaseFirestore.instance
        .collection("delivery")
        .doc(orderDetailsModel.orderId.toString())
        .snapshots()
        .listen(
      (event) async {
        if (event.exists) {
          print(event.get("long"));
          print(
              "===============================================================");
          deliveryLatitude = event.get("lat");
          deliveryLongitude = event.get("long");
          markers.removeWhere(
              (marker) => marker.markerId.value == "DeliveryLocation");
          markers.add(Marker(
            markerId: const MarkerId("DeliveryLocation"),
            infoWindow: const InfoWindow(
              title: "Delivery Location",
              snippet: "Current delivery location",
            ),
            position: LatLng(
              deliveryLatitude ?? 0,
              deliveryLongitude ?? 0,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
          ));
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

          update();
        }
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    googleMapController?.dispose();
    super.onClose();
  }
}
