import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:oro/controller/search/searchcontroller.dart';
import 'package:oro/core/class/handlingdataview.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/common/oro_staggered_item.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<SearchControllerImp>(
      init: SearchControllerImp(),
      builder: (searchControllerImp) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: TypeAheadField<String>(
            decorationBuilder: (context, child) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: child,
              );
            },
            builder: (context, controller, focusNode) {
              searchControllerImp.textEditingController = controller;
              return Container(
                height: 46,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.07)
                      : const Color.fromARGB(245, 245, 245, 245),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Buscar en ORO...",
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Appcolor.deepPurple,
                      size: 22,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        controller.clear();
                        searchControllerImp.results.clear();
                        searchControllerImp.update();
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      searchControllerImp.search(value.trim());
                    }
                  },
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              if (pattern.isEmpty) return [];
              return SearchControllerImp.getSuggestions(
                pattern,
                searchControllerImp.suggestions,
              ).take(5).toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                leading: const Icon(
                  Icons.search_rounded,
                  color: Appcolor.deepPurple,
                  size: 20,
                ),
                title: Text(
                  suggestion,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
            onSelected: (String suggestion) {
              searchControllerImp.search(suggestion);
            },
          ),
        ),
        body: HandlingDataView(
          statusRequest: searchControllerImp.statusRequest,
          widget: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                  child: Text(
                    '${searchControllerImp.results.length} productos encontrados',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                sliver: SliverList.separated(
                  itemCount: searchControllerImp.results.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = searchControllerImp.results[index];
                    final price = item.itemFinalPrice ?? item.itemPrice ?? 0.0;
                    final name = databaseTranslation(
                      item.itemName,
                      item.itemNameAr,
                      item.itemNameEs,
                    );

                    return OroStaggeredItem(
                      index: index,
                      delayBase: 40,
                      child: OroPressable(
                        onTap: () {
                          searchControllerImp.goToItemDetails(item);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: isDark ? 0.12 : 0.06),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                    alpha: isDark ? 0.2 : 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                margin: const EdgeInsets.only(right: 14),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Appcolor.mimiPink
                                          .withValues(alpha: 0.35),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Hero(
                                    tag:
                                        'product-${item.itemId ?? item.hashCode}',
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: OroProductImage(
                                        imageUrl: item.itemImg,
                                        productName: name,
                                        categoryName: item.categoryName,
                                        fit: BoxFit.contain,
                                        memCacheWidth: 320,
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        height: 1.25,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    if (item.categoryName != null &&
                                        item.categoryName!.isNotEmpty)
                                      Text(
                                        item.categoryName ?? '',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '\$${price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Appcolor.deepPurple,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
