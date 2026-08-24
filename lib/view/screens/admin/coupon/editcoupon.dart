import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/coupon/editcouponcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/SectionHeader.dart';
import 'package:oro/view/widgets/admin/inputfield.dart';
import 'package:oro/view/widgets/admin/previewsection.dart';

class EditCoupon extends StatelessWidget {
  const EditCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    EditCouponControllerImp controller = Get.put(EditCouponControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Editar cupón',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Appcolor.berry,
          elevation: 2,
          shadowColor: Appcolor.berry.withValues(alpha: 0.3),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with Status
                GetBuilder<EditCouponControllerImp>(
                  builder: (controller) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Appcolor.berry.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 24,
                                color: Appcolor.berry,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Edit Coupon Details',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolor.berry,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Update coupon information and settings',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: controller.getCouponStatus(
                                            controller.expirydate!.text) ==
                                        'ACTIVE'
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.red.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                controller.getCouponStatus(
                                    controller.expirydate!.text),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: controller.getCouponStatus(
                                              controller.expirydate!.text) ==
                                          'ACTIVE'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Form Fields
                const SectionHeader(title: 'Coupon Information'),
                const SizedBox(height: 16),

                // Coupon Code Field
                InputField(
                  onChanged: (value) {
                    controller.update();
                  },
                  controller: controller.code!,
                  label: 'Coupon Code',
                  hint: 'e.g., SAVE20, NEWUSER',
                  icon: Icons.code,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Coupon code is required';
                    }
                    if (value!.length < 3) {
                      return 'Code must be at least 3 characters';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    LengthLimitingTextInputFormatter(20),
                  ],
                  textCapitalization: TextCapitalization.characters,
                ),

                const SizedBox(height: 20),

                // Count and Discount Row
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        onChanged: (value) {
                          controller.update();
                        },
                        controller: controller.count!,
                        label: 'Usage Limit',
                        hint: 'e.g., 100',
                        icon: Icons.inventory_2_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Usage limit is required';
                          }
                          final count = int.tryParse(value!);
                          if (count == null || count < 0) {
                            return 'Enter valid number';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputField(
                        onChanged: (value) {
                          controller.update();
                        },
                        controller: controller.discount!,
                        label: 'Discount %',
                        hint: 'e.g., 20',
                        icon: Icons.percent,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Discount is required';
                          }
                          final discount = double.tryParse(value!);
                          if (discount == null ||
                              discount <= 0 ||
                              discount > 100) {
                            return 'Enter 1-100';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                          LengthLimitingTextInputFormatter(5),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Expiry Date Field
                InputField(
                  onChanged: (value) {
                    controller.update();
                  },
                  controller: controller.expirydate!,
                  label: 'Expiry Date & Time',
                  hint: 'Select expiry date',
                  icon: Icons.calendar_today_outlined,
                  readOnly: true,
                  onTap: () {
                    controller.showDateTimePicker(context, controller);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Expiry date is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Current Preview Section
                GetBuilder<EditCouponControllerImp>(
                  builder: (controller) =>
                      PreviewSection(controller: controller),
                ),

                const SizedBox(height: 32),

                const SizedBox(height: 32),

                // Action Buttons
                Column(
                  children: [
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.showSaveConfirmDialog(
                                context, controller);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.berry,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                          shadowColor: Appcolor.berry.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_outlined, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Guardar cambios',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Cancel Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.showCancelDialog(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
