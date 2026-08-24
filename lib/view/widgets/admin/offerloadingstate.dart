import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/view/widgets/admin/infosection.dart';
import 'package:oro/view/widgets/admin/offersectionheader.dart';

class OfferLoadingState extends StatelessWidget {
  const OfferLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OfferSectionHeader(
            title: 'Current Offer',
            isLoading: true,
          ),
          const SizedBox(height: 16),
          _buildShimmerCard(),
          const SizedBox(height: 32),
          const InfoSection(isLoading: true),
        ],
      ),
    );
  }
}

Widget _buildShimmerCard() {
  return Card(
    elevation: 4,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
