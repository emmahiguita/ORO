class ItemDeliveryModel {
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

  ItemDeliveryModel(
      {this.itemId,
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
      this.itemCat});

  ItemDeliveryModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}
