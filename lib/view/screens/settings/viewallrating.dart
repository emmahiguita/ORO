import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/setting/viewratingcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/settings/emptyratingsstate.dart';
import 'package:oro/view/widgets/settings/loadingratingsstate.dart';
import 'package:oro/view/widgets/settings/ratingslist.dart';

class ViewAllRating extends StatelessWidget {
  const ViewAllRating({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewRatingControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Ratings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Appcolor.berry,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 2,
      ),
      body: GetBuilder<ViewRatingControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loding) {
            return const LoadingRatingsState();
          }

          if (controller.allRating.isEmpty) {
            return const EmptyRatingsState();
          }

          return RatingsList(controller: controller);
        },
      ),
    );
  }
}
