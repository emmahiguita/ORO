import 'package:oro/core/functions/json_parser.dart';

class AddressModel {
  int? addressId;
  int? addressUserid;
  String? addressName;
  String? addressBuilding;
  String? addressApt;
  String? addressFloor;
  String? addressStreet;
  String? addressBlock;
  String? addressWay;
  String? addressAdditional;
  String? addressBymap;
  String? addressDeliverytime;
  double? addressLat;
  double? addressLong;

  AddressModel(
      {this.addressId,
      this.addressUserid,
      this.addressName,
      this.addressBuilding,
      this.addressApt,
      this.addressFloor,
      this.addressStreet,
      this.addressBlock,
      this.addressWay,
      this.addressAdditional,
      this.addressBymap,
      this.addressDeliverytime,
      this.addressLat,
      this.addressLong});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = JsonParser.asInt(json['address_id']);
    addressUserid = JsonParser.asInt(json['address_userid']);
    addressName = JsonParser.asString(json['address_name']);
    addressBuilding = JsonParser.asString(json['address_building']);
    addressApt = JsonParser.asString(json['address_apt']);
    addressFloor = JsonParser.asString(json['address_floor']);
    addressStreet = JsonParser.asString(json['address_street']);
    addressBlock = JsonParser.asString(json['address_block']);
    addressWay = JsonParser.asString(json['address_way']);
    addressAdditional = JsonParser.asString(json['address_additional']);
    addressBymap = JsonParser.asString(json['address_bymap']);
    addressDeliverytime = JsonParser.asString(json['address_deliverytime']);
    addressLat = JsonParser.asDouble(json['address_lat']);
    addressLong = JsonParser.asDouble(json['address_long']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address_userid'] = addressUserid;
    data['address_name'] = addressName;
    data['address_building'] = addressBuilding;
    data['address_apt'] = addressApt;
    data['address_floor'] = addressFloor;
    data['address_street'] = addressStreet;
    data['address_block'] = addressBlock;
    data['address_way'] = addressWay;
    data['address_additional'] = addressAdditional;
    data['address_bymap'] = addressBymap;
    data['address_deliverytime'] = addressDeliverytime;
    data['address_lat'] = addressLat;
    data['address_long'] = addressLong;
    return data;
  }
}
