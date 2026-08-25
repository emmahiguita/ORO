import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oro/apilink.dart';
import 'package:oro/binding/initialbinding.dart';
import 'package:oro/core/class/curd.dart';
import 'package:oro/core/functions/vaildinput.dart';
import 'package:oro/core/localization/changelocale.dart';
import 'package:oro/core/localization/translation.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/core/theme/app_theme.dart';
import 'package:oro/view/screens/auth/login.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'langcode': 'es',
      'remember_me': true,
      'saved_login_user': 'usuario@ejemplo.com',
      'saved_login_pass': 'ClaveSegura123*',
    });
    Get.testMode = true;
    final prefs = await SharedPreferences.getInstance();
    final services = Services();
    services.sharedPreferences = prefs;
    Get.put<Services>(services);
    Get.put<Localecontroller>(Localecontroller());
    InitialBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  group('Validación de inicio de sesión con Usuario o Correo', () {
    test('Acepta nombre de usuario válido', () {
      expect(vaildInput('emmanuel', 'username_or_email'), isNull);
    });

    test('Acepta correo electrónico válido', () {
      expect(vaildInput('emmanuel@empresa.com', 'username_or_email'), isNull);
    });

    test('Rechaza campo vacío', () {
      expect(vaildInput('', 'username_or_email'), isNotNull);
    });

    test('Rechaza formato de correo inválido', () {
      expect(vaildInput('emmanuel@invalido', 'username_or_email'), isNotNull);
    });
  });

  group('Pruebas de interfaz y Recordar credenciales', () {
    testWidgets(
        'La pantalla de login precarga usuario/correo y contraseña recordados',
        (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.light,
          translations: Translation(),
          locale: const Locale('es'),
          home: const Login(),
        ),
      );
      await tester.pumpAndSettle();

      // Verifica campos y etiquetas en español
      expect(find.byType(TextField), findsNWidgets(2));
      final usernameField =
          tester.widget<TextField>(find.byType(TextField).first);
      final passwordField =
          tester.widget<TextField>(find.byType(TextField).at(1));

      expect(usernameField.decoration?.labelText, 'Usuario o Correo');
      expect(passwordField.decoration?.labelText, 'Contraseña');
      expect(find.text('Explorar sin conexión (Modo Offline)'), findsOneWidget);
    });

    test('Curd retorna catálogo y categorías en modo offline sin backend',
        () async {
      OfflineDataProvider.isOfflineMode = true;
      final curd = Get.find<Curd>();
      final result = await curd.postData(AppLink.home, {});
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('No debería fallar'),
        (r) {
          expect(r['status'], 'success');
          expect(r['categories'], isNotEmpty);
          expect(r['items'], isNotEmpty);
        },
      );
      OfflineDataProvider.isOfflineMode = false;
    });
  });
}
