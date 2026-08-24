import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/deliveredcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/deliverycard.dart';
import 'package:oro/view/widgets/delivery/deliveryheader.dart';
import 'package:oro/view/widgets/delivery/emptystatewidget.dart';

class ViewDelivered extends StatelessWidget {
  const ViewDelivered({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveredControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Delivery History',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: GetBuilder<DeliveredControllerImp>(
        builder: (controller) =>
            controller.statusRequest == StatusRequest.loding
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Appcolor.berry),
                    ),
                  )
                : controller.delivered.isEmpty
                    ? const EmptyStateWidget()
                    : Column(
                        children: [
                          // Header with total deliveries
                          DeliveryHeader(controller: controller),

                          // Delivery list
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: controller.delivered.length,
                              itemBuilder: (context, index) => DeliveryCard(
                                controller: controller,
                                index: index,
                              ),
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}
