import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/createnewdeliveryaccountcontroller.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/admin/DeliveryInputFieldWidget.dart';
import 'package:oro/view/widgets/admin/DeliveryPasswordFieldWidget.dart';

class DeliveryFormSectionWidget extends StatelessWidget {
  const DeliveryFormSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewDeliveryAccountControllerImp>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Username Field
              DeliveryInputFieldWidget(
                controller: controller.username!,
                label: 'Usuario',
                hint: 'Enter username',
                icon: Icons.person_outline,
                validator: (value) => vaildInput(value!, "username"),
              ),

              const SizedBox(height: 20),

              // Email Field
              DeliveryInputFieldWidget(
                controller: controller.email!,
                label: 'Email Address',
                hint: 'Enter email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => vaildInput(value!, "email"),
              ),

              const SizedBox(height: 20),

              // Phone Number Field
              DeliveryInputFieldWidget(
                controller: controller.phoneNumber!,
                label: 'Phone Number',
                hint: 'Enter phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => vaildInput(value!, "PhoneNumber"),
              ),

              const SizedBox(height: 20),

              // Password Field
              DeliveryPasswordFieldWidget(
                controller: controller.password!,
                label: 'Contraseña',
                hint: 'Create a secure password',
                validator: (value) => vaildInput(value!, "password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
