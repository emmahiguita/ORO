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
    cartId = json['cart_id'];
    cartUserid = json['cart_userid'];
    cartItemid = json['cart_itemid'];
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
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    totalprice = (json['totalprice'] as num?)?.toDouble();
    countitems = json['countitems'];
    itemFinalPrice = (json['item_final_price'] as num?)?.toDouble();
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
