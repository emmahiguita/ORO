import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/view/widgets/home/categorieslist.dart';
import 'package:oro/view/widgets/home/discountcard.dart';
import 'package:oro/view/widgets/home/greeting.dart';
import 'package:oro/view/widgets/home/hotdealsheader.dart';
import 'package:oro/view/widgets/home/loadingitemstate.dart';
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
        body: Stack(
          children: [
            const _HomeAmbientGlow(),
            SafeArea(
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
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                          child: Greeting(
                            name: controller.username ?? '',
                            img: controller.pfp,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 22)),
                      SliverToBoxAdapter(
                        child: controller.statusRequest == StatusRequest.loding
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Shimmer.fromColors(
                                  baseColor: isDark
                                      ? const Color(0xFF202024)
                                      : const Color(0xFFE8E4DE),
                                  highlightColor: isDark
                                      ? const Color(0xFF303036)
                                      : const Color(0xFFF8F6F2),
                                  child: Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),
                                ),
                              )
                            : Discountcard(
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
                              ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 26)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Compra por categoría',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                    const SizedBox(height: 2),
                                    Text(
                                      'categories_subtitle'.tr,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.grid_view_rounded,
                                  size: 20, color: Appcolor.accentGold),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 14)),
                      const SliverToBoxAdapter(child: Categorieslist()),
                      const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      ..._productRails(controller),
                      const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '¿Buscas algo específico?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -.35,
                                ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverToBoxAdapter(
                        child: SerchBar(
                          controller: controller.textEditingController,
                          onPressed: controller.goToSearch,
                          hint: 'search_products'.tr,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 128)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAmbientGlow extends StatelessWidget {
  const _HomeAmbientGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 190,
            right: -200,
            child: _glow(const Color(0x242A8D58)),
          ),
          Positioned(
            bottom: 220,
            left: -220,
            child: _glow(OroColors.accentGold.withValues(alpha: .055)),
          ),
        ],
      ),
    );
  }

  Widget _glow(Color color) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: color, blurRadius: 82, spreadRadius: 34),
        ],
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
          child: HotDealsHeader(),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 14)),
      SliverToBoxAdapter(
        child: SizedBox(height: 216, child: LoadingItemState()),
      ),
    ];
  }

  final categories = controller.categories
      .map((raw) => CategoriesModel.fromJson(Map<String, dynamic>.from(raw)))
      .toList();
  final products = controller.itemsList.isNotEmpty
      ? controller.itemsList
      : controller.items
          .map((raw) => raw is ItemsModel
              ? raw
              : ItemsModel.fromJson(Map<String, dynamic>.from(raw)))
          .toList();
  final rails = <Widget>[];

  for (var index = 0; index < categories.length && rails.length < 3; index++) {
    final category = categories[index];
    final categoryProducts = products
        .where((product) =>
            product.itemCat == category.categoryId ||
            product.categoryId == category.categoryId)
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
            category.categoryId.toString(),
          ),
          onProductTap: controller.goToItemDetails,
        ),
      ),
    );
    rails.add(const SliverToBoxAdapter(child: SizedBox(height: 28)));
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
