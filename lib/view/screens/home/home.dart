import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/categorieslist.dart';
import 'package:oro/view/widgets/home/discountcard.dart';
import 'package:oro/view/widgets/home/greeting.dart';
import 'package:oro/view/widgets/home/product_section_rail.dart';
import 'package:oro/view/widgets/home/serch.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: GetBuilder<HomeControllerImp>(
            builder: (controller) {
              final promo = controller.mainPage.isNotEmpty
                  ? controller.mainPage.first
                  : null;
              final promoImage = promo?['mainpage_image']?.toString() ?? '';

              return CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                      child: Greeting(
                        name: controller.username ?? '',
                        img: controller.pfp,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 22),
                  ),
                  SliverToBoxAdapter(
                    child: SerchBar(
                      controller: controller.textEditingController,
                      onPressed: controller.goToSearch,
                      hint: 'search_products'.tr,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverToBoxAdapter(
                    child: Discountcard(
                      title: databaseTranslation(
                        promo?['mainpage_title'],
                        promo?['mainpage_title_ar'],
                        promo?['mainpage_title_es'],
                      ),
                      content: databaseTranslation(
                        promo?['mainpage_body'],
                        promo?['mainpage_body_ar'],
                        promo?['mainpage_body_es'],
                      ),
                      image: promoImage.isEmpty
                          ? null
                          : CachedNetworkImageProvider(
                              '${AppLink.homeimage}$promoImage',
                            ),
                      onTap: controller.goToSearch,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 30),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Explora por categoría',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 14),
                  ),
                  const SliverToBoxAdapter(
                    child: Categorieslist(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 26),
                  ),
                  ..._productRails(controller),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 120),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

List<Widget> _productRails(HomeControllerImp controller) {
  if (controller.statusRequest == StatusRequest.loding) {
    return const [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    ];
  }

  final categories = controller.categories
      .map(
        (raw) => CategoriesModel.fromJson(
          Map<String, dynamic>.from(raw),
        ),
      )
      .toList();

  final products = controller.itemsList.isNotEmpty
      ? controller.itemsList
      : controller.items
          .map(
            (raw) => raw is ItemsModel
                ? raw
                : ItemsModel.fromJson(
                    Map<String, dynamic>.from(raw),
                  ),
          )
          .toList();

  final rails = <Widget>[];

  for (var index = 0; index < categories.length && rails.length < 6; index++) {
    final category = categories[index];
    final categoryProducts = products
        .where(
          (product) =>
              product.itemCat == category.categoryId ||
              product.categoryId == category.categoryId,
        )
        .take(8)
        .toList();

    if (categoryProducts.isEmpty) continue;

    rails.add(
      SliverToBoxAdapter(
        child: ProductSectionRail(
          category: category,
          products: categoryProducts,
          onShowAll: () => controller.goToItem(
            controller.categories,
            index,
            category.categoryId?.toString() ?? '',
          ),
          onProductTap: controller.goToItemDetails,
        ),
      ),
    );

    rails.add(
      const SliverToBoxAdapter(
        child: SizedBox(height: 30),
      ),
    );
  }

  if (rails.isEmpty && products.isNotEmpty) {
    rails.add(
      SliverToBoxAdapter(
        child: ProductSectionRail(
          category: CategoriesModel(categoryName: 'Selección ORO'),
          products: products.take(8).toList(),
          onShowAll: controller.goToSearch,
          onProductTap: controller.goToItemDetails,
        ),
      ),
    );
  }

  return rails;
}
