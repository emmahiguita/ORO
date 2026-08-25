import 'package:oro/core/functions/json_parser.dart';

class CartModel {
  int? cartId;
  int? cartUserid;
  int? cartItemid;
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
  String? categoryName;
  String? categoryNameAr;
  String? categoryNameEs;
  double? totalprice;
  double? itemFinalPrice;
  int? countitems;

  CartModel({
    this.cartId,
    this.cartUserid,
    this.cartItemid,
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
    this.categoryName,
    this.categoryNameAr,
    this.categoryNameEs,
    this.totalprice,
    this.countitems,
    this.itemFinalPrice,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = JsonParser.asInt(json['cart_id']);
    cartUserid = JsonParser.asInt(json['cart_userid']);
    cartItemid = JsonParser.asInt(json['cart_itemid']);
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
    categoryName = JsonParser.asString(json['category_name']);
    categoryNameAr = JsonParser.asString(json['category_name_ar']);
    categoryNameEs = JsonParser.asString(json['category_name_es']);
    totalprice = JsonParser.asDouble(json['totalprice']);
    countitems = JsonParser.asInt(json['countitems']) ?? 0;
    itemFinalPrice = JsonParser.asDouble(json['item_final_price']) ?? itemPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['cart_userid'] = cartUserid;
    data['cart_itemid'] = cartItemid;
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
    data['category_name'] = categoryName;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_es'] = categoryNameEs;
    data['totalprice'] = totalprice;
    data['countitems'] = countitems;
    data['item_final_price'] = itemFinalPrice;
    return data;
  }
}
