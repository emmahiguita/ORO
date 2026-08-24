import 'dart:io';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/items/viewitemscontroller.dart';
import 'package:oro/core/class/selectmodel.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/addimage.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/data/model/itemsmodel.dart';

abstract class UpdateItemController extends GetxController {
  getCategories();
  updateItem();
  changeActive();
  showCatgoryList(BuildContext context);
}

class UpdateItemControllerImp extends UpdateItemController {
  ItemsModel? itemsModel;

  TextEditingController? itemName;
  TextEditingController? itemNameAr;
  TextEditingController? itemNameEs;
  TextEditingController? itemDescription;
  TextEditingController? itemDescriptionAr;
  TextEditingController? itemDescriptionEs;
  TextEditingController? itemPrice;
  TextEditingController? itemDiscount;
  TextEditingController? itemQuantity;

  TextEditingController? itemCategory;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<SelectedListItem<SelectModel>> catgoryList = [];

  String? catId;

  File? image;

  getImageByGallery() async {
    image = await uploadImage();
    update();
  }

  getImageByCamera() async {
    image = await pickImageFromCamera();
    update();
  }

  String? active;

  late StatusRequest categoriesStatusRequest;
  AdminData adminData = AdminData(Get.find());
  List<CategoriesModel> categories = [];

  late StatusRequest statusRequest;

  @override
  void onInit() {
    itemsModel = Get.arguments['itemsModel'];

    getCategories();

    itemName = TextEditingController();
    itemNameAr = TextEditingController();
    itemNameEs = TextEditingController();
    itemDescription = TextEditingController();
    itemDescriptionAr = TextEditingController();
    itemDescriptionEs = TextEditingController();
    itemPrice = TextEditingController();
    itemDiscount = TextEditingController();
    itemQuantity = TextEditingController();
    itemCategory = TextEditingController();

    itemName!.text = itemsModel!.itemName!;
    itemNameAr!.text = itemsModel!.itemNameAr!;
    itemNameEs!.text = itemsModel!.itemNameEs!;
    itemDescription!.text = itemsModel!.itemDesc!;
    itemDescriptionAr!.text = itemsModel!.itemDescAr!;
    itemDescriptionEs!.text = itemsModel!.itemDescEs!;
    itemPrice!.text = itemsModel!.itemPrice.toString();
    itemDiscount!.text = itemsModel!.itemDiscount.toString();
    itemQuantity!.text = itemsModel!.itemCount.toString();

    active = itemsModel!.itemActive.toString();
    catId = itemsModel!.itemCat.toString();

    super.onInit();
  }

  @override
  getCategories() async {
    categoriesStatusRequest = StatusRequest.loding;
    categories.clear();
    var response = await adminData.getCategories();
    categoriesStatusRequest = handlingdata(response);
    if (categoriesStatusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        categories.addAll(data.map((e) => CategoriesModel.fromJson(e)));
        for (var element in categories) {
          catgoryList.add(SelectedListItem(
            data: SelectModel(
                name: element.categoryName!,
                code: element.categoryId.toString()),
            // name: element.
          ));
        }
        itemCategory!.text = categories
            .firstWhere((element) => element.categoryId == itemsModel!.itemCat!)
            .categoryName!;
      } else if (response["status"] == "failure") {
        categoriesStatusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  changeActive() {
    active = active == "1" ? "0" : "1";
    update();
  }

  @override
  showCatgoryList(BuildContext context) {
    DropDownState<SelectModel>(
      dropDown: DropDown<SelectModel>(
        isDismissible: true,
        bottomSheetTitle: const Text(
          "Seleccionar categoría",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        data: catgoryList,
        listItemBuilder: (index, dataItem) {
          return Text(
            '${dataItem.data.name} : ${dataItem.data.code}',
          );
        },
        onSelected: (selectedItems) {
          itemCategory!.text = selectedItems[0].data.name;
          catId = selectedItems[0].data.code;
          update();
        },
        searchDelegate: (query, dataItems) {
          return dataItems
              .where((item) =>
                  item.data.name.toLowerCase().contains(query.toLowerCase()) ||
                  item.data.code.toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
      ),
    ).showModal(context);
  }

  @override
  updateItem() async {
    if (!formstate.currentState!.validate()) {
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    var response = await adminData.updateItem(
      itemsModel!.itemId.toString(),
      itemName!.text,
      itemNameAr!.text,
      itemNameEs!.text,
      itemDescription!.text,
      itemDescriptionAr!.text,
      itemDescriptionEs!.text,
      itemQuantity!.text,
      active!,
      itemPrice!.text,
      itemDiscount!.text,
      catId!,
      image,
      itemsModel!.itemImg!,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.find<ViewItemsControllerImp>().getItems();
        Get.back();
        Get.snackbar(
          "Éxito",
          "Producto actualizado con éxito",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
