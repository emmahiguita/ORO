import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oro/controller/admin/coupon/admincouponcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';

abstract class AddCouponController extends GetxController {
  addCoupon();
  chooseDate(String date);
  String formatDisplayDate(String? date);
  dynamic showDateTimePicker(
      BuildContext context, AddCouponControllerImp controller);
}

class AddCouponControllerImp extends AddCouponController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());

  TextEditingController? code;
  TextEditingController? count;
  TextEditingController? discount;
  TextEditingController? expirydate;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  addCoupon() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loding;
      var response = await adminData.addCoupon(
        code!.text,
        count!.text,
        discount!.text,
        expirydate!.text,
      );
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.back();
          Get.find<AdminCouponControllerImp>().getCoupons();
          Get.snackbar(
            "Éxito",
            "Cupón agregado con éxito",
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

  @override
  chooseDate(String date) {
    expirydate!.text = date.toString();
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

  @override
  showDateTimePicker(BuildContext context, AddCouponControllerImp controller) {
    DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now().add(const Duration(days: 30)),
      minDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 365 * 2)),
      onConfirm: (dateTime, List<int> index) {
        final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        controller.chooseDate(date);
      },
    );
  }

  @override
  void onInit() {
    code = TextEditingController();
    count = TextEditingController();
    discount = TextEditingController();
    expirydate = TextEditingController();
    super.onInit();
  }
}
