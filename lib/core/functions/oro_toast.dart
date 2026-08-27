import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

/// Notificaciones y Toasts Premium de la marca ORO
class OroToast {
  static void show({
    required String title,
    required String message,
    IconData icon = Icons.check_circle_rounded,
    Color? iconColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    try {
      OroMotion.selectionHaptic();
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        duration: duration,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderRadius: 18,
        backgroundColor: OroColors.nightBlue.withValues(alpha: 0.94),
        colorText: Colors.white,
        borderWidth: 1.2,
        borderColor: OroColors.accentGold.withValues(alpha: 0.45),
        boxShadows: [
          BoxShadow(
            color: OroColors.accentGold.withValues(alpha: 0.20),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          const BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        icon: Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (iconColor ?? OroColors.accentGold).withValues(alpha: 0.15),
            border: Border.all(
              color: (iconColor ?? OroColors.accentGold).withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? OroColors.accentGold,
          ),
        ),
        titleText: Text(
          title,
          style: const TextStyle(
            color: OroColors.accentGold,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } catch (_) {
      // Fallback seguro silencioso
    }
  }

  static void favoriteAdded() {
    show(
      title: 'Añadido a Favoritos',
      message: 'Este artículo se guardó en tu lista exclusiva.',
      icon: Icons.favorite_rounded,
      iconColor: const Color(0xFFE53935),
    );
  }

  static void favoriteRemoved() {
    show(
      title: 'Eliminado de Favoritos',
      message: 'El artículo ha sido removido de tu lista.',
      icon: Icons.favorite_border_rounded,
      iconColor: OroColors.accentGold,
    );
  }
}
