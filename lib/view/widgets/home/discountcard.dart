import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class Discountcard extends StatefulWidget {
  final String title;
  final String content;
  final ImageProvider<Object>? image;
  final VoidCallback? onTap;

  const Discountcard({
    super.key,
    required this.title,
    required this.content,
    this.image,
    this.onTap,
  });

  @override
  State<Discountcard> createState() => _DiscountcardState();
}

class _DiscountcardState extends State<Discountcard> {
  late final PageController _pageCtrl;
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  final List<Map<String, String>> _bannerItems = [
    {
      'badge': 'PREMIUM 2026',
      'title': 'Colección Exclusiva ORO',
      'subtitle': 'Joyería fina y piezas de alta gama con entrega prioritaria.',
      'tag': 'HASTA 30% OFF',
      'image': 'images/promo_banner_1.jpg',
    },
    {
      'badge': 'OFERTA ESPECIAL',
      'title': 'Novedades de Temporada',
      'subtitle': 'Collares, anillos y pulseras en oro con brillo eterno.',
      'tag': 'DESCUENTO FLASH',
      'image': 'images/promo_banner_2.jpg',
    },
    {
      'badge': 'LUXURY SELECTION',
      'title': 'Edición Limitada ORO',
      'subtitle': 'Autenticidad comprobada y garantía de por vida.',
      'tag': 'EXCLUSIVO APPS',
      'image': 'images/promo_banner_3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(viewportFraction: 0.92, initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageCtrl.hasClients) {
        _currentPage = (_currentPage + 1) % _bannerItems.length;
        _pageCtrl.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // ── Carrusel Publicitario Hiper-Realista ORO ───────────────────────
        SizedBox(
          height: 165,
          child: PageView.builder(
            controller: _pageCtrl,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: _bannerItems.length,
            itemBuilder: (context, index) {
              final item = _bannerItems[index];
              final titleText = index == 0 && widget.title.isNotEmpty
                  ? widget.title
                  : item['title']!;
              final subtitleText = index == 0 && widget.content.isNotEmpty
                  ? widget.content
                  : item['subtitle']!;
              final imagePath = item['image']!;

              return AnimatedBuilder(
                animation: _pageCtrl,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageCtrl.position.haveDimensions) {
                    value = (_pageCtrl.page ?? 0) - index;
                    value = (1 - (value.abs() * 0.18)).clamp(0.82, 1.0);
                  }
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        await OroMotion.selectionHaptic();
                        widget.onTap?.call();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: OroColors.accentGold.withValues(alpha: 0.45),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: OroColors.accentGold.withValues(
                                  alpha: isDark ? 0.18 : 0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(
                                  alpha: isDark ? 0.40 : 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // 1. Imagen Publicitaria de Alta Resolución
                            Positioned.fill(
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                alignment: Alignment.centerRight,
                                errorBuilder: (_, __, ___) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: index == 0
                                          ? const [Color(0xFF073827), Color(0xFF15563D)]
                                          : index == 1
                                              ? const [Color(0xFF2E1C0A), Color(0xFF6B481B)]
                                              : const [Color(0xFF121B24), Color(0xFF1E3547)],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 2. Degradado Protector & Glass Scrim para Legibilidad
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: const [0.0, 0.45, 0.72, 1.0],
                                    colors: [
                                      OroColors.nightBlue.withValues(alpha: 0.95),
                                      OroColors.nightBlue.withValues(alpha: 0.82),
                                      OroColors.nightBlue.withValues(alpha: 0.35),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // 3. Contenido Publicitario ORO
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Badges Superiores
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3.5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: OroColors.nightBlue
                                              .withValues(alpha: 0.70),
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          border: Border.all(
                                            color: OroColors.accentGold
                                                .withValues(alpha: 0.60),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          item['badge']!,
                                          style: const TextStyle(
                                            color: OroColors.accentGold,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: OroColors.emeraldGradient,
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          boxShadow: [
                                            BoxShadow(
                                              color: OroColors.emerald
                                                  .withValues(alpha: 0.30),
                                              blurRadius: 4,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          item['tag']!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // Título de la Promoción
                                  SizedBox(
                                    width: 210,
                                    child: Text(
                                      titleText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1.15,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.3,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 6,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  // Subtítulo descriptivo
                                  SizedBox(
                                    width: 190,
                                    child: Text(
                                      subtitleText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.88),
                                        fontSize: 10.5,
                                        height: 1.20,
                                        fontWeight: FontWeight.w500,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black45,
                                            blurRadius: 4,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Botón CTA
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: OroColors.goldGradient,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: OroColors.accentGold
                                              .withValues(alpha: 0.35),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'explore_now'.tr,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 12,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // ── Indicador de Páginas Doradas ────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerItems.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == i ? 20 : 6,
              height: 5,
              decoration: BoxDecoration(
                color: _currentPage == i
                    ? OroColors.accentGold
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.20)
                        : OroColors.borderLight),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
