import 'package:flutter/material.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';

class EmptyChart extends StatelessWidget {
  final String title;

  const EmptyChart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: title,
      chart: SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No data available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
