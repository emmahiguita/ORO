import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class CheckoutData {
  final Curd curd;
  CheckoutData(this.curd);

  Future<dynamic> getPublicConfig() async {
    final resp = await curd.postData(AppLink.publicConfig, const {});
    return resp.fold((s) => s, (r) => r);
  }

  Future<dynamic> placeOrder(
    String userID,
    String addressID,
    String type,
    String price,
    String pricedelivery,
    String paymenttype,
    String couponID,
  ) async {
    // userID, price y pricedelivery se mantienen en la firma por compatibilidad
    // con el código legado, pero NO se envían: el servidor usa el token y
    // recalcula precios/inventario de forma autoritativa.
    final resp = await curd.postData(AppLink.checkout, {
      'ordaddressiderid': addressID == 'null' ? '0' : addressID,
      'type': type,
      'paymenttype': paymenttype,
      'coupon': couponID,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
