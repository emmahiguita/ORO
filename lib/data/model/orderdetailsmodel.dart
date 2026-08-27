import 'package:oro/core/functions/json_parser.dart';

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
  double? orderPrice;
  double? orderPricedelivery;
  double? orderTotalprice;
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
    cartId = JsonParser.asInt(json['cart_id']);
    cartUserid = JsonParser.asInt(json['cart_userid']);
    cartItemid = JsonParser.asInt(json['cart_itemid']);
    cartOrderid = JsonParser.asInt(json['cart_orderid']);
    itemId = JsonParser.asInt(json['item_id']);
    itemName = JsonParser.asString(json['item_name']);
    itemNameAr = JsonParser.asString(json['item_name_ar']);
    itemNameEs = JsonParser.asString(json['item_name_es']);
    itemDesc = JsonParser.asString(json['item_desc']);
    itemDescAr = JsonParser.asString(json['item_desc_ar']);
    itemDescEs = JsonParser.asString(json['item_desc_es']);
    itemImg = JsonParser.asString(json['item_img']);
    itemCount = JsonParser.asInt(json['item_count']) ?? 0;
    itemActive = JsonParser.asInt(json['item_active']) ?? 1;
    itemPrice = JsonParser.asDouble(json['item_price']);
    itemDiscount = JsonParser.asInt(json['item_discount']) ?? 0;
    itemDate = JsonParser.asString(json['item_date']);
    itemCat = JsonParser.asInt(json['item_cat']);
    itemFinalPrice = JsonParser.asDouble(json['item_final_price']) ?? itemPrice;
    categoryName = JsonParser.asString(json['category_name']);
    categoryNameAr = JsonParser.asString(json['category_name_ar']);
    categoryNameEs = JsonParser.asString(json['category_name_es']);
    orderId = JsonParser.asInt(json['order_id']);
    orderUserid = JsonParser.asInt(json['order_userid']);
    orderAddressid = JsonParser.asInt(json['order_addressid']);
    orderType = JsonParser.asInt(json['order_type']) ?? 0;
    orderPrice = JsonParser.asDouble(json['order_price']) ?? 0.0;
    orderPricedelivery =
        JsonParser.asDouble(json['order_pricedelivery']) ?? 0.0;
    orderTotalprice = JsonParser.asDouble(json['order_totalprice']) ?? 0.0;
    orderPaymenttype = JsonParser.asInt(json['order_paymenttype']) ?? 0;
    orderCoupon = JsonParser.asInt(json['order_coupon']) ?? 0;
    orderStatus = JsonParser.asInt(json['order_status']) ?? 0;
    orderDatetime = JsonParser.asString(json['order_datetime']);
    addressId = JsonParser.asInt(json['address_id']);
    addressUserid = JsonParser.asInt(json['address_userid']);
    addressName = JsonParser.asString(json['address_name']);
    addressBuilding = JsonParser.asString(json['address_building']);
    addressApt = JsonParser.asString(json['address_apt']);
    addressFloor = JsonParser.asString(json['address_floor']);
    addressStreet = JsonParser.asString(json['address_street']);
    addressBlock = JsonParser.asString(json['address_block']);
    addressWay = JsonParser.asString(json['address_way']);
    addressAdditional = JsonParser.asString(json['address_additional']);
    addressBymap = JsonParser.asString(json['address_bymap']);
    addressLat = JsonParser.asDouble(json['address_lat']);
    addressLong = JsonParser.asDouble(json['address_long']);
    totalprice = JsonParser.asDouble(json['totalprice']);
    countitems = JsonParser.asInt(json['countitems']) ?? 0;
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
