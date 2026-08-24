class DeliveryRequestModel {
  int? orderTotalprice;
  String? orderDatetime;
  int? orderPaymenttype;
  int? orderId;
  int? orderUserid;
  String? userName;
  String? userPhone;
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

  DeliveryRequestModel(
      {this.orderTotalprice,
      this.orderDatetime,
      this.orderPaymenttype,
      this.orderId,
      this.orderUserid,
      this.userName,
      this.userPhone,
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

  DeliveryRequestModel.fromJson(Map<String, dynamic> json) {
    orderTotalprice = json['order_totalprice'];
    orderDatetime = json['order_datetime'];
    orderPaymenttype = json['order_paymenttype'];
    orderId = json['order_id'];
    orderUserid = json['order_userid'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
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
    data['order_totalprice'] = orderTotalprice;
    data['order_datetime'] = orderDatetime;
    data['order_paymenttype'] = orderPaymenttype;
    data['order_id'] = orderId;
    data['order_userid'] = orderUserid;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
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
