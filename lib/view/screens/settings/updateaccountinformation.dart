import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/settings/accountformsection.dart';
import 'package:oro/view/widgets/settings/profileheadersection.dart';
import 'package:oro/view/widgets/settings/savechangesbutton.dart';
import 'package:oro/view/widgets/admin/updateaccountappbar.dart';

class UpdateAccountInformation extends StatelessWidget {
  const UpdateAccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateAccountInformationControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const UpdateAccountAppBar(),
      body: GetBuilder<UpdateAccountInformationControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header Section
              ProfileHeaderSection(controller: controller),

              const SizedBox(height: 20),

              // Form Section
              AccountFormSection(controller: controller),

              const SizedBox(height: 30),

              // Save Button
              SaveChangesButton(controller: controller),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
