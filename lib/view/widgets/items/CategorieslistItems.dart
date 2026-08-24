import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';

class CategorieslistItems extends GetView<ItemscontrollerImp> {
  const CategorieslistItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        controller: controller.categoryScrollController,
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Categories(
            selected: index,
            categoriesmodel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class Categories extends GetView<ItemscontrollerImp> {
  final CategoriesModel categoriesmodel;
  final int selected;
  const Categories({
    super.key,
    required this.categoriesmodel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemscontrollerImp>(builder: (controller) {
      final isSelected = controller.selected == selected;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.changeCategory(
                  selected, (categoriesmodel.categoryId!.toString()));
            },
            borderRadius: BorderRadius.circular(25),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [
                          Appcolor.rosePompadour,
                          Appcolor.deepPurple,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? Appcolor.rosePompadour.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: isSelected ? 8 : 4,
                    offset: Offset(0, isSelected ? 4 : 2),
                  ),
                ],
                border: isSelected
                    ? null
                    : Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: isSelected
                    ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                child: Text(
                  databaseTranslation(
                      categoriesmodel.categoryName!,
                      categoriesmodel.categoryNameAr!,
                      categoriesmodel.categoryNameEs!),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
