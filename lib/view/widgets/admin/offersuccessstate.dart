import 'package:flutter/material.dart';
import 'package:oro/controller/admin/offermessage/offercontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/infosection.dart';
import 'package:oro/view/widgets/admin/offercard.dart';
import 'package:oro/view/widgets/admin/offersectionheader.dart';

class OfferSuccessState extends StatelessWidget {
  final OfferControllerImp controller;
  const OfferSuccessState({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.getOfferMessage(),
      color: Appcolor.berry,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OfferSectionHeader(
              title: 'Current Offer',
              isLoading: false,
            ),
            const SizedBox(height: 16),
            OfferCard(controller: controller),
            const SizedBox(height: 32),
            const InfoSection(
              isLoading: false,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
