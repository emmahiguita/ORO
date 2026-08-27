import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/design/oro_colors.dart';

/// Luxury Error Widget fallback for Flutter UI rendering errors.
/// Replaces the default Red Screen with a brand-aligned, graceful UI.
class OroErrorFallback extends StatelessWidget {
  final FlutterErrorDetails? details;

  const OroErrorFallback({super.key, this.details});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? OroColors.ink : OroColors.canvas,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: isDark
                    ? OroColors.surfaceDarkElevated
                    : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? OroColors.borderDark
                      : OroColors.borderLight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isDark
                          ? OroColors.surfaceDark
                          : const Color(0xFFF6F4EE),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_outlined,
                      size: 28,
                      color: OroColors.accentGold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Experiencia ORO',
                    style: TextStyle(
                      fontFamily: 'Sw',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : OroColors.ink,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estamos optimizando la visualización de este elemento. Puedes continuar navegando con total normalidad.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: isDark
                          ? OroColors.textMutedDark
                          : OroColors.textMutedLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (Get.currentRoute.isNotEmpty &&
                            Get.currentRoute != Approutes.homescreen) {
                          Get.offAllNamed(Approutes.homescreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: OroColors.forest,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Volver al inicio',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (kDebugMode && details != null) ...[
                    const SizedBox(height: 16),
                    ExpansionTile(
                      title: const Text(
                        'Detalles técnicos (Debug)',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            details!.exceptionAsString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
