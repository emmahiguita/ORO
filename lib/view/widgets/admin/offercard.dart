import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/offermessage/offercontroller.dart';
import 'package:oro/view/widgets/home/discountcard.dart';

class OfferCard extends StatelessWidget {
  final OfferControllerImp controller;
  const OfferCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Discountcard(
            title: controller.data[0]["mainpage_title"] ?? 'No Title',
            content: controller.data[0]["mainpage_body"] ?? 'No Description',
            image: CachedNetworkImageProvider(
              AppLink.homeimage + (controller.data[0]["mainpage_image"] ?? ''),
            ),
          ),
        ),
      ),
    );
  }
}
