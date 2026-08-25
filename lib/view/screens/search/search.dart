import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/search/searchcontroller.dart';
import 'package:oro/core/class/handlingdataview.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerImp>(
      init: SearchControllerImp(),
      builder: (searchControllerImp) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TypeAheadField<String>(
            decorationBuilder: (context, child) {
              return Container(
                height: 200,
                padding: const EdgeInsets.only(bottom: 8, top: 4),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 241, 245),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: child,
              );
            },
            builder: (context, controller, focusNode) {
              searchControllerImp.textEditingController = controller;
              searchControllerImp.textEditingController!.text =
                  searchControllerImp.input;
              return TextField(
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: "Buscar",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (value) {
                  searchControllerImp.search(value);
                },
              );
            },
            itemBuilder: (context, String value) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.search,
                            color: Colors.blueAccent, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onSelected: (value) {
              searchControllerImp.textEditingController?.text = value;
              searchControllerImp.search(value);
            },
            suggestionsCallback: (search) {
              return SearchControllerImp.getSuggestions(
                  search, searchControllerImp.suggestions);
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(
                    '${searchControllerImp.results.length} productos encontrados',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                itemCount: searchControllerImp.results.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final item = searchControllerImp.results[index];
                  final price = item.itemFinalPrice ?? item.itemPrice ?? 0.0;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        searchControllerImp.goToItemDetails(item);
                      },
                      splashColor: Appcolor.amaranthpink.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Appcolor.black,
                                  fontFamily: 'Sw',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              margin: const EdgeInsets.only(right: 14),
                              decoration: BoxDecoration(
                                color: Appcolor.mimiPink.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Hero(
                                  tag:
                                      'product-${item.itemId ?? item.hashCode}',
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        AppLink.itemimage + (item.itemImg ?? ''),
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) =>
                                        const Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: GradientProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.shopping_bag_outlined,
                                            size: 28,
                                            color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemName ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.categoryName ?? '',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '\$${price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontFamily: "Sw",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Appcolor.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
