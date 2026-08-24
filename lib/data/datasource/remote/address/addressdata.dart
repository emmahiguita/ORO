import 'package:oro/apilink.dart';
import 'package:oro/core/class/curd.dart';

class AddressData {
  Curd curd;
  AddressData(this.curd);
  addAddress(
      String userid,
      String addressname,
      String buildingname,
      String aptnumber,
      String floor,
      String street,
      String block,
      String way,
      String additional,
      String bymap,
      String deliverytime,
      String marker,
      String lat,
      String long) async {
    var resp = await curd.postData(AppLink.addAddress, {
      "userid": userid,
      "addressname": addressname,
      "buildingname": buildingname,
      "aptnumber": aptnumber,
      "floor": floor,
      "street": street,
      "block": block,
      "way": way,
      "additional": additional,
      "bymap": bymap,
      "deliverytime": deliverytime,
      "marker": marker,
      "lat": lat,
      "long": long
    });
    return resp.fold((s) => s, (r) => r);
  }

  getAddress(String userid) async {
    var resp = await curd.postData(AppLink.viewAddress, {
      "userid": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  deleteAddress(String addressid) async {
    var resp = await curd.postData(AppLink.deleteAddress, {
      "addressid": addressid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  updateAddress(
      String addressid,
      String addressname,
      String buildingname,
      String aptnumber,
      String floor,
      String street,
      String block,
      String way,
      String additional,
      String bymap,
      String deliverytime,
      String marker,
      String lat,
      String long) async {
    var resp = await curd.postData(AppLink.updateAddress, {
      "addressid": addressid,
      "addressname": addressname,
      "buildingname": buildingname,
      "aptnumber": aptnumber,
      "floor": floor,
      "street": street,
      "block": block,
      "way": way,
      "additional": additional,
      "bymap": bymap,
      "deliverytime": deliverytime,
      "marker": marker,
      "lat": lat,
      "long": long
    });
    return resp.fold((s) => s, (r) => r);
  }
}
