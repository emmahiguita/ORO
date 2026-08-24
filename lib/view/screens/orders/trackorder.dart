import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/controller/orders/trackordercontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackOrderControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Tracking"),
          centerTitle: true,
          backgroundColor: Appcolor.berry,
          actions: [
            IconButton(
              onPressed: () {
                Get.find<TrackOrderControllerImp>().drawPolyline();
              },
              icon: const Icon(
                Icons.refresh,
                color: Appcolor.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<TrackOrderControllerImp>(
          builder: (controller) =>
              controller.statusRequest == StatusRequest.loding
                  ? const Center(
                      child: GradientProgressIndicator(strokeWidth: 6),
                    )
                  : GoogleMap(
                      polylines: controller.polylineSet ?? {},
                      mapType: MapType.normal,
                      markers: controller.markers.toSet(),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          controller.deliveryLatitude ??
                              controller.orderDetailsModel.addressLat!,
                          controller.deliveryLongitude ??
                              controller.orderDetailsModel.addressLong!,
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
