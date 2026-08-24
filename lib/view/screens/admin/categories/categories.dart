import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/category/admincategorycontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/screens/admin/categories/addcategory.dart';
import 'package:oro/view/widgets/admin/categorycard.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminCategoryControllerImp());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AdminCategoryControllerImp>(
          builder: (controller) {
            if (controller.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CategoryCard(controller: controller, index: index);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Agregar nueva categoría",
          onPressed: () {
            Get.to(() => const AddCategory());
          },
          backgroundColor: Appcolor.pink,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
