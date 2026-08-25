import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/functions/imagegeneration.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/couponmodel.dart';
import 'package:oro/view/screens/admin/coupon/editcoupon.dart';

abstract class AdminCouponController extends GetxController {
  getCoupons();
  goToEditCoupon(CouponModel couponModel);
  bool isExpired(String? expiryDate);
  String formatDate(String? date);
  announceCoupon(String title, String body, File file);
  String formatDisplayDate(String? date);
  announceCouponDialog(controller, int index);
  Future<void> handleAnnouncement(controller, int index);
  void setLoading(bool value);
  void clearForm();
  void showColorPicker(Color pickerColor, void Function(Color) onColorChanged);
}

class AdminCouponControllerImp extends AdminCouponController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<CouponModel> coupons = [];
  TextEditingController? title;
  TextEditingController? body;
  GlobalKey<FormState> formKey = GlobalKey();
  Rx<Color> backgroundColor = const Color(0xffEA9AB2).obs;

  @override
  getCoupons() async {
    statusRequest = StatusRequest.loding;
    coupons.clear();
    var response = await adminData.getCoupons();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        coupons.addAll(data.map((e) => CouponModel.fromJson(e)));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getCoupons();

    title = TextEditingController();
    body = TextEditingController();
    super.onInit();
  }

  @override
  goToEditCoupon(couponModel) {
    Get.to(
      () => const EditCoupon(),
      arguments: {"couponModel": couponModel},
    );
  }

  @override
  bool isExpired(String? expiryDate) {
    if (expiryDate == null) return false;
    try {
      final expiry = DateTime.parse(expiryDate);
      return expiry.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  @override
  String formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  @override
  announceCoupon(title, body, file) async {
    statusRequest = StatusRequest.loding;
    var response = await adminData.announceCoupon(title, body, file);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  String formatDisplayDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final dateTime = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
    } catch (e) {
      return date;
    }
  }

  RxBool isLoading = false.obs;

  @override
  void setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void clearForm() {
    title?.clear();
    body?.clear();
    backgroundColor.value = Appcolor.amaranthpink;
  }

  @override
  void showColorPicker(Color pickerColor, void Function(Color) onColorChanged) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Background Color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.amaranthpink,
                ),
              ),
              const SizedBox(height: 20),
              ColorPicker(
                enableAlpha: false,
                pickerColor: pickerColor,
                onColorChanged: (Color newColor) {
                  backgroundColor.value = newColor;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.amaranthpink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Done",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> handleAnnouncement(controller, int index) async {
    if (!controller.formKey.currentState!.validate()) return;

    controller.setLoading(true);

    try {
      final File? couponImage = await CouponImageGenerator.generateCouponImage(
        coupons[index],
        backgroundColor.value,
      );

      if (couponImage != null) {
        await controller.announceCoupon(
          controller.title!.text.trim(),
          controller.body!.text.trim(),
          couponImage,
        );

        Get.back();

        clearForm();

        Get.snackbar(
          "¡Éxito!",
          "Anuncio de cupón enviado con éxito",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception("Failed to generate coupon image");
      }
    } catch (e) {
      Get.snackbar(
        "Fallo en el anuncio",
        "Could not send announcement: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error, color: Colors.white),
        duration: const Duration(seconds: 4),
      );
    } finally {
      controller.setLoading(false);
    }
  }

  @override
  announceCouponDialog(controller, int index) {
    Get.defaultDialog(
      title: "Create Coupon Announcement",
      titleStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Appcolor.amaranthpink,
        letterSpacing: 0.5,
      ),
      contentPadding: const EdgeInsets.all(24),
      radius: 20,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: Get.width * 0.85,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Appcolor.amaranthpink.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Appcolor.amaranthpink.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Appcolor.amaranthpink,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Create a notification to announce your coupon to all users",
                          style: TextStyle(
                            color: Appcolor.amaranthpink,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                buildFormField(
                  controller: title!,
                  label: "Notification Title",
                  hint: "e.g., Flash Sale - 50% Off!",
                  icon: Icons.title_rounded,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title is required";
                    }
                    if (value.length > 50) {
                      return "Title must be less than 50 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildFormField(
                  controller: body!,
                  label: "Notification Message",
                  hint: "Describe your amazing offer in detail...",
                  icon: Icons.message_rounded,
                  maxLength: 200,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Message is required";
                    }
                    if (value.length > 200) {
                      return "Message must be less than 200 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                colorPickerField(),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          clearForm();
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Colors.grey[400]!, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          foregroundColor: Colors.grey[600],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close_rounded, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Cancelar",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => ElevatedButton(
                            onPressed: isLoading.value
                                ? null
                                : () => handleAnnouncement(controller, index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.amaranthpink,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 3,
                              shadowColor:
                                  Appcolor.amaranthpink.withValues(alpha: 0.3),
                            ),
                            child: isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.campaign_rounded, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        "Announce",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required int maxLength,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Appcolor.amaranthpink.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Appcolor.amaranthpink,
                size: 20,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: Appcolor.amaranthpink, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            counterText: "",
          ),
        ),
      ],
    );
  }

  Widget colorPickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Background Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => InkWell(
              onTap: () => showColorPicker(
                backgroundColor.value,
                (p0) {
                  backgroundColor.value = p0;
                },
              ),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Appcolor.amaranthpink.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.palette_rounded,
                        color: Appcolor.amaranthpink,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tap to choose color",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Selected: ${backgroundColor.value.toString()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: backgroundColor.value,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
