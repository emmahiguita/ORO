import 'package:flutter/material.dart';
import 'package:oro/controller/setting/viewratingcontroller.dart';
import 'package:oro/view/widgets/settings/ratingcardcontent.dart';
import 'package:oro/view/widgets/settings/ratingcardheader.dart';

class RatingCard extends StatelessWidget {
  final ViewRatingControllerImp controller;
  final int index;

  const RatingCard({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final rating = controller.allRating[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingCardHeader(
                controller: controller,
                rating: rating,
              ),
              const SizedBox(height: 20),
              RatingCardContent(
                controller: controller,
                rating: rating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
