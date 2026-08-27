import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/view/widgets/common/oro_category_icon.dart';
import 'package:oro/view/widgets/home/loadingstate.dart';

class Categorieslist extends StatelessWidget {
  const Categorieslist({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.statusRequest == StatusRequest.loding
                ? 6
                : controller.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return controller.statusRequest == StatusRequest.loding
                  ? const LoadingState()
                  : Categories(
                      selected: index,
                      categoriesmodel: CategoriesModel.fromJson(
                        controller.categories[index],
                      ),
                    );
            },
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class Categories extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesmodel;
  final int selected;

  const Categories({
    super.key,
    required this.categoriesmodel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 104,
      child: OroPressable(
        onTap: () {
          controller.goToItem(
            controller.categories,
            selected,
            categoriesmodel.categoryId.toString(),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            child: Ink(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: .74),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: .38),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Row(
                  children: [
                    Container(
                      height: 26,
                      width: 26,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .12),
                        shape: BoxShape.circle,
                      ),
                      child: OroCategoryIcon(
                        categoryImg: categoriesmodel.categoryImg,
                        categoryName: databaseTranslation(
                          categoriesmodel.categoryName,
                          categoriesmodel.categoryNameAr,
                          categoriesmodel.categoryNameEs,
                        ),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        databaseTranslation(
                          categoriesmodel.categoryName,
                          categoriesmodel.categoryNameAr,
                          categoriesmodel.categoryNameEs,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
