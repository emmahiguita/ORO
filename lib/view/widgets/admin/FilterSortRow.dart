import 'package:flutter/material.dart';
import 'package:oro/controller/admin/items/viewitemscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/AdminFilterChip.dart';
import 'package:oro/view/widgets/admin/FilterDropdown.dart';
import 'package:oro/view/widgets/admin/SortDropdown.dart';

class FilterSortRow extends StatelessWidget {
  final ViewItemsControllerImp controller;

  const FilterSortRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Filter Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt_outlined,
                      size: 18, color: Appcolor.berry),
                  const SizedBox(width: 4),
                  FilterDropdown(controller: controller),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Sort Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.sort, size: 18, color: Appcolor.berry),
                  const SizedBox(width: 4),
                  SortDropdown(controller: controller),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Active Status Chip
            AdminFilterChip(
              label: 'Active',
              icon: Icons.check_circle_outline,
              selected: controller.currentFilter == 'active',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'active' : 'all'),
            ),
            const SizedBox(width: 8),
            // Discounted Chip
            AdminFilterChip(
              label: 'Discounted',
              icon: Icons.local_offer_outlined,
              selected: controller.currentFilter == 'discounted',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'discounted' : 'all'),
            ),
            const SizedBox(width: 8),
            // Low Stock Chip
            AdminFilterChip(
              label: 'Low Stock',
              icon: Icons.warning_amber_rounded,
              selected: controller.currentFilter == 'low_stock',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'low_stock' : 'all'),
            ),
          ],
        ),
      ),
    );
  }
}
