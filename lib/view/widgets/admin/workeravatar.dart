import 'package:flutter/material.dart';
import 'package:oro/core/class/graph.dart';
import 'package:oro/core/constant/color.dart';

class WorkerAvatar extends StatelessWidget {
  final DeliveryWorkerData worker;

  const WorkerAvatar({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(worker.userPfpUrl),
              radius: 24,
              backgroundColor: Colors.grey[200],
              onBackgroundImageError: (_, __) {},
              child: worker.userPfpUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      color: Colors.grey[600],
                      size: 24,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            worker.userName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Appcolor.berry.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${worker.numberOfOrders} orders',
              style: const TextStyle(
                fontSize: 10,
                color: Appcolor.berry,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
