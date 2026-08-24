class OrdersModel {
  int? orderId;
  int? orderUserid;
  int? orderAddressid;
  int? orderType;
  int? orderPrice;
  int? orderPricedelivery;
  int? orderTotalprice;
  int? orderPaymenttype;
  int? orderCoupon;
  int? orderStatus;
  String? orderDatetime;

  OrdersModel(
      {this.orderId,
      this.orderUserid,
      this.orderAddressid,
      this.orderType,
      this.orderPrice,
      this.orderPricedelivery,
      this.orderTotalprice,
      this.orderPaymenttype,
      this.orderCoupon,
      this.orderStatus,
      this.orderDatetime});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderUserid = json['order_userid'];
    orderAddressid = json['order_addressid'];
    orderType = json['order_type'];
    orderPrice = json['order_price'];
    orderPricedelivery = json['order_pricedelivery'];
    orderTotalprice = json['order_totalprice'];
    orderPaymenttype = json['order_paymenttype'];
    orderCoupon = json['order_coupon'];
    orderStatus = (json['order_status'] as num?)?.toInt();
    orderDatetime = json['order_datetime'];
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
