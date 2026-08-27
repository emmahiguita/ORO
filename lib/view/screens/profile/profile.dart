import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/profile/profilecontroller.dart';
import 'package:oro/core/design/oro_colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControllerImp>(
      init: ProfileControllerImp(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Mi cuenta',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Actualizar',
                      onPressed: controller.getTotalOrdersCount,
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _IdentityCard(controller: controller),
                const SizedBox(height: 16),
                _OrdersSummary(controller: controller),
                const SizedBox(height: 16),
                _OrderAction(
                  icon: Icons.local_shipping_outlined,
                  title: 'Pedidos en curso',
                  subtitle: 'Revisa preparación, envío y entrega',
                  onTap: controller.goToUnDeliverdOrders,
                ),
                const SizedBox(height: 10),
                _OrderAction(
                  icon: Icons.receipt_long_outlined,
                  title: 'Historial de pedidos',
                  subtitle: 'Compras anteriores y detalles',
                  onTap: controller.goToArchivedOrder,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.controller});

  final ProfileControllerImp controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        controller.pfp != null && controller.pfp!.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: OroColors.forestSoft,
              shape: BoxShape.circle,
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: .45),
                width: 2,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasImage
                ? CachedNetworkImage(
                    imageUrl: '${AppLink.pfpimage}${controller.pfp}',
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const _ProfileFallback(),
                  )
                : const _ProfileFallback(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        controller.username?.trim().isNotEmpty == true
                            ? controller.username!.trim()
                            : 'Usuario ORO',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    if (controller.approve == true) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified_rounded,
                        color: OroColors.forest,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                if (controller.email?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 5),
                  Text(
                    controller.email!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                if (controller.number?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 3),
                  Text(
                    controller.number!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileFallback extends StatelessWidget {
  const _ProfileFallback();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.person_outline_rounded,
        size: 32,
        color: OroColors.forest,
      ),
    );
  }
}

class _OrdersSummary extends StatelessWidget {
  const _OrdersSummary({required this.controller});

  final ProfileControllerImp controller;

  int get count {
    if (controller.data.isEmpty) return 0;
    final first = controller.data.first;
    if (first is Map) {
      final raw = first['orders_count'] ?? first['count'] ?? first['total'];
      return int.tryParse('$raw') ?? 0;
    }
    return int.tryParse('$first') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: OroColors.heroGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: OroColors.accentGoldSoft,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Compras realizadas',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

class _OrderAction extends StatelessWidget {
  const _OrderAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: OroColors.forestSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: OroColors.forest, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: OroColors.textMutedLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
