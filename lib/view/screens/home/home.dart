import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_breakpoints.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/categorieslist.dart';
import 'package:oro/view/widgets/home/discountcard.dart';
import 'package:oro/view/widgets/home/greeting.dart';
import 'package:oro/view/widgets/home/hotdealsheader.dart';
import 'package:oro/view/widgets/home/itemcard.dart';
import 'package:oro/view/widgets/home/loadingitemstate.dart';
import 'package:oro/view/widgets/home/serch.dart';
import 'package:oro/view/widgets/common/oro_staggered_item.dart';

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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: SerchBar(
                      controller: controller.textEditingController,
                      onPressed: controller.goToSearch,
                      hint: 'search_products'.tr,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
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
                                Text(
                                  'categories'.tr,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'categories_subtitle'.tr,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                            color: Appcolor.accentGold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  const SliverToBoxAdapter(child: Categorieslist()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HotDealsHeader(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.crossAxisExtent;
                        final columns = OroBreakpoints.gridColumns(width);
                        final aspectRatio =
                            OroBreakpoints.productAspectRatio(width);
                        final isLoading =
                            controller.statusRequest == StatusRequest.loding;
                        final itemCount = isLoading
                            ? columns * 3
                            : (controller.itemsList.isNotEmpty
                                ? controller.itemsList.length
                                : controller.items.length);

                        return SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: aspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (isLoading) {
                                return const LoadingItemState();
                              }
                              final ItemsModel model =
                                  controller.itemsList.isNotEmpty
                                      ? controller.itemsList[index]
                                      : (controller.items[index] is ItemsModel
                                          ? controller.items[index]
                                          : ItemsModel.fromJson(
                                              controller.items[index]));
                              return OroStaggeredItem(
                                index: index,
                                delayBase: 35,
                                child: ItemCard(
                                  itemsModel: model,
                                  onTap: () => controller.goToItemDetails(model),
                                  colorIndex:
                                      index % controller.gradientColors.length,
                                ),
                              );
                            },
                            childCount: itemCount,
                          ),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 128)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
