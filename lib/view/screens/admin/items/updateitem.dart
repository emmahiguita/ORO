import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/items/updateitemcontroller.dart';
import 'package:oro/view/widgets/admin/addheader.dart';
import 'package:oro/view/widgets/admin/categoryfield.dart';
import 'package:oro/view/widgets/admin/imagepicker.dart';
import 'package:oro/view/widgets/admin/itemfield.dart';

class UpdateItem extends StatelessWidget {
  const UpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateItemControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Item'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<UpdateItemControllerImp>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formstate,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AddHeader(title: 'Basic Information'),
                  ItemFiled(
                    controller: controller.itemName!,
                    label: "Item Name (English)",
                    validator: (val) =>
                        val!.isEmpty ? "Please enter item name" : null,
                  ),
                  ItemFiled(
                    controller: controller.itemNameAr!,
                    label: "Item Name (Arabic)",
                    validator: (val) => val!.isEmpty
                        ? "Please enter item name in arabic"
                        : null,
                  ),
                  ItemFiled(
                    controller: controller.itemNameEs!,
                    label: "Item Name (Spanish)",
                    validator: (val) => val!.isEmpty
                        ? "Please enter item name in spanish"
                        : null,
                  ),
                  const AddHeader(title: 'Descriptions'),
                  ItemFiled(
                    controller: controller.itemDescription!,
                    label: "Description (English)",
                    maxLines: 3,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter item description" : null,
                  ),
                  ItemFiled(
                    controller: controller.itemDescriptionAr!,
                    label: "Description (Arabic)",
                    maxLines: 3,
                    validator: (val) => val!.isEmpty
                        ? "Please enter item description in arabic"
                        : null,
                  ),
                  ItemFiled(
                    controller: controller.itemDescriptionEs!,
                    label: "Description (Spanish)",
                    maxLines: 3,
                    validator: (val) => val!.isEmpty
                        ? "Please enter item description in spanish"
                        : null,
                  ),
                  const AddHeader(title: 'Pricing & Inventory'),
                  Row(
                    children: [
                      Expanded(
                        child: ItemFiled(
                          controller: controller.itemPrice!,
                          label: "Precio",
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (val) =>
                              val!.isEmpty ? "Please enter item price" : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ItemFiled(
                          controller: controller.itemDiscount!,
                          label: "Discount (%)",
                          keyboardType: TextInputType.number,
                          validator: (val) => val!.isEmpty
                              ? "Please enter item discount"
                              : null,
                        ),
                      ),
                    ],
                  ),
                  ItemFiled(
                    controller: controller.itemQuantity!,
                    label: "Cantidad",
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter item quantity" : null,
                  ),
                  const AddHeader(title: 'Additional Information'),
                  CategoryField(controller: controller),
                  const SizedBox(height: 10),
                  Card(
                    child: InkWell(
                      onTap: () => controller.changeActive(),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Text("Active Item",
                                style: Theme.of(context).textTheme.bodyLarge),
                            const Spacer(),
                            Switch(
                              value: controller.active == "1",
                              onChanged: (value) => controller.changeActive(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const AddHeader(title: 'Item Image'),
                  ImagePicker(
                    controller: controller,
                    isUpdate: controller.image == null,
                    imageUrl:
                        AppLink.itemimage + controller.itemsModel!.itemImg!,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => controller.updateItem(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Update Item",
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
