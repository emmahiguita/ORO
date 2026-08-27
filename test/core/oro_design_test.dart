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

      expect(OroBreakpoints.productAspectRatio(360), 1.02);
      expect(OroBreakpoints.productAspectRatio(700), 1.08);
      expect(OroBreakpoints.productAspectRatio(900), 1.12);
      expect(OroBreakpoints.productAspectRatio(1300), 1.18);
    });

    test('OroColors primary tokens integrity', () {
      expect(OroColors.ink, const Color(0xFF101411));
      expect(OroColors.forest, const Color(0xFF0C513A));
      expect(OroColors.accentGold, const Color(0xFFB88931));
      expect(OroColors.canvas, const Color(0xFFF7F6F2));
      expect(OroColors.surface, const Color(0xFFFFFFFF));
    });

    test('OroMotion durations and curves', () {
      expect(OroMotion.fast, const Duration(milliseconds: 140));
      expect(OroMotion.medium, const Duration(milliseconds: 220));
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
