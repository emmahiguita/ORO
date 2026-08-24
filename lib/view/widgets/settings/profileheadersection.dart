import 'package:flutter/material.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/settings/bannerimagewidget.dart';
import 'package:oro/view/widgets/settings/profilepicturewidget.dart';

class ProfileHeaderSection extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const ProfileHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Banner Image Section
          BannerImageWidget(controller: controller),
          const SizedBox(height: 20),
          // Profile Picture Section
          ProfilePictureWidget(controller: controller),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
