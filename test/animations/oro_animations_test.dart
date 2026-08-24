import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/theme/app_theme.dart';
import 'package:oro/view/widgets/animations/animations.dart';

void main() {
  group('Pruebas de Componentes de Animación ORO', () {
    testWidgets('OroAnimatedButton responde a toques y renderiza texto',
        (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: OroAnimatedButton(
              text: 'Comprar Ahora',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Comprar Ahora'), findsOneWidget);
      await tester.tap(find.text('Comprar Ahora'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('OroAnimatedCartBadge muestra contador y oculta en 0',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: OroAnimatedCartBadge(
              count: 3,
              child: Icon(Icons.shopping_bag),
            ),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('OroEmptyCart muestra título y botón de acción',
        (tester) async {
      bool explored = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: OroEmptyCart(
              onExplorePressed: () {
                explored = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Tu Carrito está Vacío'), findsOneWidget);
      expect(find.text('Explorar Catálogo'), findsOneWidget);

      await tester.tap(find.text('Explorar Catálogo'));
      await tester.pump();
      expect(explored, isTrue);
    });

    testWidgets('OroOrderSuccess renderiza resumen de orden', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: OroOrderSuccess(
              orderId: '8842',
              totalPrice: 450.0,
            ),
          ),
        ),
      );

      expect(find.text('¡Pedido Confirmado!'), findsOneWidget);
      expect(find.text('#8842'), findsOneWidget);
      expect(find.text('\$450.00'), findsOneWidget);
    });

    testWidgets('OroDeliveryStatus muestra etapa actual y progreso',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: OroDeliveryStatus(
              currentStep: OroDeliveryStep.onTheWay,
              orderId: '8842',
              riderName: 'Juan Pérez',
            ),
          ),
        ),
      );

      expect(find.text('En camino a tu dirección'), findsOneWidget);
      expect(find.text('Juan Pérez'), findsOneWidget);
    });
  });
}
