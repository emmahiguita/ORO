class AdminDetails {
  int? orderId;
  int? orderType;
  int? orderPrice;
  int? orderPricedelivery;
  int? orderTotalprice;
  int? orderPaymenttype;
  double? orderStatus;
  String? orderDatetime;
  String? couponCode;
  int? couponDiscount;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPfp;
  int? addressId;
  int? addressUserid;
  String? addressName;
  String? addressBuilding;
  String? addressApt;
  String? addressFloor;
  String? addressStreet;
  String? addressBlock;
  String? addressWay;
  String? addressAdditional;
  String? addressBymap;
  String? addressDeliverytime;
  double? addressLat;
  double? addressLong;

  AdminDetails(
      {this.orderId,
      this.orderType,
      this.orderPrice,
      this.orderPricedelivery,
      this.orderTotalprice,
      this.orderPaymenttype,
      this.orderStatus,
      this.orderDatetime,
      this.couponCode,
      this.couponDiscount,
      this.userId,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userPfp,
      this.addressId,
      this.addressUserid,
      this.addressName,
      this.addressBuilding,
      this.addressApt,
      this.addressFloor,
      this.addressStreet,
      this.addressBlock,
      this.addressWay,
      this.addressAdditional,
      this.addressBymap,
      this.addressDeliverytime,
      this.addressLat,
      this.addressLong});

  AdminDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    orderPrice = json['order_price'];
    orderPricedelivery = json['order_pricedelivery'];
    orderTotalprice = json['order_totalprice'];
    orderPaymenttype = json['order_paymenttype'];
    orderStatus = (json['order_status'] as num?)?.toDouble();
    orderDatetime = json['order_datetime'];
    couponCode = json['coupon_code'];
    couponDiscount = json['coupon_discount'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userPfp = json['user_pfp'];
    addressId = json['address_id'];
    addressUserid = json['address_userid'];
    addressName = json['address_name'];
    addressBuilding = json['address_building'];
    addressApt = json['address_apt'];
    addressFloor = json['address_floor'];
    addressStreet = json['address_street'];
    addressBlock = json['address_block'];
    addressWay = json['address_way'];
    addressAdditional = json['address_additional'];
    addressBymap = json['address_bymap'];
    addressDeliverytime = json['address_deliverytime'];
    addressLat = json['address_lat'];
    addressLong = json['address_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_type'] = orderType;
    data['order_price'] = orderPrice;
    data['order_pricedelivery'] = orderPricedelivery;
    data['order_totalprice'] = orderTotalprice;
    data['order_paymenttype'] = orderPaymenttype;
    data['order_status'] = orderStatus;
    data['order_datetime'] = orderDatetime;
    data['coupon_code'] = couponCode;
    data['coupon_discount'] = couponDiscount;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['user_pfp'] = userPfp;
    data['address_id'] = addressId;
    data['address_userid'] = addressUserid;
    data['address_name'] = addressName;
    data['address_building'] = addressBuilding;
    data['address_apt'] = addressApt;
    data['address_floor'] = addressFloor;
    data['address_street'] = addressStreet;
    data['address_block'] = addressBlock;
    data['address_way'] = addressWay;
    data['address_additional'] = addressAdditional;
    data['address_bymap'] = addressBymap;
    data['address_deliverytime'] = addressDeliverytime;
    data['address_lat'] = addressLat;
    data['address_long'] = addressLong;
    return data;
  }
}
