import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/localization/changelocale.dart';

class DraggableVerificationPrompt extends StatefulWidget {
  const DraggableVerificationPrompt({super.key});

  @override
  State<DraggableVerificationPrompt> createState() =>
      _DraggableVerificationPromptState();
}

class _DraggableVerificationPromptState
    extends State<DraggableVerificationPrompt> with TickerProviderStateMixin {
  double _left = 20;
  double _top = 100;
  bool _isDragging = false;
  bool _isExpanded = false;

  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late AnimationController _glowController;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _glowAnimation;

  static const Color primaryColor = Color(0xffa43068);
  static const Color primaryLight = Color(0xffb84c7a);
  static const Color backgroundDark = Color(0xff1a0f14);
  static const Color backgroundMedium = Color(0xff2d1a23);
  static const Color backgroundLight = Color(0xff3d2430);

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: -350.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation.addListener(() {
      if (_slideController.isAnimating && !_isDragging) {
        setState(() {
          _left = _slideAnimation.value;
        });
      }
    });

    _slideController.forward();
    _startPulseAnimation();
    _startShimmerAnimation();
    _startGlowAnimation();
  }

  void _startPulseAnimation() {
    _pulseController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted && _pulseController.isAnimating) {
        _pulseController.stop();
        _pulseController.reset();
      }
    });
  }

  void _startShimmerAnimation() {
    _shimmerController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 12), () {
      if (mounted && _shimmerController.isAnimating) {
        _shimmerController.stop();
      }
    });
  }

  void _startGlowAnimation() {
    _glowController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted && _glowController.isAnimating) {
        _glowController.stop();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: Listenable.merge(
          [_pulseAnimation, _shimmerAnimation, _glowAnimation]),
      builder: (context, child) {
        return Positioned(
          left: _left,
          top: _top,
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _isDragging = true;
                });
                if (_pulseController.isAnimating) {
                  _pulseController.stop();
                  _pulseController.reset();
                }
                if (_shimmerController.isAnimating) {
                  _shimmerController.stop();
                }
                if (_glowController.isAnimating) {
                  _glowController.stop();
                }
              },
              onPanUpdate: (details) {
                setState(() {
                  _left += details.delta.dx;
                  _top += details.delta.dy;

                  final screenWidth = MediaQuery.of(context).size.width;
                  final maxWidth = (screenWidth * 0.9).clamp(280.0, 320.0);
                  final widgetHeight = _isExpanded ? 120.0 : 80.0;

                  _left = _left.clamp(0.0, screenSize.width - maxWidth);
                  _top = _top.clamp(0.0, screenSize.height - widgetHeight);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _isDragging = false;
                });
              },
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: _buildVerificationPrompt(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerificationPrompt(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = (screenWidth * 0.9).clamp(280.0, 320.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      width: maxWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundDark,
            backgroundMedium,
            backgroundLight,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 32,
            offset: const Offset(0, 16),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.15 * _glowAnimation.value),
            blurRadius: 40,
            offset: const Offset(0, 0),
            spreadRadius: 4,
          ),
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withValues(alpha: 0.08),
                      primaryColor.withValues(alpha: 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_shimmerController.isAnimating)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + _shimmerAnimation.value, -1.0),
                      end: Alignment(1.0 + _shimmerAnimation.value, 1.0),
                      colors: [
                        Colors.transparent,
                        primaryColor.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: primaryColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.drag_indicator_rounded,
                      color: primaryColor.withValues(alpha: 0.6),
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor,
                          primaryLight,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.verified_user_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account Verification',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.2,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFF6B6B).withValues(alpha: 0.2),
                                const Color(0xFFFF4757).withValues(alpha: 0.3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFF6B6B)
                                  .withValues(alpha: 0.4),
                              width: 0.5,
                            ),
                          ),
                          child: const Text(
                            'REQUIRED',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFF6B6B),
                              letterSpacing: 0.5,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        if (_isExpanded) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Complete verification to be able to place orders.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.7),
                              height: 1.3,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: primaryColor.withValues(alpha: 0.8),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                height: _isExpanded ? 60 : 0,
                child: AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  primaryColor,
                                  primaryLight,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () => Get.toNamed(
                                Approutes.verifyCodeSignUp,
                                arguments: {
                                  'email': Get.find<Localecontroller>()
                                      .service
                                      .sharedPreferences
                                      .getString("email"),
                                  'setting': true,
                                },
                              ),
                              icon: const Icon(
                                Icons.verified_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              label: const Text(
                                'Verify Now',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: primaryColor.withValues(alpha: 0.25),
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _slideController.reverse();
                                });
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: Text(
                                'Later',
                                style: TextStyle(
                                  color: primaryColor.withValues(alpha: 0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
