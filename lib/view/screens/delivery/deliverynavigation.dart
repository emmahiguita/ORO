import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/delivery/deliverynavigationcontroller.dart';
import 'package:oro/core/constant/color.dart';

class DeliveryNavigation extends StatelessWidget {
  const DeliveryNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryNavigationControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delivery Navigation"),
          centerTitle: true,
          backgroundColor: Appcolor.berry,
          actions: [
            IconButton(
              onPressed: () {
                Get.find<DeliveryNavigationControllerImp>().drawPolyline();
              },
              icon: const Icon(
                Icons.refresh,
                color: Appcolor.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<DeliveryNavigationControllerImp>(
          builder: (controller) => GoogleMap(
            polylines: controller.polylineSet ?? {},
            mapType: MapType.normal,
            markers: controller.markers.toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                controller.deliveryLatitude ??
                    controller.undeliveredOrders.addressLat!,
                controller.deliveryLongitude ??
                    controller.undeliveredOrders.addressLong!,
              ),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              controller.googleMapController = googleMapController;
            },
          ),
        ));
  }
}
