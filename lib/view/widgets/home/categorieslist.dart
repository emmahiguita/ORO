import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
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
          height: 108,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.statusRequest == StatusRequest.loding
                ? 6
                : controller.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
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
      width: 78,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          controller.goToItem(
            controller.categories,
            selected,
            categoriesmodel.categoryId.toString(),
          );
        },
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              height: 66,
              width: 66,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: .07),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .045),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: OroCategoryIcon(
                categoryImg: categoriesmodel.categoryImg,
                categoryName: databaseTranslation(
                  categoriesmodel.categoryName,
                  categoriesmodel.categoryNameAr,
                  categoriesmodel.categoryNameEs,
                ),
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              databaseTranslation(
                categoriesmodel.categoryName,
                categoriesmodel.categoryNameAr,
                categoriesmodel.categoryNameEs,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .72),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
