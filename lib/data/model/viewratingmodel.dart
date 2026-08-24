class ViewRatingModel {
  int? ratingId;
  int? ratingUserid;
  int? ratingItemid;
  String? ratingStars;
  String? ratingComment;
  String? ratingDatetime;
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

  ViewRatingModel(
      {this.ratingId,
      this.ratingUserid,
      this.ratingItemid,
      this.ratingStars,
      this.ratingComment,
      this.ratingDatetime,
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

  ViewRatingModel.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingUserid = json['rating_userid'];
    ratingItemid = json['rating_itemid'];
    ratingStars = json['rating_stars'];
    ratingComment = json['rating_comment'];
    ratingDatetime = json['rating_datetime'];
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
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    categoryImg = json['category_img'];
    categoryDate = json['category_date'];
    itemFinalPrice = (json['item_final_price'] as num?)?.toDouble();
    itemAvgRating = json['item_avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating_id'] = ratingId;
    data['rating_userid'] = ratingUserid;
    data['rating_itemid'] = ratingItemid;
    data['rating_stars'] = ratingStars;
    data['rating_comment'] = ratingComment;
    data['rating_datetime'] = ratingDatetime;
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
