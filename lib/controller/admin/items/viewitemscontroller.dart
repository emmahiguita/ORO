import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/screens/admin/items/additem.dart';
import 'package:oro/view/screens/admin/items/updateitem.dart';

abstract class ViewItemsController extends GetxController {
  getItems();
  goToAddItem();
  deleteItem(String id, String imgname);
  goToEditItem(ItemsModel itemsModel);
  void sortItems(String sortBy);
  void filterItems(String filterBy);
  void searchItems(String query);
}

class ViewItemsControllerImp extends ViewItemsController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<ItemsModel> items = [];
  List<ItemsModel> filteredItems = [];
  String currentSort = 'name_asc';
  String currentFilter = 'all';
  String searchQuery = '';

  @override
  getItems() async {
    statusRequest = StatusRequest.loding;
    items.clear();
    var response = await adminData.getItems();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        items.addAll(data.map((e) => ItemsModel.fromJson(e)));
        _applyAllFilters();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getItems();
    super.onInit();
  }

  @override
  goToAddItem() {
    Get.to(() => const AddItem());
  }

  @override
  deleteItem(String id, String imgname) async {
    await adminData.deleteItem(id, imgname);
    items.removeWhere((element) => element.itemId == int.parse(id));
    _applyAllFilters();
    update();
  }

  @override
  void sortItems(String sortBy) {
    currentSort = sortBy;
    _applySorting();
    update();
  }

  void _applySorting() {
    switch (currentSort) {
      case 'name_asc':
        filteredItems
            .sort((a, b) => (a.itemName ?? '').compareTo(b.itemName ?? ''));
        break;
      case 'name_desc':
        filteredItems
            .sort((a, b) => (b.itemName ?? '').compareTo(a.itemName ?? ''));
        break;
      case 'price_asc':
        filteredItems.sort(
            (a, b) => (a.itemFinalPrice ?? 0).compareTo(b.itemFinalPrice ?? 0));
        break;
      case 'price_desc':
        filteredItems.sort(
            (a, b) => (b.itemFinalPrice ?? 0).compareTo(a.itemFinalPrice ?? 0));
        break;
      case 'stock_asc':
        filteredItems
            .sort((a, b) => (a.itemCount ?? 0).compareTo(b.itemCount ?? 0));
        break;
      case 'stock_desc':
        filteredItems
            .sort((a, b) => (b.itemCount ?? 0).compareTo(a.itemCount ?? 0));
        break;
      case 'rating_asc':
        filteredItems.sort((a, b) => (double.tryParse(a.itemAvgRating!) ?? 0.0)
            .compareTo(double.tryParse(b.itemAvgRating!) ?? 0.0));
        break;
      case 'rating_desc':
        filteredItems.sort((a, b) => (double.tryParse(b.itemAvgRating!) ?? 0.0)
            .compareTo(double.tryParse(a.itemAvgRating!) ?? 0.0));
        break;
      default:
        filteredItems
            .sort((a, b) => (a.itemName ?? '').compareTo(b.itemName ?? ''));
    }
  }

  @override
  void filterItems(String filterBy) {
    currentFilter = filterBy;
    _applyAllFilters();
    update();
  }

  void _applyFilters() {
    if (currentFilter == 'all') {
      filteredItems = List.from(items);
    } else if (currentFilter == 'active') {
      filteredItems = items.where((item) => item.itemActive == 1).toList();
    } else if (currentFilter == 'inactive') {
      filteredItems = items.where((item) => item.itemActive == 0).toList();
    } else if (currentFilter == 'discounted') {
      filteredItems =
          items.where((item) => (item.itemDiscount ?? 0) > 0).toList();
    } else if (currentFilter == 'low_stock') {
      filteredItems =
          items.where((item) => (item.itemCount ?? 0) < 10).toList();
    }
  }

  @override
  void searchItems(String query) {
    searchQuery = query.toLowerCase();
    _applyAllFilters();
    update();
  }

  void _applySearch() {
    if (searchQuery.isEmpty) return;

    filteredItems = filteredItems.where((item) {
      return (item.itemName?.toLowerCase().contains(searchQuery) ?? false) ||
          (item.categoryName?.toLowerCase().contains(searchQuery) ?? false) ||
          (item.itemDesc?.toLowerCase().contains(searchQuery) ?? false) ||
          (item.itemDescAr?.toLowerCase().contains(searchQuery) ?? false) ||
          (item.itemDescEs?.toLowerCase().contains(searchQuery) ?? false);
    }).toList();
  }

  void _applyAllFilters() {
    _applyFilters();
    _applySearch();
    _applySorting();
  }

  void showDeleteDialog(String productName, VoidCallback onConfirm) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.warning_rounded, size: 32, color: Colors.orange),
        title: const Text(
          '¿Eliminar producto?',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are about to delete "$productName". This action cannot be undone.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Are you sure you want to continue?',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar', style: TextStyle(fontSize: 14)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  goToEditItem(ItemsModel itemsModel) {
    Get.to(() => const UpdateItem(), arguments: {
      "itemsModel": itemsModel,
    });
  }
}
