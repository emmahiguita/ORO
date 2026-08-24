import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/delivery/deliveryorderdetailscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/addresshnfocard.dart';
import 'package:oro/view/widgets/delivery/itemcard.dart';
import 'package:oro/view/widgets/delivery/header.dart';

class DeliveryOrderDetails extends StatelessWidget {
  const DeliveryOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryOrderDetailsControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        backgroundColor: Appcolor.white,
        title: const Text('Detalle del pedido'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<DeliveryOrderDetailsControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loding) {
            return const Center(child: CircularProgressIndicator());
          }
          final cameraPosition = CameraPosition(
            target: LatLng(
              controller.undeliveredOrders.addressLat ?? 0,
              controller.undeliveredOrders.addressLong ?? 0,
            ),
            zoom: 14.4746,
          );

          final marker = Marker(
            markerId: const MarkerId('deliveryLocation'),
            position: LatLng(
              controller.undeliveredOrders.addressLat ?? 0,
              controller.undeliveredOrders.addressLong ?? 0,
            ),
            infoWindow: InfoWindow(
              title: controller.undeliveredOrders.addressName ??
                  'Delivery Location',
            ),
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Items Section
                const SectionHeader(title: 'Order Items'),
                const SizedBox(height: 8),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.orderDetails.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) => ItemCard(
                    imageUrl: AppLink.itemimage +
                        (controller.orderDetails[index].itemImg ?? ''),
                    name: controller.orderDetails[index].itemName ?? 'N/A',
                    description: controller.orderDetails[index].itemDesc ??
                        'No description',
                  ),
                ),
                const SizedBox(height: 24),
                // Delivery Location Map
                const SectionHeader(title: 'Delivery Location'),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        GoogleMap(
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          mapToolbarEnabled: false,
                          tiltGesturesEnabled: false,
                          mapType: MapType.normal,
                          markers: {marker},
                          initialCameraPosition: cameraPosition,
                          onMapCreated:
                              (GoogleMapController googleMapController) {
                            googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition),
                            );
                          },
                        ),
                        if (!controller.isDelivered)
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: FloatingActionButton.small(
                              backgroundColor: Appcolor.berry,
                              onPressed: () {
                                controller.goToNavigation();
                              },
                              child: const Icon(Icons.navigation,
                                  color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  controller.undeliveredOrders.addressBymap ??
                      'No address available',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                // Delivery Address Details
                const SectionHeader(title: 'Address Details'),
                const SizedBox(height: 8),
                AddressInfoCard(
                  addressName: controller.undeliveredOrders.addressName,
                  building: controller.undeliveredOrders.addressBuilding,
                  apartment: controller.undeliveredOrders.addressApt,
                  floor: controller.undeliveredOrders.addressFloor,
                  street: controller.undeliveredOrders.addressStreet,
                  block: controller.undeliveredOrders.addressBlock,
                  way: controller.undeliveredOrders.addressWay,
                ),
                const SizedBox(height: 16),

                // Additional Information
                if (controller
                        .undeliveredOrders.addressAdditional?.isNotEmpty ??
                    false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: 'Additional Information'),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.undeliveredOrders.addressAdditional ?? '',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
