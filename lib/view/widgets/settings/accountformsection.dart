import 'package:flutter/material.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/view/widgets/admin/accounttextfield.dart';

class AccountFormSection extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;
  const AccountFormSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 5))
        ],
      ),
      child: Form(
        key: controller.globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información de la cuenta',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            AccountTextField(
                controller: controller.username,
                label: 'Usuario',
                icon: Icons.person_outline_rounded),
            const SizedBox(height: 16),
            AccountTextField(
                controller: controller.email,
                label: 'Correo electrónico',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            AccountTextField(
                controller: controller.phoneNumber,
                label: 'Teléfono',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 24),
            Text('Seguridad',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
                'Para cambiar tu correo o contraseña debes confirmar tu contraseña actual.',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            AccountTextField(
                controller: controller.currentPassword,
                label: 'Contraseña actual',
                icon: Icons.lock_outline_rounded,
                isPassword: true),
            const SizedBox(height: 16),
            AccountTextField(
                controller: controller.newPassword,
                label: 'Nueva contraseña (opcional)',
                icon: Icons.password_rounded,
                isPassword: true),
          ],
        ),
      ),
    );
  }
}
