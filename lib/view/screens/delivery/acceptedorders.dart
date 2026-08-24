import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/deliverylist.dart';
import 'package:oro/view/widgets/delivery/emptydeliverylist.dart';

class AcceptedOrders extends StatelessWidget {
  const AcceptedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'My Deliveries',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
        ),
        body: GetBuilder<AcceptedOrdersControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loding) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Appcolor.berry),
                ),
              );
            }

            if (controller.acceptedOrders.isEmpty) {
              return EmptyDeliveryList(controller: controller);
            }

            return DeliveryList(controller: controller);
          },
        ),
      ),
    );
  }
}
