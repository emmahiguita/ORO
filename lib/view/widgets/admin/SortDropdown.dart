import 'package:flutter/material.dart';
import 'package:oro/controller/admin/items/viewitemscontroller.dart';
import 'package:oro/core/constant/color.dart';

class SortDropdown extends StatelessWidget {
  final ViewItemsControllerImp controller;
  const SortDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: controller.currentSort,
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
        DropdownMenuItem(value: 'name_asc', child: Text('Name (A-Z)')),
        DropdownMenuItem(value: 'name_desc', child: Text('Name (Z-A)')),
        DropdownMenuItem(value: 'price_asc', child: Text('Price (Low-High)')),
        DropdownMenuItem(value: 'price_desc', child: Text('Price (High-Low)')),
        DropdownMenuItem(value: 'stock_asc', child: Text('Stock (Low-High)')),
        DropdownMenuItem(value: 'stock_desc', child: Text('Stock (High-Low)')),
        DropdownMenuItem(value: 'rating_asc', child: Text('Rating (Low-High)')),
        DropdownMenuItem(
            value: 'rating_desc', child: Text('Rating (High-Low)')),
      ],
      onChanged: (value) {
        if (value != null) {
          controller.sortItems(value);
        }
      },
    );
  }
}
