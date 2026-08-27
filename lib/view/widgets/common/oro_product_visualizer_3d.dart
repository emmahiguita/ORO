import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

/// Visualizador 3D / 360° Interactivo Hiperrealista ORO
/// Implementa rotación multi-ángulo con perspectiva tridimensional,
/// destello especular dorado dinámico, sombra de contacto física y retorno con resorte M3E.
class OroProductVisualizer3D extends StatefulWidget {
  final String? imageUrl;
  final String productName;
  final String? categoryName;
  final BoxFit fit;
  final int memCacheWidth;
  final bool enableInteractive360;
  final String? heroTag;

  const OroProductVisualizer3D({
    super.key,
    required this.imageUrl,
    required this.productName,
    this.categoryName,
    this.fit = BoxFit.contain,
    this.memCacheWidth = 480,
    this.enableInteractive360 = true,
    this.heroTag,
  });

  @override
  State<OroProductVisualizer3D> createState() => _OroProductVisualizer3DState();
}

class _OroProductVisualizer3DState extends State<OroProductVisualizer3D>
    with SingleTickerProviderStateMixin {
  late final AnimationController _springController;
  late Animation<double> _springAnimation;

  double _rotationAngle = 0.0; // En radianes (-0.55 a +0.55)
  int _lastHapticStep = 0;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _springAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_springController);
    _springController.addListener(() {
      if (_springController.isAnimating) {
        setState(() {
          _rotationAngle = _springAnimation.value;
        });
      }
    });
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!widget.enableInteractive360) return;

    if (_springController.isAnimating) {
      _springController.stop();
    }

    setState(() {
      // Sensibilidad de rotación
      _rotationAngle += details.primaryDelta! * 0.012;
      _rotationAngle = _rotationAngle.clamp(-0.65, 0.65);

      // Feedback háptico por pasos de ángulo (ticks discretos)
      final currentStep = (_rotationAngle * 10).round();
      if (currentStep != _lastHapticStep) {
        _lastHapticStep = currentStep;
        OroMotion.selectionHaptic();
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!widget.enableInteractive360) return;

    final startAngle = _rotationAngle;
    _springAnimation = Tween<double>(begin: startAngle, end: 0.0).animate(
      CurvedAnimation(
        parent: _springController,
        curve: const SpringCurve(),
      ),
    );

    _springController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final imageCore = SizedBox.expand(
      child: OroProductImage(
        imageUrl: widget.imageUrl,
        productName: widget.productName,
        categoryName: widget.categoryName,
        fit: widget.fit,
        memCacheWidth: widget.memCacheWidth,
        showFallbackLabel: false,
      ),
    );

    final heroWrappedImage = widget.heroTag != null
        ? Hero(tag: widget.heroTag!, child: imageCore)
        : imageCore;

    // Matriz de perspectiva 3D (Cámara con profundidad Z y rotación Y)
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.0018) // Profundidad focal de cámara
      ..rotateY(_rotationAngle)
      ..rotateZ(_rotationAngle * -0.05); // Inclinación sutil de pose

    // Posición del reflejo especular dorado (0.0 a 1.0)
    final sheenAlignmentX = (_rotationAngle / 0.65).clamp(-1.0, 1.0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          // ── 1. Sombra de Contacto Física con perspectiva ────────────────
          Positioned(
            bottom: 4,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              width: 80 + (math.cos(_rotationAngle) * 32),
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.black87)
                        .withValues(alpha: 0.28 * math.cos(_rotationAngle)),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(_rotationAngle * 12, 2),
                  ),
                  BoxShadow(
                    color: OroColors.accentGold.withValues(
                        alpha: 0.14 * (1.0 - _rotationAngle.abs())),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          // ── 2. Objeto 3D con Transformación de Matriz Perspectiva ────────
          Transform(
            alignment: Alignment.center,
            transform: matrix,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                heroWrappedImage,

                // ── 3. Destello Especular Dorado Reactivo (Sheen Shader) ───
                if (_rotationAngle.abs() > 0.04)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(sheenAlignmentX - 0.45, -1.0),
                              end: Alignment(sheenAlignmentX + 0.45, 1.0),
                              stops: const [0.0, 0.48, 0.52, 1.0],
                              colors: [
                                Colors.transparent,
                                OroColors.accentGold.withValues(alpha: 0.25),
                                Colors.white.withValues(alpha: 0.35),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── 4. Indicador Discreto 360° ──────────────────────────────────
          if (widget.enableInteractive360)
            Positioned(
              bottom: 6,
              right: 6,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _rotationAngle.abs() > 0.05 ? 0.9 : 0.45,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: OroColors.nightBlue.withValues(alpha: 0.70),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: OroColors.accentGold.withValues(alpha: 0.35),
                      width: 0.8,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.rotate_right_rounded,
                        size: 9,
                        color: OroColors.accentGold,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '360°',
                        style: TextStyle(
                          color: OroColors.accentGold,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Curva de resorte físico Material 3 Expressive
class SpringCurve extends Curve {
  const SpringCurve();

  @override
  double transformInternal(double t) {
    // Simulación de amortiguamiento subcrítico f(t) = 1 - e^(-6t) * cos(8t)
    return 1.0 - math.exp(-6.0 * t) * math.cos(8.0 * t);
  }
}
