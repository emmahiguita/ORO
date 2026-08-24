import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/deliveryrequestscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/deliveryrequestslist.dart';
import 'package:oro/view/widgets/delivery/emptydeliveryrequestsstate.dart';

class DeliveryRequests extends StatelessWidget {
  const DeliveryRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Pending Deliveries',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          surfaceTintColor: Colors.transparent,
        ),
        body: GetBuilder<DeliveryRequestsControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loding) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Appcolor.berry),
                ),
              );
            }
            if (controller.undeliveredOrders.isEmpty) {
              return EmptyDeliveryRequestsState(controller: controller);
            }

            return DeliveryRequestsList(controller: controller);
          },
        ),
      ),
    );
  }
}
