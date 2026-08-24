import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/createnewdeliveryaccountcontroller.dart';
import 'package:oro/view/widgets/admin/DeliveryCreateAccountButtonWidget.dart';
import 'package:oro/view/widgets/admin/DeliveryFormSectionWidget.dart';
import 'package:oro/view/widgets/admin/DeliveryHeaderSectionWidget.dart';

class CreateNewDeliveryAccount extends StatelessWidget {
  const CreateNewDeliveryAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateNewDeliveryAccountControllerImp());
    return GetBuilder<CreateNewDeliveryAccountControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Create Delivery Account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              DeliveryHeaderSectionWidget(),

              SizedBox(height: 30),

              // Form Section
              DeliveryFormSectionWidget(),

              SizedBox(height: 30),

              // Create Account Button
              DeliveryCreateAccountButtonWidget(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
