import 'package:flutter/material.dart';
import 'package:oro/controller/admin/settings/createnewadminaccountcontroller.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/view/widgets/admin/PasswordFieldWidget.dart';
import 'package:oro/view/widgets/admin/inputfieldwidget.dart';

class FormSectionWidget extends StatelessWidget {
  final CreateNewAdminAccountControllerImp controller;

  const FormSectionWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            InputFieldWidget(
              controller: controller.username!,
              label: 'Administrator Username',
              hint: 'Enter administrator\'s username',
              icon: Icons.person_outline,
              validator: (value) => vaildInput(value!, "username"),
            ),

            const SizedBox(height: 20),

            // Email Field
            InputFieldWidget(
              controller: controller.email!,
              label: 'Email Address',
              hint: 'Enter official email address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => vaildInput(value!, "email"),
            ),

            const SizedBox(height: 20),

            // Phone Number Field
            InputFieldWidget(
              controller: controller.phoneNumber!,
              label: 'Phone Number',
              hint: 'Enter contact phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) => vaildInput(value!, "PhoneNumber"),
            ),

            const SizedBox(height: 20),

            // Password Field
            PasswordFieldWidget(
              controller: controller.password!,
              label: 'Contraseña',
              hint: 'Create a strong password',
              validator: (value) => vaildInput(value!, "password"),
            ),

            const SizedBox(height: 20),

            // Confirm Password Field
            PasswordFieldWidget(
              controller: controller.confirmPassword!,
              label: 'Confirm Password',
              hint: 'Re-enter the password',
              validator: (value) {
                if (value != controller.password!.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              isConfirmPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
