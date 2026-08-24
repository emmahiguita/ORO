import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/orders/orderdetailscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/screens/address/updateadress.dart';
import 'package:oro/view/widgets/orders/helpoption.dart';
import 'package:oro/view/widgets/orders/inforow.dart';
import 'package:oro/view/widgets/orders/sectionheader.dart';

import '../../widgets/orders/orderdetailrow.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Detalle del pedido',
            style: TextStyle(
                color: Appcolor.amaranthpink,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Appcolor.amaranthpink,
        ),
        elevation: 0,
      ),
      body: GetBuilder<OrderDetailsControllerImp>(builder: (controller) {
        if (controller.orderDetails.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(
            color: Appcolor.amaranthpink,
          ));
        }

        final int orderType = controller.orderDetails[0].orderType ?? 0;
        final List<Map<String, dynamic>> steps = controller.getSteps(orderType);
        final int currentStatus = controller.orderDetails[0].orderStatus!;
        final isDelivery = orderType == 0;
        final isCancelled = currentStatus == -1;
        final isArchived = currentStatus == 6;

        final currentStepIndex = isDelivery
            ? currentStatus == 2
                ? 2
                : currentStatus == 3
                    ? 3
                    : currentStatus == 6
                        ? 4
                        : currentStatus >= 1
                            ? 1
                            : 0
            : currentStatus == 4
                ? 2
                : currentStatus == 5
                    ? 3
                    : currentStatus == 6
                        ? 4
                        : currentStatus >= 1
                            ? 1
                            : 0;

        final isCurrentStepCompleted =
            (isDelivery && (currentStatus == 3 || currentStatus == 6)) ||
                (!isDelivery && (currentStatus == 5 || currentStatus == 6));

        late final GlobalKey<GoogleMapState> mapKey;
        late final CameraPosition cameraPosition;
        late final Marker marker;

        if (orderType == 0) {
          mapKey = GlobalKey();
          cameraPosition = CameraPosition(
            target: LatLng(controller.orderDetails[0].addressLat ?? 0,
                controller.orderDetails[0].addressLong ?? 0),
            zoom: 14.4746,
          );
          marker = Marker(
            markerId: const MarkerId('1'),
            position: LatLng(controller.orderDetails[0].addressLat ?? 0,
                controller.orderDetails[0].addressLong ?? 0),
            alpha: 1.0,
            anchor: const Offset(0.5, 1.0),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ORDER #${controller.orderDetails[0].orderId!}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.amaranthpink,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: controller
                                  .getStatusColor(
                                      controller.orderDetails[0].orderStatus!,
                                      orderType)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: controller.getStatusColor(
                                    controller.orderDetails[0].orderStatus!,
                                    orderType),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              controller.getStatusText(
                                  controller.orderDetails[0].orderStatus!,
                                  orderType),
                              style: TextStyle(
                                  color: controller.getStatusColor(
                                      controller.orderDetails[0].orderStatus!,
                                      orderType),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      InfoRow(
                        icon: Icons.calendar_today,
                        title: Jiffy.parse(
                                controller.orderDetails[0].orderDatetime!)
                            .format(pattern: 'MMM dd, yyyy - hh:mm a'),
                        subtitle: Jiffy.parse(
                                controller.orderDetails[0].orderDatetime!)
                            .fromNow(),
                      ),
                      const SizedBox(height: 12),
                      InfoRow(
                        icon: orderType == 0
                            ? Icons.delivery_dining
                            : Icons.store,
                        title: orderType == 0 ? 'Delivery' : 'Pickup',
                        subtitle: orderType == 0
                            ? '${controller.orderDetails[0].orderPricedelivery}\$'
                            : 'Pickup at store',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: "Order Items"),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.orderDetails.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 24,
                          color: Colors.grey[200],
                          thickness: 1,
                        ),
                        itemBuilder: (context, index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  AppLink.itemimage +
                                      controller.orderDetails[index].itemImg!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[100],
                                    child: Icon(
                                      Icons.fastfood,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.orderDetails[index].itemName!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    controller.orderDetails[index].itemDesc!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Appcolor.amaranthpink
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Appcolor.amaranthpink
                                                .withValues(alpha: 0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          controller.orderDetails[index]
                                              .categoryName!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Appcolor.amaranthpink,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Price:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${controller.orderDetails[index].itemFinalPrice}\$",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolor.amaranthpink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(height: 1, color: Colors.grey[200]),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Total:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${controller.orderDetails[0].orderTotalprice}\$",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.amaranthpink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (orderType == 0) ...[
                const SectionHeader(title: "Dirección de entrega"),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Appcolor.amaranthpink
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Appcolor.amaranthpink,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              controller.orderDetails[0].addressName!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  controller.orderDetails[0].addressBymap!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              DetailRow(
                                label: "Building",
                                value:
                                    controller.orderDetails[0].addressBuilding!,
                              ),
                              DetailRow(
                                label: "Street",
                                value:
                                    controller.orderDetails[0].addressStreet!,
                              ),
                              DetailRow(
                                label: "Block",
                                value: controller.orderDetails[0].addressBlock!,
                              ),
                              DetailRow(
                                label: "Floor",
                                value: controller.orderDetails[0].addressFloor!,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.grey[200]!, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GoogleMap(
                              key: mapKey,
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
                                  CameraUpdate.newCameraPosition(
                                      cameraPosition),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              if (orderType == 1) ...[
                const SectionHeader(title: "Pickup Information"),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Appcolor.amaranthpink
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.store,
                                color: Appcolor.amaranthpink,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Store Pickup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  "Please come to our store to pick up your order when it's ready",
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const DetailRow(
                                  label: "Pickup Time",
                                  value:
                                      "When order status is 'Ready for Pickup'"),
                              const DetailRow(
                                  label: "Location",
                                  value: "123 Main Street, City Center"),
                              const DetailRow(
                                  label: "Contact", value: "+123 456 7890"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              const SectionHeader(title: "Order Status"),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: steps.length,
                          itemBuilder: (context, idx) {
                            final step = steps[idx];
                            final isCompleted = idx < currentStepIndex ||
                                (idx == currentStepIndex &&
                                    isCurrentStepCompleted);
                            final isLast = idx == steps.length - 1;
                            final isCurrent = idx == currentStepIndex;

                            return SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isCancelled
                                              ? Colors.red[300]
                                              : isArchived
                                                  ? Colors.grey[300]
                                                  : isCompleted
                                                      ? Appcolor.amaranthpink
                                                      : Colors.grey[200],
                                          border: Border.all(
                                            color: isCancelled
                                                ? const Color.fromARGB(
                                                    255, 175, 0, 0)
                                                : isArchived
                                                    ? Colors.grey
                                                    : isCompleted
                                                        ? Appcolor.amaranthpink
                                                        : Colors.grey[300]!,
                                            width: 2,
                                          ),
                                        ),
                                        child: isCancelled
                                            ? const Icon(Icons.close,
                                                size: 20, color: Colors.white)
                                            : isArchived
                                                ? const Icon(Icons.archive,
                                                    size: 20,
                                                    color: Colors.white)
                                                : Icon(step['icon'],
                                                    size: 20,
                                                    color: isCompleted
                                                        ? Colors.white
                                                        : isCurrent
                                                            ? Appcolor
                                                                .amaranthpink
                                                            : Colors.grey[500]),
                                      ),
                                      if (isCurrent &&
                                          !isCancelled &&
                                          !isArchived)
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Appcolor.amaranthpink
                                                .withValues(alpha: 0.1),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    step['title']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: isCancelled
                                          ? Colors.red[300]
                                          : isArchived
                                              ? Colors.grey
                                              : isCompleted
                                                  ? Colors.black
                                                  : Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    (isCancelled
                                        ? "Cancelado"
                                        : isArchived
                                            ? "Archived"
                                            : isCurrent
                                                ? isCurrentStepCompleted
                                                    ? "Completed"
                                                    : "In Progress"
                                                : isCompleted
                                                    ? "Completed"
                                                    : "Pendiente"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isCancelled
                                          ? Colors.red[300]
                                          : isArchived
                                              ? Colors.grey
                                              : isCompleted
                                                  ? Appcolor.amaranthpink
                                                  : Colors.grey[400],
                                    ),
                                  ),
                                  if (!isLast)
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: 40,
                                          height: 2,
                                          color: isCancelled
                                              ? Colors.red[300]
                                              : isArchived
                                                  ? Colors.grey[300]
                                                  : idx < currentStepIndex ||
                                                          (idx == currentStepIndex &&
                                                              isCurrentStepCompleted)
                                                      ? Appcolor.amaranthpink
                                                      : Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      HelpOption(
                        icon: Icons.headset_mic,
                        title: "Contact Support",
                        subtitle: "Get help with your order",
                        onTap: () {},
                      ),
                      Divider(height: 24, color: Colors.grey[200]),
                      HelpOption(
                        icon: Icons.replay,
                        title: "Report an Issue",
                        subtitle: "Having problems with your order?",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
