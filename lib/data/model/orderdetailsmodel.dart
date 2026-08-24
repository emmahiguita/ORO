class OrderDetailsModel {
  int? cartId;
  int? cartUserid;
  int? cartItemid;
  int? cartOrderid;
  int? itemId;
  String? itemName;
  String? itemNameAr;
  String? itemNameEs;
  String? itemDesc;
  String? itemDescAr;
  String? itemDescEs;
  String? itemImg;
  int? itemCount;
  int? itemActive;
  double? itemPrice;
  int? itemDiscount;
  String? itemDate;
  int? itemCat;
  double? itemFinalPrice;
  String? categoryName;
  String? categoryNameAr;
  String? categoryNameEs;
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
  double? addressLat;
  double? addressLong;
  double? totalprice;
  int? countitems;

  OrderDetailsModel(
      {this.cartId,
      this.cartUserid,
      this.cartItemid,
      this.cartOrderid,
      this.itemId,
      this.itemName,
      this.itemNameAr,
      this.itemNameEs,
      this.itemDesc,
      this.itemDescAr,
      this.itemDescEs,
      this.itemImg,
      this.itemCount,
      this.itemActive,
      this.itemPrice,
      this.itemDiscount,
      this.itemDate,
      this.itemCat,
      this.itemFinalPrice,
      this.categoryName,
      this.categoryNameAr,
      this.categoryNameEs,
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
      this.addressLat,
      this.addressLong,
      this.totalprice,
      this.countitems});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    cartUserid = json['cart_userid'];
    cartItemid = json['cart_itemid'];
    cartOrderid = json['cart_orderid'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemNameAr = json['item_name_ar'];
    itemNameEs = json['item_name_es'];
    itemDesc = json['item_desc'];
    itemDescAr = json['item_desc_ar'];
    itemDescEs = json['item_desc_es'];
    itemImg = json['item_img'];
    itemCount = json['item_count'];
    itemActive = json['item_active'];
    itemPrice = (json['item_price'] as num?)?.toDouble();
    itemDiscount = json['item_discount'];
    itemDate = json['item_date'];
    itemCat = json['item_cat'];
    itemFinalPrice = (json['item_final_price'] as num?)?.toDouble();
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    orderId = json['order_id'];
    orderUserid = json['order_userid'];
    orderAddressid = json['order_addressid'];
    orderType = json['order_type'];
    orderPrice = json['order_price'];
    orderPricedelivery = json['order_pricedelivery'];
    orderTotalprice = json['order_totalprice'];
    orderPaymenttype = json['order_paymenttype'];
    orderCoupon = json['order_coupon'];
    orderStatus = json['order_status'];
    orderDatetime = json['order_datetime'];
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
    addressLat = json['address_lat'];
    addressLong = json['address_long'];
    totalprice = (json['totalprice'] as num?)?.toDouble();
    countitems = json['countitems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['cart_userid'] = cartUserid;
    data['cart_itemid'] = cartItemid;
    data['cart_orderid'] = cartOrderid;
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_name_ar'] = itemNameAr;
    data['item_name_es'] = itemNameEs;
    data['item_desc'] = itemDesc;
    data['item_desc_ar'] = itemDescAr;
    data['item_desc_es'] = itemDescEs;
    data['item_img'] = itemImg;
    data['item_count'] = itemCount;
    data['item_active'] = itemActive;
    data['item_price'] = itemPrice;
    data['item_discount'] = itemDiscount;
    data['item_date'] = itemDate;
    data['item_cat'] = itemCat;
    data['item_final_price'] = itemFinalPrice;
    data['category_name'] = categoryName;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_es'] = categoryNameEs;
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
    data['address_lat'] = addressLat;
    data['address_long'] = addressLong;
    data['totalprice'] = totalprice;
    data['countitems'] = countitems;
    return data;
  }
}
