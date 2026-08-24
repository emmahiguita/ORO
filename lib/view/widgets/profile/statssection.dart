import 'package:flutter/material.dart';
import 'package:oro/controller/profile/profilecontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/profile/statscard.dart';
import 'package:oro/view/widgets/profile/statsshimmer.dart';

class StatsSection extends StatelessWidget {
  final ProfileControllerImp controller;

  const StatsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: controller.statusRequest == StatusRequest.loding
          ? const StatsShimmer()
          : StatsCard(controller: controller),
    );
  }
}
