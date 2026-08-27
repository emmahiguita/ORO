import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_colors.dart';

class Discountcard extends StatelessWidget {
  final String title;
  final String content;
  final ImageProvider<Object>? image;

  const Discountcard({
    super.key,
    required this.title,
    required this.content,
    this.image,
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
        child: Container(
          height: 260,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Appcolor.ink,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: OroColors.accentGold.withValues(alpha: .72),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x34000000),
                blurRadius: 36,
                offset: Offset(0, 18),
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
              Padding(
                padding: const EdgeInsets.all(24),
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
                    const SizedBox(height: 10),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                height: 1.05,
                              ),
                    ),
                    const SizedBox(height: 7),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 230),
                      child: Text(
                        content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: .80),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: OroColors.accentGold.withValues(alpha: .34),
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
    );
  }
}
