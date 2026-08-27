import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';

class CategorieslistItems extends GetView<ItemscontrollerImp> {
  const CategorieslistItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 6),
      child: ListView.separated(
        controller: controller.categoryScrollController,
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Categories(
            selected: index,
            categoriesmodel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<ItemscontrollerImp>(builder: (controller) {
      final isSelected = controller.selected == selected;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.changeCategory(
                  selected, (categoriesmodel.categoryId?.toString() ?? ''));
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [
                          Color(0xFFD4AF37),
                          Color(0xFFA87928),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark
                        ? const Color(0xFF1E1E24)
                        : const Color(0xFFF3F1EC)),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color:
                              const Color(0xFFD4AF37).withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: isDark ? 0.2 : 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFFDF73)
                      : (isDark
                          ? const Color(0xFF2E2E38)
                          : const Color(0xFFE2DED6)),
                  width: isSelected ? 1.2 : 1.0,
                ),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  color: isSelected
                      ? Colors.black
                      : (isDark
                          ? const Color(0xFFE0DFE6)
                          : const Color(0xFF4A4852)),
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                child: Text(
                  databaseTranslation(
                      categoriesmodel.categoryName,
                      categoriesmodel.categoryNameAr,
                      categoriesmodel.categoryNameEs),
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
