import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/deliverysettingscontroller.dart';
import 'package:oro/view/widgets/delivery/deliveryaccountsection.dart';
import 'package:oro/view/widgets/delivery/deliverylogoutbutton.dart';
import 'package:oro/view/widgets/delivery/deliverypreferencessection.dart';
import 'package:oro/view/widgets/delivery/deliveryprofileheader.dart';
import 'package:oro/view/widgets/delivery/deliverysettingsappbar.dart';
import 'package:oro/view/widgets/delivery/deliverystatscard.dart';

class DeliverySettings extends StatelessWidget {
  const DeliverySettings({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DeliverySettingsControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: const DeliverySettingsAppBar(),
        body: GetBuilder<DeliverySettingsControllerImp>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                DeliveryProfileHeader(controller: controller),
                const SizedBox(height: 20),
                DeliveryStatsCard(controller: controller),
                const SizedBox(height: 20),
                DeliveryPreferencesSection(controller: controller),
                const SizedBox(height: 20),
                DeliveryAccountSection(controller: controller),
                const SizedBox(height: 20),
                DeliveryLogoutButton(controller: controller),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
