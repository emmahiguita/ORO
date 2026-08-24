import 'package:flutter/material.dart';
import 'package:oro/controller/setting/viewratingcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/settings/ratingcard.dart';

class RatingsList extends StatelessWidget {
  final ViewRatingControllerImp controller;

  const RatingsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getAllRating();
      },
      color: Appcolor.berry,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: controller.allRating.length,
        itemBuilder: (context, index) => RatingCard(
          controller: controller,
          index: index,
        ),
      ),
    );
  }
}
