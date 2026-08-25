import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/functions/json_parser.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/data/model/cartmodel.dart';
import 'package:oro/data/model/ordersmodel.dart';

void main() {
  group('JsonParser unit tests', () {
    test('asInt parses int, num, String, and returns null safely', () {
      expect(JsonParser.asInt(10), 10);
      expect(JsonParser.asInt(10.8), 10);
      expect(JsonParser.asInt('42'), 42);
      expect(JsonParser.asInt(' 99 '), 99);
      expect(JsonParser.asInt('149.99'), 149);
      expect(JsonParser.asInt(null), isNull);
      expect(JsonParser.asInt(''), isNull);
      expect(JsonParser.asInt('invalid'), isNull);
    });

    test('asDouble parses double, num, String with comma/dot, and null safely', () {
      expect(JsonParser.asDouble(10.5), 10.5);
      expect(JsonParser.asDouble(10), 10.0);
      expect(JsonParser.asDouble('149.99'), 149.99);
      expect(JsonParser.asDouble('149,99'), 149.99);
      expect(JsonParser.asDouble(' 3.14 '), 3.14);
      expect(JsonParser.asDouble(null), isNull);
      expect(JsonParser.asDouble(''), isNull);
      expect(JsonParser.asDouble('invalid'), isNull);
    });

    test('asString handles non-null, trims, and converts empty to null', () {
      expect(JsonParser.asString('hello'), 'hello');
      expect(JsonParser.asString('  trimmed  '), 'trimmed');
      expect(JsonParser.asString(123), '123');
      expect(JsonParser.asString(''), isNull);
      expect(JsonParser.asString(null), isNull);
    });

    test('asBool parses boolean representations safely', () {
      expect(JsonParser.asBool(true), true);
      expect(JsonParser.asBool(false), false);
      expect(JsonParser.asBool('1'), true);
      expect(JsonParser.asBool('0'), false);
      expect(JsonParser.asBool('true'), true);
      expect(JsonParser.asBool('false'), false);
      expect(JsonParser.asBool('yes'), true);
      expect(JsonParser.asBool('no'), false);
      expect(JsonParser.asBool(null, fallback: true), true);
      expect(JsonParser.asBool(null, fallback: false), false);
    });
  });

  group('Model deserialization with PHP string formats', () {
    test('ItemsModel correctly deserializes PHP strings without crashing', () {
      final phpMap = {
        'item_id': '101',
        'item_name': 'Gold Ring',
        'item_name_ar': 'خاتم ذهب',
        'item_name_es': 'Anillo de oro',
        'item_price': '299.99',
        'item_discount': '15',
        'item_count': '5',
        'item_active': '1',
        'favourite': '1',
        'item_final_price': '254.99',
        'item_avg_rating': '4.8',
      };

      final model = ItemsModel.fromJson(phpMap);
      expect(model.itemId, 101);
      expect(model.itemName, 'Gold Ring');
      expect(model.itemPrice, 299.99);
      expect(model.itemDiscount, 15);
      expect(model.itemCount, 5);
      expect(model.favourite, 1);
      expect(model.itemFinalPrice, 254.99);
      expect(model.itemAvgRating, '4.8');
    });

    test('CartModel correctly deserializes mixed and null types', () {
      final cartMap = {
        'cart_id': '5',
        'cart_userid': '12',
        'cart_itemid': '101',
        'item_price': '150.00',
        'totalprice': '300.00',
        'countitems': '2',
      };

      final model = CartModel.fromJson(cartMap);
      expect(model.cartId, 5);
      expect(model.totalprice, 300.00);
      expect(model.countitems, 2);
    });

    test('OrdersModel correctly deserializes numeric fields as doubles', () {
      final ordersMap = {
        'order_id': '77',
        'order_status': '2',
        'order_price': '500.50',
        'order_pricedelivery': '25.00',
        'order_totalprice': '525.50',
      };

      final model = OrdersModel.fromJson(ordersMap);
      expect(model.orderId, 77);
      expect(model.orderStatus, 2);
      expect(model.orderPrice, 500.50);
      expect(model.orderPricedelivery, 25.00);
      expect(model.orderTotalprice, 525.50);
    });
  });
}
