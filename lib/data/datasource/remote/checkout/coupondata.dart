import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class CouponData {
  Curd curd;
  CouponData(this.curd);
  checkCoupon(String coupon) async {
    var resp = await curd.postData(AppLink.checkCoupon, {
      "coupon": coupon,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
