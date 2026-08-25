import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oro/data/model/couponmodel.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/coupon/admincouponcontroller.dart';

class CouponImageGenerator {
  static Future<File?> generateCouponImage(
      CouponModel couponModel, Color color) async {
    try {
      // Request storage permission
      await _requestStoragePermission();

      // Create a custom painter for the coupon
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Define dimensions
      const double width = 400;
      const double height = 200;

      // Draw the coupon
      await _drawCoupon(canvas, couponModel, width, height, color);

      // Convert to image
      final picture = recorder.endRecording();
      final img = await picture.toImage(width.toInt(), height.toInt());
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save to file
      final directory = await getExternalStorageDirectory();
      final fileName =
          'coupon_${couponModel.couponCode}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${directory!.path}/$fileName');
      await file.writeAsBytes(pngBytes);

      return file;
    } catch (e) {
      debugPrint('Error generating coupon image: $e');
      return null;
    }
  }

  static Future<void> _drawCoupon(Canvas canvas, CouponModel couponModel,
      double width, double height, Color color) async {
    final AdminCouponControllerImp controller =
        Get.find<AdminCouponControllerImp>();

    // Coupon gradient background (main coupon card only)
    final couponRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(12),
    );

    // Create gradient effect
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color,
          color.withValues(alpha: 0.8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawRRect(couponRect, gradientPaint);

    // Coupon code
    await _drawText(
      canvas,
      couponModel.couponCode ?? 'COUPON',
      Offset(width / 2, height / 2 - 30),
      const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      center: true,
    );

    // Discount percentage
    await _drawText(
      canvas,
      '${couponModel.couponDiscount ?? 0}% OFF',
      Offset(width / 2, height / 2),
      const TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      center: true,
    );

    // Expiry date
    await _drawText(
      canvas,
      'Expires: ${controller.formatDisplayDate(couponModel.couponExpirydate)}',
      Offset(width / 2, height / 2 + 30),
      const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      ),
      center: true,
    );
  }

  static Future<void> _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    TextStyle style, {
    bool center = false,
  }) async {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    Offset drawOffset = offset;
    if (center) {
      drawOffset = Offset(
        offset.dx - (textPainter.width / 2),
        offset.dy - (textPainter.height / 2),
      );
    }

    textPainter.paint(canvas, drawOffset);
  }

  static Future<void> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final permission = await Permission.storage.request();
      if (permission != PermissionStatus.granted) {
        final managePermission =
            await Permission.manageExternalStorage.request();
        if (managePermission != PermissionStatus.granted) {
          Get.snackbar(
            "Failed",
            "Storage permission denied",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.error, color: Colors.white),
            duration: const Duration(seconds: 4),
          );
        }
      }
    }
  }
}
