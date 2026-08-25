import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/admin/admindata.dart';
import 'package:oro/data/model/admindetails.dart';
import 'package:oro/data/model/itemdeliverymodel.dart';

abstract class AdminOrderDetailsController extends GetxController {
  getOrderDetails();
  String getPaymentType(int paymentCode);
  String getOrderType(int typeCode);
  getStatusText(double statusCode, int orderType);
}

class AdminOrderDetailsControllerImp extends AdminOrderDetailsController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<ItemDeliveryModel> orderDetails = [];
  AdminDetails adminDetailsModel = AdminDetails();
  String? orderid;
  Marker? marker;
  CameraPosition? cameraPosition;

  @override
  getOrderDetails() async {
    if (orderid == null || orderid!.isEmpty) return;
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await adminData.getOrderDetails(orderid!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        orderDetails.addAll(
          data.map(
            (e) => ItemDeliveryModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is Map) {
      orderid = args['orderid']?.toString();
      if (args['orderDetail'] is AdminDetails) {
        adminDetailsModel = args['orderDetail'];
      }
    }
    getOrderDetails();
    marker = Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(
        adminDetailsModel.addressLat ?? 0,
        adminDetailsModel.addressLong ?? 0,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    );
    cameraPosition = CameraPosition(
      target: LatLng(
        adminDetailsModel.addressLat ?? 0,
        adminDetailsModel.addressLong ?? 0,
      ),
      zoom: 14.4746,
    );
    super.onInit();
  }

  @override
  getPaymentType(paymentCode) {
    switch (paymentCode) {
      case 0:
        return 'Visa';
      case 1:
        return 'Master Card';
      case 2:
        return 'American Express';
      case 3:
        return 'PayPal';
      case 4:
        return 'Cash';
      default:
        return 'Método de pago desconocido';
    }
  }

  @override
  getOrderType(typeCode) {
    switch (typeCode) {
      case 0:
        return 'Delivery';
      case 1:
        return 'Pick Up';
      default:
        return 'Unknown Order Method';
    }
  }

  @override
  String getStatusText(double statusCode, int orderType) {
    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case 1.5:
        return 'Waiting for delivery';
      case -1:
        return 'Cancelado';
      case 5:
        return 'Picked Up';
      case 6:
        return 'Archived';
    }

    if (orderType == 0) {
      switch (statusCode) {
        case 2:
          return 'On The Way';
        case 3:
          return 'Entregado';
      }
    } else {
      if (statusCode == 4) return 'Ready for Pickup';
    }

    return 'Unknown Status';
  }
}
