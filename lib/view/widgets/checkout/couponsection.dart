import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/checkout/couponcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponControllerImp>(
        builder: (controller) => Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: controller.isCouponUsed,
                    controller: controller.couponTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter coupon code",
                      hintStyle: const TextStyle(
                        fontFamily: "Sw",
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 51,
                  width: 81,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Appcolor.deepPink,
                        Appcolor.berry,
                      ],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: IgnorePointer(
                      ignoring: controller.isCouponUsed,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          controller.checkCoupon();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          child: controller.statusRequest ==
                                  StatusRequest.loding
                              ? const GradientProgressIndicator(strokeWidth: 3)
                              : controller.statusRequest ==
                                      StatusRequest.success
                                  ? const Icon(
                                      Icons.check_outlined,
                                      color: Appcolor.amaranthpink,
                                    )
                                  : const Text(
                                      "Apply",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
