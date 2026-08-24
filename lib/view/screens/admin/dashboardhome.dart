import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/view/widgets/admin/admingraph.dart';
import 'package:oro/view/widgets/admin/recentorders.dart';
import 'package:oro/view/widgets/admin/statsrow.dart';
import 'package:oro/view/widgets/admin/topproducts.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDashboardControllerImp());
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminGraph(),
          Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          StatsRow(),
          Text(
            'Recent Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          RecentOrders(),
          SizedBox(height: 24),
          Text(
            'Top Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TopProducts(),
        ],
      ),
    );
  }
}
