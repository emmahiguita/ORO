import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/settings/createnewadminaccountcontroller.dart';
import 'package:oro/view/widgets/admin/CreateAccountButtonWidget.dart';
import 'package:oro/view/widgets/admin/FormSectionWidget.dart';
import 'package:oro/view/widgets/admin/HeaderSectionWidget.dart';
import 'package:oro/view/widgets/admin/PermissionsSectionWidget.dart';
import 'package:oro/view/widgets/admin/SecurityWarningWidget.dart';

class CreateNewAdminAccount extends StatelessWidget {
  const CreateNewAdminAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateNewAdminAccountControllerImp());
    return GetBuilder<CreateNewAdminAccountControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Create Admin Account',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Warning Section
              const SecurityWarningWidget(),

              const SizedBox(height: 20),

              // Header Section
              const HeaderSectionWidget(),

              const SizedBox(height: 30),

              // Form Section
              FormSectionWidget(controller: controller),

              const SizedBox(height: 20),

              // Permissions Section
              const PermissionsSectionWidget(),

              const SizedBox(height: 30),

              // Create Account Button
              CreateAccountButtonWidget(controller: controller),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
