class ViewFavouritesModel {
  int? favouriteId;
  int? favouriteUserid;
  int? favouriteItemid;
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
  int? categoryId;
  String? categoryName;
  String? categoryNameAr;
  String? categoryNameEs;
  String? categoryImg;
  String? categoryDate;
  double? itemFinalPrice;
  String? itemAvgRating;

  ViewFavouritesModel(
      {this.favouriteId,
      this.favouriteUserid,
      this.favouriteItemid,
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
      this.categoryId,
      this.categoryName,
      this.categoryNameAr,
      this.categoryNameEs,
      this.categoryImg,
      this.categoryDate,
      this.itemFinalPrice,
      this.itemAvgRating});

  ViewFavouritesModel.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    favouriteUserid = json['favourite_userid'];
    favouriteItemid = json['favourite_itemid'];
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
    itemPrice = json['item_price'].toDouble();
    itemDiscount = json['item_discount'];
    itemDate = json['item_date'];
    itemCat = json['item_cat'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    categoryImg = json['category_img'];
    categoryDate = json['category_date'];
    itemFinalPrice = json['item_final_price'].toDouble();
    itemAvgRating = json['item_avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favourite_id'] = favouriteId;
    data['favourite_userid'] = favouriteUserid;
    data['favourite_itemid'] = favouriteItemid;
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
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_es'] = categoryNameEs;
    data['category_img'] = categoryImg;
    data['category_date'] = categoryDate;
    data['item_final_price'] = itemFinalPrice;
    data['item_avg_rating'] = itemAvgRating;
    return data;
  }
}
