import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/services/services.dart';
import 'package:video_player/video_player.dart';

class OroIntroVideoScreen extends StatefulWidget {
  /// When true the screen was pushed on top of an existing route (re-play).
  /// Tapping anywhere or the video ending will simply pop it.
  final bool canDismiss;

  /// Optional override callback executed instead of session-aware routing.
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
  VideoPlayerController? _vc;
  bool _ready = false;
  bool _hasError = false;
  bool _navigated = false;

  // Overlay fade — controls the black fade-out before navigation.
  late final AnimationController _overlayCtrl;
  late final Animation<double> _screenFade; // 0 = black, 1 = video visible
  late final Animation<double> _overlayFade; // 1 = black overlay, 0 = clear

  // Skip button visibility
  bool _showSkip = false;
  Timer? _skipTimer;

  @override
  void initState() {
    super.initState();

    _overlayCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Video fades IN from black
    _screenFade = CurvedAnimation(parent: _overlayCtrl, curve: Curves.easeIn);

    // Overlay used for the fade-OUT to black before navigation
    _overlayFade = ReverseAnimation(
      CurvedAnimation(parent: _overlayCtrl, curve: Curves.easeIn),
    );

    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      _vc = VideoPlayerController.asset('assets/videos/inicio1.mp4');
      await _vc!.initialize();
      _vc!.setLooping(false);
      _vc!.setVolume(0.0); // Muted — polite default for an intro splash.

      _vc!.addListener(_onVideoUpdate);
      await _vc!.play();

      if (mounted) {
        setState(() => _ready = true);
        _overlayCtrl.forward(); // Fade video in from black

        // Show the skip button after 1.5 s
        _skipTimer = Timer(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _showSkip = true);
        });
      }
    } catch (e) {
      debugPrint('OroIntroVideo init error: $e');
      if (mounted) {
        setState(() => _hasError = true);
        _overlayCtrl.forward();
        // Auto-navigate after 2 s when there is no video
        Timer(const Duration(seconds: 2), _proceed);
      }
    }
  }

  void _onVideoUpdate() {
    final vc = _vc;
    if (vc == null || !vc.value.isInitialized) return;
    final pos = vc.value.position;
    final dur = vc.value.duration;
    // Navigate when video reaches the end (within 80 ms tolerance)
    if (dur.inMilliseconds > 0 &&
        pos >= dur - const Duration(milliseconds: 80) &&
        !vc.value.isPlaying &&
        !_navigated) {
      _proceed();
    }
  }

  /// Fade to black then navigate.
  void _proceed() {
    if (_navigated) return;
    _navigated = true;
    _skipTimer?.cancel();

    // Fade OUT to black over 400 ms, then navigate.
    _overlayCtrl.reverse(from: _overlayCtrl.value).then((_) {
      if (!mounted) return;
      _navigate();
    });
  }

  void _navigate() {
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

    switch (step) {
      case '2':
        Get.offAllNamed(Approutes.homescreen);
      case '3':
        Get.offAllNamed(Approutes.deliveryHome);
      case '4':
        Get.offAllNamed(Approutes.adminHome);
      default:
        Get.offAllNamed(Approutes.login);
    }
  }

  @override
  void dispose() {
    _skipTimer?.cancel();
    _vc?.removeListener(_onVideoUpdate);
    _vc?.dispose();
    _overlayCtrl.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _proceed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Video layer ──────────────────────────────────────────
              if (_ready && _vc != null)
                FadeTransition(
                  opacity: _screenFade,
                  child: _VideoFill(controller: _vc!),
                )
              else if (_hasError)
                _FallbackLogo(fade: _screenFade)
              else
                const _LoadingIndicator(),

              // ── Fade-to-black overlay (for exit animation) ───────────
              FadeTransition(
                opacity: _overlayFade,
                child: Container(color: Colors.black),
              ),

              // ── Logo watermark (bottom-centre) ────────────────────────
              if (_ready || _hasError)
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 32,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _screenFade,
                    child: const _OroWatermark(),
                  ),
                ),

              // ── Skip button (top-right) ───────────────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                top: MediaQuery.of(context).padding.top + 12,
                right: _showSkip ? 16 : -120,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showSkip ? 1.0 : 0.0,
                  child: _SkipButton(onSkip: _proceed),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

/// Fills the entire screen with the video, clipping to cover (like BoxFit.cover).
class _VideoFill extends StatelessWidget {
  final VideoPlayerController controller;
  const _VideoFill({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}

/// Gold logo fallback shown when video fails to load.
class _FallbackLogo extends StatelessWidget {
  final Animation<double> fade;
  const _FallbackLogo({required this.fade});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.25),
            radius: 1.3,
            colors: [Color(0xFF1A120E), Color(0xFF0B0B0D)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GoldCircle(),
              SizedBox(height: 28),
              Text(
                'ORO',
                style: TextStyle(
                  color: Color(0xFFC89B3C),
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Experiencia de Comercio Premium',
                style: TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldCircle extends StatelessWidget {
  const _GoldCircle();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFC89B3C),
          width: 1.5,
        ),
        color: const Color(0x22C89B3C),
      ),
      child: const Icon(
        Icons.play_circle_outline_rounded,
        size: 52,
        color: Color(0xFFC89B3C),
      ),
    );
  }
}

/// Small ORO wordmark watermark at the bottom.
class _OroWatermark extends StatelessWidget {
  const _OroWatermark();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'ORO',
          style: TextStyle(
            color: Color(0xCCC89B3C),
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Commerce',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 10,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

/// Initial loading indicator (while video is initializing).
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          color: Color(0xFFC89B3C),
          strokeWidth: 1.8,
        ),
      ),
    );
  }
}

/// Pill-shaped skip button.
class _SkipButton extends StatelessWidget {
  final VoidCallback onSkip;
  const _SkipButton({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSkip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Omitir',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.skip_next_rounded, color: Colors.white, size: 15),
          ],
        ),
      ),
    );
  }
}
