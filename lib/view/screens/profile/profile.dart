import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/profile/profilecontroller.dart';
import 'package:oro/view/widgets/profile/actionssection.dart';
import 'package:oro/view/widgets/profile/headersection.dart';
import 'package:oro/view/widgets/profile/profileinfosection.dart';
import 'package:oro/view/widgets/profile/statssection.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: GetBuilder<ProfileControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Banner and Profile Picture
              HeaderSection(controller: controller),

              // Profile Info Section
              ProfileInfoSection(controller: controller),

              // Stats Section
              StatsSection(controller: controller),

              // Actions Section
              ActionsSection(controller: controller),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
