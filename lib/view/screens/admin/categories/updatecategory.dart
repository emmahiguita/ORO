import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/category/updatecategorycontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/categorynamefield.dart';
import 'package:oro/view/widgets/admin/header.dart';
import 'package:oro/view/widgets/admin/savebutton.dart';
import 'package:oro/view/widgets/admin/selectimage.dart';

class UpdateCategory extends StatelessWidget {
  const UpdateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateCategoryControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Category'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Appcolor.white,
      ),
      backgroundColor: Appcolor.white,
      body: GetBuilder<UpdateCategoryControllerImp>(
        builder: (controller) => Form(
          key: controller.formstate,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Header(
                  title: 'Update Category',
                  subtitle:
                      'Update the details below to modify the product category',
                ),
                const SizedBox(height: 30),
                CategoryNameField(
                  controller: controller.categoryName!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter category name";
                    }
                    return null;
                  },
                  labelText: 'Category Name (English)',
                  prefixIcon: const Icon(Icons.category),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 20),
                CategoryNameField(
                  controller: controller.categoryNameAr!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter category name in Arabic";
                    }
                    return null;
                  },
                  labelText: 'Category Name (Arabic)',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'images/ar.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 20),
                CategoryNameField(
                  controller: controller.categoryNameEs!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter category name in Spanish";
                    }
                    return null;
                  },
                  labelText: 'Category Name (Spanish)',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'images/es.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 30),
                SelectImage(
                  controller: controller,
                  isEdit: true,
                ),
                const SizedBox(height: 30),
                SaveButton(
                    statusRequest: controller.statusRequest,
                    onPressed: () {
                      controller.updateCategory();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
