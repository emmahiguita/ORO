import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:oro/binding/initialbinding.dart';
import 'package:oro/controller/cart/cartController.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/core/theme/app_theme.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/itemcard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    Get.testMode = true;
    final prefs = await SharedPreferences.getInstance();
    final services = Services();
    services.sharedPreferences = prefs;
    Get.put<Services>(services);
    InitialBindings().dependencies();
    Get.put<FavouritesControllerImp>(FavouritesControllerImp());
    Get.put<CartControllerImp>(CartControllerImp());
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableCard({
    required ItemsModel model,
    double textScaleFactor = 1.0,
    ThemeData? theme,
    double width = 184,
    double height = 300,
  }) {
    return GetMaterialApp(
      theme: theme ?? AppTheme.light,
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
            size: const Size(400, 800),
          ),
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: ItemCard(
                itemsModel: model,
                onTap: () {},
                colorIndex: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('Product Card Robustness & Rendering Tests', () {
    testWidgets('Renders standard product card properly without crashing',
        (tester) async {
      final item = ItemsModel(
        itemId: 10,
        itemName: 'Polo Verde Clásico',
        categoryName: 'Moda',
        itemPrice: 149900,
        itemFinalPrice: 129900,
        itemDiscount: 13,
        itemAvgRating: '4.9',
      );

      await tester.pumpWidget(buildTestableCard(model: item));
      await tester.pump();

      expect(find.text('Polo Verde Clásico'), findsOneWidget);
      expect(find.text('MODA'), findsOneWidget);
      expect(find.text('4.9'), findsOneWidget);
      expect(find.text('-13%'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
        'Handles null fields gracefully (null itemId, rating, image, etc.)',
        (tester) async {
      final item = ItemsModel(
        itemId: null,
        itemName: null,
        categoryName: null,
        itemPrice: null,
        itemFinalPrice: null,
        itemDiscount: null,
        itemAvgRating: null,
        itemImg: null,
      );

      await tester.pumpWidget(buildTestableCard(model: item));
      await tester.pump();

      // No fake rating should appear
      expect(find.byIcon(Icons.star_rounded), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
        'Handles extremely long product and category names without overflow',
        (tester) async {
      final item = ItemsModel(
        itemId: 99,
        itemName:
            'Smart TV Ultra HD 8K HDR OLED Supreme Edition 2026 Con Procesador Cuántico Inteligente Y Sonido Espacial 360',
        categoryName:
            'Tecnología, Audio, Video Y Entretenimiento Para El Hogar',
        itemPrice: 12999999,
        itemFinalPrice: 9999999,
        itemDiscount: 23,
        itemAvgRating: '4.8',
      );

      await tester.pumpWidget(buildTestableCard(model: item));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('Renders properly with extreme prices and zero discount',
        (tester) async {
      final item = ItemsModel(
        itemId: 1,
        itemName: 'Accesorio Mínimo',
        categoryName: 'Varios',
        itemPrice: 9900,
        itemFinalPrice: 9900,
        itemDiscount: 0,
        itemAvgRating: '0.0',
      );

      await tester.pumpWidget(buildTestableCard(model: item));
      await tester.pump();

      // Discount tag should not be visible when discount == 0
      expect(find.text('-0%'), findsNothing);
      expect(find.byIcon(Icons.star_rounded), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Renders safely under textScale 1.5 and 2.0 without exceptions',
        (tester) async {
      final item = ItemsModel(
        itemId: 77,
        itemName: 'Chaqueta de Cuero Premium',
        categoryName: 'Moda',
        itemPrice: 389900,
        itemFinalPrice: 299900,
        itemDiscount: 23,
        itemAvgRating: '5.0',
      );

      await tester.pumpWidget(
        buildTestableCard(model: item, textScaleFactor: 2.0, height: 340),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('Renders in Dark Theme flawlessly', (tester) async {
      final item = ItemsModel(
        itemId: 55,
        itemName: 'Reloj Cronógrafo ORO',
        categoryName: 'Joyería',
        itemPrice: 850000,
        itemFinalPrice: 720000,
        itemDiscount: 15,
        itemAvgRating: '4.9',
      );

      await tester.pumpWidget(
        buildTestableCard(model: item, theme: AppTheme.dark),
      );
      await tester.pump();

      expect(find.text('Reloj Cronógrafo ORO'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
