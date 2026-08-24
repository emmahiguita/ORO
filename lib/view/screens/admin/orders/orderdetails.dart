import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/orders/AdminOrderDetailsController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/OrderSummaryCard.dart';
import 'package:oro/view/widgets/admin/AddressInfoCard.dart';
import 'package:oro/view/widgets/admin/itemcard.dart';
import 'package:oro/view/widgets/admin/sectionheader.dart';

class AdminOrderDetails extends StatelessWidget {
  const AdminOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminOrderDetailsControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        backgroundColor: Appcolor.white,
        title: const Text('Detalle del pedido',
            style: TextStyle(color: Appcolor.berry)),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Appcolor.berry),
      ),
      body: GetBuilder<AdminOrderDetailsControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loding) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Appcolor.berry),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Summary Card
                OrderSummaryCard(controller: controller),
                const SizedBox(height: 20),

                // Order Items Section
                const SectionHeader(title: 'Order Items'),
                const SizedBox(height: 12),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.orderDetails.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) => ItemCard(
                    imageUrl: AppLink.itemimage +
                        (controller.orderDetails[index].itemImg ?? ''),
                    name: controller.orderDetails[index].itemName ?? 'N/A',
                    description: controller.orderDetails[index].itemDesc ??
                        'No description',
                  ),
                ),
                const SizedBox(height: 24),
                if (controller.adminDetailsModel.orderType == 0) ...[
                  // Delivery Location Map
                  const SectionHeader(title: 'Delivery Location'),
                  const SizedBox(height: 12),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolor.berry.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        mapToolbarEnabled: false,
                        tiltGesturesEnabled: false,
                        mapType: MapType.normal,
                        markers: {controller.marker!},
                        initialCameraPosition: controller.cameraPosition!,
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                controller.cameraPosition!),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Appcolor.berry.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.adminDetailsModel.addressBymap ??
                          'No address available',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Delivery Address Details
                  const SectionHeader(title: 'Address Details'),
                  const SizedBox(height: 12),
                  AddressInfoCard(
                    addressName: controller.adminDetailsModel.addressName,
                    building: controller.adminDetailsModel.addressBuilding,
                    apartment: controller.adminDetailsModel.addressApt,
                    floor: controller.adminDetailsModel.addressFloor,
                    street: controller.adminDetailsModel.addressStreet,
                    block: controller.adminDetailsModel.addressBlock,
                    way: controller.adminDetailsModel.addressWay,
                  ),
                  const SizedBox(height: 16),

                  // Additional Information
                  if (controller
                          .adminDetailsModel.addressAdditional?.isNotEmpty ??
                      false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(title: 'Additional Information'),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Appcolor.berry.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text(
                            controller.adminDetailsModel.addressAdditional ??
                                '',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
