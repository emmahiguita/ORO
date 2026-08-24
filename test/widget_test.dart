import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/theme/app_theme.dart';

void main() {
  testWidgets('El design system premium renderiza una pantalla Material',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light,
      home: const Scaffold(body: Center(child: Text('DevEmm Commerce'))),
    ));
    expect(find.text('DevEmm Commerce'), findsOneWidget);
  });
}
