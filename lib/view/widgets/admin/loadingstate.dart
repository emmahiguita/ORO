import 'package:flutter/material.dart';
import 'package:oro/view/widgets/admin/shimmercard.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => const ShimmerCard(),
    );
  }
}
