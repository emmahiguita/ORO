import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/admin/graphscontent.dart';
import 'package:oro/view/widgets/admin/loadingstate.dart';

class AdminGraph extends StatelessWidget {
  const AdminGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) {
        return controller.statusRequest == StatusRequest.loding
            ? const LoadingState()
            : GraphsContent(controller: controller);
      },
    );
  }
}
