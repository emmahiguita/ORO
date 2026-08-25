import 'package:flutter/material.dart';

/// Shared, theme-aware discount badge widget for ORO.
///
/// Consolidates [widgets/home/discountbadge.dart] and
/// [widgets/items/discountbadge.dart] into a single canonical source.
///
/// Usage variants:
///   - [OroDiscountBadge.compact]  → used on home grid cards (small, tight)
///   - [OroDiscountBadge.pill]     → used on item-detail overlay (larger pill)
class OroDiscountBadge extends StatelessWidget {
  /// Discount percentage as a double (e.g. 15.0 → "−15%").
  final double percentage;

  /// Compact style (home grid): smaller padding, rounded-rect.
  final bool compact;

  const OroDiscountBadge({
    super.key,
    required this.percentage,
    this.compact = false,
  });

  /// Named constructor for the compact home-grid variant.
  const OroDiscountBadge.compact({
    super.key,
    required this.percentage,
  }) : compact = true;

  /// Named constructor for the detail-screen pill variant.
  const OroDiscountBadge.pill({
    super.key,
    required this.percentage,
  }) : compact = false;

  @override
  Widget build(BuildContext context) {
    final pct = percentage.round();
    return Container(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(compact ? 10 : 20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withValues(alpha: 0.35),
            blurRadius: compact ? 6 : 8,
            offset: Offset(0, compact ? 2 : 4),
          ),
        ],
      ),
      child: Text(
        '−$pct%',
        style: TextStyle(
          color: Colors.white,
          fontSize: compact ? 10 : 12,
          fontWeight: FontWeight.w800,
          letterSpacing: compact ? 0.4 : 0.2,
        ),
      ),
    );
  }
}
