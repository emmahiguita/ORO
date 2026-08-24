import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/services/services.dart';
import 'package:video_player/video_player.dart';

class OroIntroVideoScreen extends StatefulWidget {
  final bool canDismiss;
  final VoidCallback? onFinished;

  const OroIntroVideoScreen({
    super.key,
    this.canDismiss = false,
    this.onFinished,
  });

  @override
  State<OroIntroVideoScreen> createState() => _OroIntroVideoScreenState();
}

class _OroIntroVideoScreenState extends State<OroIntroVideoScreen>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _navigated = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _initVideoPlayer();
  }

  Future<void> _initVideoPlayer() async {
    try {
      _videoController =
          VideoPlayerController.asset('assets/videos/inicio1.mp4');
      await _videoController!.initialize();
      _videoController!.setLooping(false);
      _videoController!.setVolume(1.0);

      _videoController!.addListener(() {
        if (_videoController != null &&
            _videoController!.value.isInitialized &&
            _videoController!.value.position >=
                _videoController!.value.duration &&
            !_videoController!.value.isPlaying &&
            !_navigated &&
            !widget.canDismiss) {
          _proceedToApp();
        }
      });

      await _videoController!.play();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _fadeController.forward();
      }
    } catch (e) {
      debugPrint('OroIntroVideo error: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
        _fadeController.forward();
      }
    }
  }

  void _proceedToApp() {
    if (_navigated) return;
    _navigated = true;

    if (widget.onFinished != null) {
      widget.onFinished!();
      return;
    }

    if (widget.canDismiss) {
      Get.back();
      return;
    }

    final services = Get.isRegistered<Services>() ? Get.find<Services>() : null;
    final step = services?.sharedPreferences.getString('step');

    if (step == '2') {
      Get.offAllNamed(Approutes.homescreen);
    } else if (step == '3') {
      Get.offAllNamed(Approutes.deliveryHome);
    } else if (step == '4') {
      Get.offAllNamed(Approutes.adminHome);
    } else if (step == '1') {
      Get.offAllNamed(Approutes.login);
    } else {
      Get.offAllNamed(Approutes.login);
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0B0B0D),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0B0D),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Video or luxury fallback background
            if (_isInitialized && _videoController != null)
              Center(
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
              )
            else if (_hasError)
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 1.2,
                    colors: [
                      Color(0xFF2A1526),
                      Color(0xFF0B0B0D),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Appcolor.berry.withValues(alpha: 0.2),
                          border: Border.all(
                            color: const Color(0xFFE5C07B).withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 48,
                          color: Color(0xFFE5C07B),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "ORO",
                        style: TextStyle(
                          color: Color(0xFFE5C07B),
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Experiencia de Comercio Premium",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE5C07B),
                  strokeWidth: 2,
                ),
              ),

            // Screen tap to skip/advance
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _proceedToApp,
              child: const SizedBox.expand(),
            ),
          ],
        ),
      ),
    );
  }
}
