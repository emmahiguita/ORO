import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_pressable.dart';

class Discountcard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: .96, end: 1),
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
        builder: (context, scale, child) => Transform.scale(
          scale: scale,
          child: child,
        ),
        child: AspectRatio(
          aspectRatio: 1.58,
          child: OroPressable(
            onTap: onTap,
            pressedScale: .98,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Appcolor.ink,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: OroColors.accentGold.withValues(alpha: .68),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3D000000),
                    blurRadius: 28,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image ??
                            const AssetImage('images/oro_luxury_hero_3d.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xF007120E),
                          Color(0xA007120E),
                          Color(0x2607120E),
                        ],
                        stops: [0, .55, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    left: 20,
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF3D787),
                                Color(0xFF9E7024),
                                Color(0xFFE7BF62),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'ORO  ·  PRIVILEGIO',
                          style: TextStyle(
                            color: Color(0xFFF8E7B0),
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withValues(alpha: .26)),
                            borderRadius: BorderRadius.circular(999),
                            color: Colors.black.withValues(alpha: .18),
                          ),
                          child: Text(
                            'premium_selection'.tr,
                            style: const TextStyle(
                              color: Appcolor.accentGoldSoft,
                              fontSize: 10,
                              letterSpacing: 1.25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                height: 1.05,
                              ),
                        ),
                        const SizedBox(height: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 206),
                          child: Text(
                            content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: .78),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color:
                                  OroColors.accentGold.withValues(alpha: .34),
                            ),
                            color: Colors.white.withValues(alpha: .06),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'explore_collection'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded,
                                  color: Appcolor.accentGold, size: 17),
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
  }
}
