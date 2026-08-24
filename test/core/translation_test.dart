import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/localization/translation.dart';

void main() {
  test('Español contiene las claves globales críticas', () {
    final es = Translation().keys['es']!;
    for (final key in [
      '1',
      '2',
      'nav_home',
      'nav_favorites',
      'search_products',
      'cart',
      'language_title'
    ]) {
      expect(es.containsKey(key), isTrue, reason: 'Falta la clave $key');
      expect(es[key]!.trim(), isNotEmpty);
    }
  });

  test('Las traducciones comparten las claves base', () {
    final keys = Translation().keys;
    final es = keys['es']!.keys.toSet();
    expect(keys['en']!.keys.toSet(), es);
    expect(keys['ar']!.keys.toSet(), es);
  });
}
