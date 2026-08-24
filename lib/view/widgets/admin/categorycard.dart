import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/constant/color.dart';

import '../../../controller/admin/category/admincategorycontroller.dart';

class CategoryCard extends StatelessWidget {
  final AdminCategoryControllerImp controller;
  final int index;
  const CategoryCard(
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Appcolor.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SvgPicture.network(
            AppLink.categoriesimage +
                (controller.categories[index].categoryImg ?? ""),
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            placeholderBuilder: (context) => const SizedBox(
              height: 50,
              width: 50,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.categories[index].categoryName ?? "Unnamed",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              controller.categories[index].categoryNameAr ?? "-",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              controller.categories[index].categoryNameEs ?? "-",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              tooltip: 'Editar categoría',
              icon: const Icon(Icons.edit, color: Appcolor.deepPink),
              onPressed: () {
                controller.goToEditCategory(controller.categories[index]);
              },
            ),
            IconButton(
              tooltip: 'Delete Category',
              icon: const Icon(Icons.delete, color: Appcolor.berry),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor: Appcolor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.orange[700], size: 28),
                        const SizedBox(width: 12),
                        Text(
                          "Delete Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Are you sure you want to delete this category?",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This action cannot be undone.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12)),
                        onPressed: () {
                          controller.deleteCategory(
                            controller.categories[index].categoryId.toString(),
                            controller.categories[index].categoryImg.toString(),
                          );
                          Get.back();
                          Get.snackbar(
                            "Delete Category",
                            "Category deleted successfully",
                            colorText: Appcolor.charcoalGray,
                            backgroundColor: Appcolor.rosePompadour,
                            icon: const Icon(Icons.check),
                          );
                        },
                        child: const Text(
                          "DELETE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  ),
                  barrierDismissible: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
