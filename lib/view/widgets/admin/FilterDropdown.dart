import 'package:flutter/material.dart';
import 'package:oro/controller/admin/items/viewitemscontroller.dart';
import 'package:oro/core/constant/color.dart';

class FilterDropdown extends StatelessWidget {
  final ViewItemsControllerImp controller;

  const FilterDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: controller.currentFilter,
      icon: const Icon(Icons.arrow_drop_down, size: 20, color: Appcolor.berry),
      underline: Container(),
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Items')),
        DropdownMenuItem(value: 'active', child: Text('Active')),
        DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
        DropdownMenuItem(value: 'discounted', child: Text('Discounted')),
        DropdownMenuItem(value: 'low_stock', child: Text('Low Stock')),
      ],
      onChanged: (value) {
        if (value != null) {
          controller.filterItems(value);
        }
      },
    );
  }
}
