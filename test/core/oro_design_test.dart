import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oro/core/design/oro_breakpoints.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/core/design/oro_pressable.dart';

void main() {
  group('OroDesign Tokens & Breakpoints Test', () {
    test('Breakpoints columns and aspect ratio calculations', () {
      expect(OroBreakpoints.gridColumns(360), 2);
      expect(OroBreakpoints.gridColumns(599), 2);
      expect(OroBreakpoints.gridColumns(600), 3);
      expect(OroBreakpoints.gridColumns(839), 3);
      expect(OroBreakpoints.gridColumns(840), 4);
      expect(OroBreakpoints.gridColumns(1199), 4);
      expect(OroBreakpoints.gridColumns(1200), 5);

      expect(OroBreakpoints.productAspectRatio(360), 0.56);
      expect(OroBreakpoints.productAspectRatio(700), 0.58);
      expect(OroBreakpoints.productAspectRatio(900), 0.62);
      expect(OroBreakpoints.productAspectRatio(1300), 0.66);
    });

    test('OroColors primary tokens integrity', () {
      expect(OroColors.ink, const Color(0xFF07120E));
      expect(OroColors.forest, const Color(0xFF0B4D36));
      expect(OroColors.accentGold, const Color(0xFFC89B3C));
      expect(OroColors.canvas, const Color(0xFFF7F5EF));
      expect(OroColors.surface, const Color(0xFFFFFDF8));
    });

    test('OroMotion durations and curves', () {
      expect(OroMotion.fast, const Duration(milliseconds: 160));
      expect(OroMotion.medium, const Duration(milliseconds: 240));
      expect(OroMotion.hero, const Duration(milliseconds: 520));
      expect(OroMotion.standard, Curves.easeOutCubic);
    });

    testWidgets('OroPressable triggers onTap callback and renders child',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OroPressable(
              onTap: () => tapped = true,
              child: const Text('Press Me'),
            ),
          ),
        ),
      );

      expect(find.text('Press Me'), findsOneWidget);
      await tester.tap(find.text('Press Me'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });
}
