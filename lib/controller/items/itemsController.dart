import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/cart/cartdata.dart';
import 'package:oro/data/datasource/remote/itmes/itemsdata.dart';
import 'package:oro/data/model/itemsmodel.dart';

abstract class ItemsController extends GetxController {
  getData(String catId);
  initiateData();
  changeCategory(int val, String catVal);
  goToItemDetails(ItemsModel itemModel);
  addToCart(String itemId);
  onPageChanged(int index);
  refreshCurrentCategory();
}

class ItemscontrollerImp extends ItemsController {
  List categories = [];
  int? selected;
  String? catId;
  Itemsdata itemsdata = Itemsdata(Get.find());
  Services services = Get.find();
  CartData cartData = CartData(Get.find());
  StatusRequest statusRequestAdd = StatusRequest.none;
  final Set<int> loadingItemIds = {};

  List data = [];
  late StatusRequest statusRequest;

  late PageController pageController;
  late ScrollController categoryScrollController;

  final Map<String, List> categoryDataCache = {};
  final Map<String, List<ItemsModel>> categoryItemsModelCache = {};
  final Map<String, StatusRequest> categoryStatusCache = {};

  @override
  void onInit() {
    super.onInit();
    categoryScrollController = ScrollController();
    initiateData();
  }

  @override
  void onClose() {
    pageController.dispose();
    categoryScrollController.dispose();
    super.onClose();
  }

  @override
  getData(catId) async {
    await _loadCategoryData(catId);
  }

  Future<void> _loadCategoryData(String catId) async {
    if (categoryDataCache.containsKey(catId)) {
      if (this.catId == catId) {
        data = List.from(categoryDataCache[catId]!);
        statusRequest = categoryStatusCache[catId] ?? StatusRequest.success;
        update();
      }
      return;
    }

    categoryStatusCache[catId] = StatusRequest.loding;

    if (this.catId == catId) {
      data.clear();
      statusRequest = StatusRequest.loding;
      update();
    }

    var response = await itemsdata.postData(
        catId, services.sharedPreferences.getString("id")!);
    var status = handlingdata(response);

    if (status == StatusRequest.success) {
      if (response["status"] == "success") {
        List categoryData = response['data'] ?? [];
        List<ItemsModel> models =
            categoryData.map((e) => ItemsModel.fromJson(e)).toList();

        categoryDataCache[catId] = List.from(categoryData);
        categoryItemsModelCache[catId] = models;
        categoryStatusCache[catId] = StatusRequest.success;

        if (Get.isRegistered<FavouritesControllerImp>()) {
          final fav = Get.find<FavouritesControllerImp>();
          for (final m in models) {
            if (m.itemId != null && m.favourite != null) {
              fav.favourites[m.itemId!] = m.favourite!;
            }
          }
        }

        if (this.catId == catId) {
          data = List.from(categoryData);
          statusRequest = StatusRequest.success;
        }
      } else if (response["status"] == "failure") {
        categoryStatusCache[catId] = StatusRequest.failure;
        categoryItemsModelCache[catId] = [];
        if (this.catId == catId) {
          statusRequest = StatusRequest.failure;
        }
      }
    } else {
      categoryStatusCache[catId] = status;
      if (this.catId == catId) {
        statusRequest = status;
      }
    }
    update();
  }

  @override
  initiateData() {
    if (Get.arguments != null) {
      categories = Get.arguments['categories'] ?? [];
      selected = Get.arguments['selected'];
      catId = Get.arguments['catId'];
    }

    pageController = PageController(initialPage: selected ?? 0);

    if (catId != null) {
      _loadCategoryData(catId!);
      Future.delayed(const Duration(milliseconds: 300), () {
        _preloadAdjacentCategories();
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedCategory();
    });
  }

  void _preloadAdjacentCategories() {
    if (selected != null && categories.isNotEmpty) {
      if (selected! > 0) {
        String prevCatId = categories[selected! - 1]['category_id'].toString();
        _loadCategoryData(prevCatId);
      }

      if (selected! < categories.length - 1) {
        String nextCatId = categories[selected! + 1]['category_id'].toString();
        _loadCategoryData(nextCatId);
      }
    }
  }

  @override
  changeCategory(val, catVal) {
    if (selected == val) return;

    selected = val;
    catId = catVal;

    pageController.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _scrollToSelectedCategory();

    _loadCategoryData(catId!);
    _preloadAdjacentCategories();
  }

  @override
  onPageChanged(int index) {
    if (selected == index) return;

    selected = index;
    if (index < categories.length) {
      catId = categories[index]['category_id'].toString();

      _scrollToSelectedCategory();

      _loadCategoryData(catId!);
      _preloadAdjacentCategories();
    }
  }

  List getCategoryData(String categoryId) {
    return categoryDataCache[categoryId] ?? [];
  }

  List<ItemsModel> getCategoryItemsModels(String categoryId) {
    return categoryItemsModelCache[categoryId] ?? [];
  }

  bool isCategoryLoading(String categoryId) {
    return categoryStatusCache[categoryId] == StatusRequest.loding;
  }

  Future<void> refreshCategory(String categoryId) async {
    categoryDataCache.remove(categoryId);
    categoryItemsModelCache.remove(categoryId);
    categoryStatusCache.remove(categoryId);
    await _loadCategoryData(categoryId);
  }

  void _scrollToSelectedCategory() {
    if (selected != null && categoryScrollController.hasClients) {
      double itemWidth = 120.0;
      double targetScroll =
          (selected! * itemWidth) - (Get.width / 2) + (itemWidth / 2);

      targetScroll = targetScroll.clamp(
          0.0, categoryScrollController.position.maxScrollExtent);

      categoryScrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  goToItemDetails(itemModel) {
    Get.toNamed(Approutes.itemDetails, arguments: {"itemsModel": itemModel});
  }

  @override
  addToCart(itemId) async {
    final id = int.parse(itemId);
    loadingItemIds.add(id);
    statusRequestAdd = StatusRequest.loding;
    update();

    try {
      dynamic response;
      response = await cartData.cartAdd(
          services.sharedPreferences.getString("id")!, itemId);
      statusRequestAdd = handlingdata(response);

      if (statusRequestAdd == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.snackbar(
            "Added To Cart",
            "This item has been successfully added to your cart!",
            colorText: Appcolor.charcoalGray,
            backgroundColor: Appcolor.rosePompadour,
            icon: const Icon(Icons.add_shopping_cart_rounded),
          );
        } else if (response["status"] == "failure") {
          statusRequestAdd = StatusRequest.failure;
        }
      }
    } catch (e) {
      statusRequestAdd = StatusRequest.failure;
      Get.snackbar(
        "Error",
        "An error occurred while adding the item to your cart.",
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.error),
      );
    } finally {
      loadingItemIds.remove(id);
      update();
    }
  }

  @override
  Future<void> refreshCurrentCategory() async {
    if (catId != null) {
      await refreshCategory(catId!);
    }
  }

  bool isLoadingItem(int itemId) {
    return loadingItemIds.contains(itemId);
  }
}
