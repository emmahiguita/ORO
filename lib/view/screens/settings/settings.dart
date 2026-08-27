import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/setting/settingcontroller.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/design/oro_colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingControllerImp>(
      init: SettingControllerImp(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
              children: [
                Text(
                  'Ajustes',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Controla tu experiencia ORO.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: .56),
                      ),
                ),
                const SizedBox(height: 28),
                const _SectionLabel('Preferencias'),
                const SizedBox(height: 10),
                _SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notificaciones',
                  subtitle: 'Alertas de pedidos, novedades y promociones',
                  trailing: Switch.adaptive(
                    value: controller.isNotificationEnabled == true,
                    onChanged: (_) => controller.disableNotification(),
                  ),
                ),
                const SizedBox(height: 8),
                _SettingsTile(
                  icon: Icons.language_rounded,
                  title: 'Idioma',
                  subtitle: 'Español, English o العربية',
                  onTap: controller.changeLanguages,
                ),
                const SizedBox(height: 28),
                const _SectionLabel('Cuenta'),
                const SizedBox(height: 10),
                if (controller.isApprove != true) ...[
                  _SettingsTile(
                    icon: Icons.verified_outlined,
                    title: 'Verificar cuenta',
                    subtitle: 'Completa la verificación de tu perfil',
                    onTap: controller.goToVerify,
                    accent: OroColors.accentGold,
                  ),
                  const SizedBox(height: 8),
                ],
                _SettingsTile(
                  icon: Icons.star_outline_rounded,
                  title: 'Tus valoraciones',
                  subtitle: 'Gestiona las reseñas que has publicado',
                  onTap: controller.goToAllRating,
                ),
                const SizedBox(height: 8),
                _SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Direcciones',
                  subtitle: 'Entrega, domicilio y ubicaciones guardadas',
                  onTap: controller.goToAddress,
                ),
                const SizedBox(height: 8),
                _SettingsTile(
                  icon: Icons.edit_outlined,
                  title: 'Editar perfil',
                  subtitle: 'Nombre, teléfono y datos de tu cuenta',
                  onTap: controller.goToUpdateAccountInformation,
                ),
                const SizedBox(height: 28),
                const _SectionLabel('ORO'),
                const SizedBox(height: 10),
                _SettingsTile(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Presentación ORO',
                  subtitle: 'Volver a ver la experiencia de bienvenida',
                  onTap: () => Get.toNamed(Approutes.introVideo),
                ),
                const SizedBox(height: 8),
                _SettingsTile(
                  icon: Icons.support_agent_rounded,
                  title: 'Soporte',
                  subtitle: 'Habla con soporte mediante WhatsApp',
                  onTap: () => controller.contactus(0),
                ),
                const SizedBox(height: 28),
                OutlinedButton.icon(
                  onPressed: controller.logout,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Cerrar sesión'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OroColors.error,
                    side: BorderSide(
                      color: OroColors.error.withValues(alpha: .28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: OroColors.forest,
            letterSpacing: 1.15,
            fontWeight: FontWeight.w900,
          ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.accent,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = accent ?? OroColors.forest;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  size: 21,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 13),
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
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: .32),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
