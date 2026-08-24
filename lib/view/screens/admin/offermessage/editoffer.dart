import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/offermessage/editoffercontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/CustomTextField.dart';
import 'package:oro/view/widgets/admin/ImagePreview.dart';
import 'package:oro/view/widgets/admin/ImageSelectionButtons.dart';
import 'package:oro/view/widgets/admin/SectionCard.dart';
import 'package:oro/view/widgets/home/discountcard.dart';

class EditOffer extends StatelessWidget {
  const EditOffer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditOfferControllerImp());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Edit Offer',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
        ),
        floatingActionButton: GetBuilder<EditOfferControllerImp>(
          builder: (controller) => FloatingActionButton.extended(
            onPressed: controller.statusRequest == StatusRequest.loding
                ? null
                : () => controller.editOfferMessage(),
            backgroundColor: controller.statusRequest == StatusRequest.loding
                ? Colors.grey[400]
                : Appcolor.berry,
            foregroundColor: Colors.white,
            icon: controller.statusRequest == StatusRequest.loding
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.check),
            label: Text(controller.statusRequest == StatusRequest.loding
                ? 'Saving...'
                : 'Guardar cambios'),
            tooltip: "Save Offer Changes",
          ),
        ),
        body: GetBuilder<EditOfferControllerImp>(
          builder: (controller) => Form(
            key: controller.formkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Section
                  SectionCard(
                    title: 'Offer Details',
                    children: [
                      CustomTextField(
                        controller: controller.title!,
                        label: 'Offer Title',
                        hint: 'Enter a compelling offer title',
                        icon: Icons.title,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please enter an offer title";
                          }
                          if (value!.length < 3) {
                            return "Title must be at least 3 characters";
                          }
                          return null;
                        },
                        onChanged: (value) => controller.update(),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.body!,
                        label: 'Offer Description',
                        hint: 'Describe your offer in detail',
                        icon: Icons.description,
                        maxLines: 4,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please enter offer description";
                          }
                          if (value!.length < 10) {
                            return "Description must be at least 10 characters";
                          }
                          return null;
                        },
                        onChanged: (value) => controller.update(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Image Section
                  SectionCard(
                    title: 'Offer Image',
                    children: [
                      ImagePreview(controller: controller),
                      const SizedBox(height: 16),
                      ImageSelectionButtons(controller: controller),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Preview Section
                  SectionCard(
                    title: 'Live Preview',
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Discountcard(
                            title: controller.title?.text.isEmpty ?? true
                                ? 'Your offer title will appear here'
                                : controller.title!.text,
                            content: controller.body?.text.isEmpty ?? true
                                ? 'Your offer description will appear here'
                                : controller.body!.text,
                            image: controller.getPreviewImage()),
                      ),
                    ],
                  ),

                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
