import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/data/datasource/remote/delivery/deliverydata.dart';
import 'package:oro/data/model/itemdeliverymodel.dart';
import 'package:oro/view/screens/delivery/deliverynavigation.dart';

abstract class DeliveryOrderDetailsController extends GetxController {
  getOrderDetails();
  goToNavigation();
}

class DeliveryOrderDetailsControllerImp extends DeliveryOrderDetailsController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<ItemDeliveryModel> orderDetails = [];
  dynamic undeliveredOrders;
  String? orderid;

  bool isDelivered = false;

  @override
  getOrderDetails() async {
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await deliveryData.getOrderDetails(orderid!);
    print(response);
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
    orderid = Get.arguments['orderid'];
    undeliveredOrders = Get.arguments['undeliveredOrder'];
    isDelivered = Get.arguments?['isDelivered'] ?? false;
    getOrderDetails();
    super.onInit();
  }

  @override
  goToNavigation() {
    Get.to(() => const DeliveryNavigation(),
        arguments: {'orderid': orderid, 'undeliveredOrder': undeliveredOrders});
  }
}
