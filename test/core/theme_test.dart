import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/theme/app_theme.dart';

void main() {
  test('Tema claro y oscuro son Material 3 y coherentes', () {
    expect(AppTheme.light.useMaterial3, isTrue);
    expect(AppTheme.dark.useMaterial3, isTrue);
    expect(AppTheme.light.brightness, Brightness.light);
    expect(AppTheme.dark.brightness, Brightness.dark);
    expect(AppTheme.light.colorScheme.primary,
        isNot(AppTheme.light.colorScheme.surface));
  });
}
