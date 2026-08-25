import 'package:oro/core/functions/json_parser.dart';

class OrdersModel {
  int? orderId;
  int? orderUserid;
  int? orderAddressid;
  int? orderType;
  double? orderPrice;
  double? orderPricedelivery;
  double? orderTotalprice;
  int? orderPaymenttype;
  int? orderCoupon;
  int? orderStatus;
  String? orderDatetime;

  OrdersModel({
    this.orderId,
    this.orderUserid,
    this.orderAddressid,
    this.orderType,
    this.orderPrice,
    this.orderPricedelivery,
    this.orderTotalprice,
    this.orderPaymenttype,
    this.orderCoupon,
    this.orderStatus,
    this.orderDatetime,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = JsonParser.asInt(json['order_id']);
    orderUserid = JsonParser.asInt(json['order_userid']);
    orderAddressid = JsonParser.asInt(json['order_addressid']);
    orderType = JsonParser.asInt(json['order_type']) ?? 0;
    orderPrice = JsonParser.asDouble(json['order_price']) ?? 0.0;
    orderPricedelivery = JsonParser.asDouble(json['order_pricedelivery']) ?? 0.0;
    orderTotalprice = JsonParser.asDouble(json['order_totalprice']) ?? 0.0;
    orderPaymenttype = JsonParser.asInt(json['order_paymenttype']) ?? 0;
    orderCoupon = JsonParser.asInt(json['order_coupon']) ?? 0;
    orderStatus = JsonParser.asInt(json['order_status']) ?? 0;
    orderDatetime = JsonParser.asString(json['order_datetime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_userid'] = orderUserid;
    data['order_addressid'] = orderAddressid;
    data['order_type'] = orderType;
    data['order_price'] = orderPrice;
    data['order_pricedelivery'] = orderPricedelivery;
    data['order_totalprice'] = orderTotalprice;
    data['order_paymenttype'] = orderPaymenttype;
    data['order_coupon'] = orderCoupon;
    data['order_status'] = orderStatus;
    data['order_datetime'] = orderDatetime;
    return data;
  }
}
