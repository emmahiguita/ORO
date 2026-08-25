import 'package:oro/core/functions/json_parser.dart';

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
    ratingId = JsonParser.asInt(json['rating_id']);
    ratingUserid = JsonParser.asInt(json['rating_userid']);
    ratingItemid = JsonParser.asInt(json['rating_itemid']);
    ratingStars = JsonParser.asString(json['rating_stars']) ?? '5';
    ratingComment = JsonParser.asString(json['rating_comment']) ?? '';
    ratingDatetime = JsonParser.asString(json['rating_datetime']);
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
    categoryId = JsonParser.asInt(json['category_id']);
    categoryName = JsonParser.asString(json['category_name']);
    categoryNameAr = JsonParser.asString(json['category_name_ar']);
    categoryNameEs = JsonParser.asString(json['category_name_es']);
    categoryImg = JsonParser.asString(json['category_img']);
    categoryDate = JsonParser.asString(json['category_date']);
    itemFinalPrice = JsonParser.asDouble(json['item_final_price']) ?? itemPrice;
    itemAvgRating = JsonParser.asString(json['item_avg_rating']) ?? '5.0';
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
