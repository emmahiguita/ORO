import 'package:oro/core/functions/json_parser.dart';

class CouponModel {
  int? couponId;
  String? couponCode;
  int? couponCount;
  int? couponDiscount;
  String? couponExpirydate;

  CouponModel(
      {this.couponId,
      this.couponCode,
      this.couponCount,
      this.couponDiscount,
      this.couponExpirydate});

  CouponModel.fromJson(Map<String, dynamic> json) {
    couponId = JsonParser.asInt(json['coupon_id']);
    couponCode = JsonParser.asString(json['coupon_code']);
    couponCount = JsonParser.asInt(json['coupon_count']) ?? 0;
    couponDiscount = JsonParser.asInt(json['coupon_discount']) ?? 0;
    couponExpirydate = JsonParser.asString(json['coupon_expirydate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['coupon_count'] = couponCount;
    data['coupon_discount'] = couponDiscount;
    data['coupon_expirydate'] = couponExpirydate;
    return data;
  }
}
