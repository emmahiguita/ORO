import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final dynamic controller;
  const CategoryField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.showCatgoryList(context),
      child: IgnorePointer(
        child: TextFormField(
          controller: controller.itemCategory,
          decoration: const InputDecoration(
            labelText: "Item Category",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.arrow_drop_down),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (val) => val!.isEmpty ? "Please select a category" : null,
        ),
      ),
    );
  }
}
