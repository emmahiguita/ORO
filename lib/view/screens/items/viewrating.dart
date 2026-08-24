import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/rating/ratingcontroller.dart';
import 'package:oro/core/constant/color.dart';

class ViewRating extends StatelessWidget {
  const ViewRating({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RatingControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        title: Text(
          'All Ratings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Appcolor.black,
              ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<RatingControllerImp>(
        builder: (controller) => controller.allRating.isEmpty
            ? Container(
                margin: const EdgeInsets.only(bottom: 140),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "lottie/review.json",
                        fit: BoxFit.contain,
                        frameRate: const FrameRate(60),
                        height: 180,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_outline,
                              color: Appcolor.amaranthpink,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "No reviews yet",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHigh
                    .withValues(alpha: 0.05),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: controller.allRating.length,
                  itemBuilder: (context, index) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: controller.isFading[index] ? 0.0 : 1.0,
                      curve: Curves.easeInOut,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: const Color.fromARGB(255, 255, 239, 244),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: AppLink.pfpimage +
                                            controller
                                                .allRating[index].userPfp!,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 40,
                                          height: 40,
                                          color: Colors.grey[200],
                                          child: Icon(Icons.person,
                                              size: 20,
                                              color: Colors.grey[400]),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: 40,
                                          height: 40,
                                          color: Colors.grey[200],
                                          child: Icon(Icons.person,
                                              size: 20,
                                              color: Colors.grey[400]),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  controller.allRating[index]
                                                      .userName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  if (controller
                                                          .allRating[index]
                                                          .userId!
                                                          .toString() ==
                                                      controller.id)
                                                    InkWell(
                                                      splashColor: Appcolor
                                                          .berry
                                                          .withAlpha(100),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      onTap: () {
                                                        controller.deleteRating(
                                                            controller
                                                                .allRating[
                                                                    index]
                                                                .ratingId
                                                                .toString(),
                                                            index);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 6,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .primary
                                                              .withAlpha(25),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Icon(
                                                          Icons.delete_rounded,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withAlpha(25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          controller
                                                              .allRating[index]
                                                              .ratingStars!,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            Jiffy.parse(controller
                                                    .allRating[index]
                                                    .ratingDatetime!)
                                                .fromNow(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: RatingBarIndicator(
                                    rating: double.parse(controller
                                        .allRating[index].ratingStars!),
                                    itemBuilder: (context, index) => const Icon(
                                        Icons.star_rounded,
                                        color: Appcolor.amaranthpink),
                                    itemCount: 5,
                                    itemSize: 28.0,
                                    unratedColor: Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.allRating[index].ratingComment!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(height: 1.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
