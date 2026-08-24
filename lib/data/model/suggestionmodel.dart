class SuggestionModel {
  String? itemName;
  String? itemNameEs;
  String? itemNameAr;

  SuggestionModel({this.itemName, this.itemNameEs, this.itemNameAr});

  SuggestionModel.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemNameEs = json['item_name_es'];
    itemNameAr = json['item_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['item_name_es'] = itemNameEs;
    data['item_name_ar'] = itemNameAr;
    return data;
  }
}
