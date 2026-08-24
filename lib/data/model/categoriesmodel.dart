class CategoriesModel {
  int? categoryId;
  String? categoryName;
  String? categoryNameAr;
  String? categoryNameEs;
  String? categoryImg;
  String? categoryDate;

  CategoriesModel(
      {this.categoryId,
      this.categoryName,
      this.categoryNameAr,
      this.categoryNameEs,
      this.categoryImg,
      this.categoryDate});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEs = json['category_name_es'];
    categoryImg = json['category_img'];
    categoryDate = json['category_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_es'] = categoryNameEs;
    data['category_img'] = categoryImg;
    data['category_date'] = categoryDate;
    return data;
  }
}
