import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oro/controller/admin/coupon/admincouponcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/couponmodel.dart';

abstract class EditCouponController extends GetxController {
  editCoupon();
  chooseDate(String date);
  String getCouponStatus(String? expiryDate);
  String formatDisplayDate(String? date);
  void showCancelDialog(BuildContext context);
  void showSaveConfirmDialog(
      BuildContext context, EditCouponControllerImp controller);
  void showDateTimePicker(
      BuildContext context, EditCouponControllerImp controller);
  void updateUI();
}

class EditCouponControllerImp extends EditCouponController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());

  TextEditingController? code;
  TextEditingController? count;
  TextEditingController? discount;
  TextEditingController? expirydate;

  GlobalKey<FormState> formKey = GlobalKey();

  CouponModel couponModel = CouponModel();

  @override
  editCoupon() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loding;
      var response = await adminData.editCoupon(
        couponModel.couponId.toString(),
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
            "Cupón modificado con éxito",
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
  chooseDate(date) {
    expirydate!.text = date.toString();
    update();
  }

  @override
  String getCouponStatus(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) return 'UNKNOWN';
    try {
      final expiry = DateTime.parse(expiryDate);
      return expiry.isBefore(DateTime.now()) ? 'EXPIRED' : 'ACTIVE';
    } catch (e) {
      return 'UNKNOWN';
    }
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
  void showCancelDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Discard Changes',
      middleText: 'Are you sure you want to discard your changes?',
      textConfirm: 'Discard',
      textCancel: 'Seguir editando',
      backgroundColor: Appcolor.white,
      buttonColor: Appcolor.berry,
      cancelTextColor: Appcolor.black,
      onCancel: () {},
      onConfirm: () {
        Get.back();
      },
    );
  }

  @override
  showDateTimePicker(BuildContext context, EditCouponControllerImp controller) {
    DateTime? currentDate;
    try {
      currentDate = controller.expirydate!.text.isNotEmpty
          ? DateTime.parse(controller.expirydate!.text)
          : DateTime.now().add(const Duration(days: 30));
    } catch (e) {
      currentDate = DateTime.now().add(const Duration(days: 30));
    }

    DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: currentDate,
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        controller.chooseDate(date);
      },
    );
  }

  @override
  showSaveConfirmDialog(
      BuildContext context, EditCouponControllerImp controller) {
    Get.defaultDialog(
      title: 'Guardar cambios',
      middleText: 'Are you sure you want to save these changes to the coupon?',
      textConfirm: 'Guardar',
      textCancel: 'Cancelar',
      backgroundColor: Appcolor.white,
      buttonColor: Appcolor.berry,
      cancelTextColor: Appcolor.black,
      onCancel: () {},
      onConfirm: () {
        editCoupon();
      },
    );
  }

  @override
  void onInit() {
    couponModel = Get.arguments["couponModel"];

    code = TextEditingController();
    count = TextEditingController();
    discount = TextEditingController();
    expirydate = TextEditingController();

    code!.text = couponModel.couponCode.toString();
    count!.text = couponModel.couponCount.toString();
    discount!.text = couponModel.couponDiscount.toString();
    expirydate!.text = couponModel.couponExpirydate!;

    super.onInit();
  }

  @override
  updateUI() {
    update();
  }
}
