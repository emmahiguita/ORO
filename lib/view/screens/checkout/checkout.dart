import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/checkout/checkoutcontroller.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/view/screens/address/viewaddress.dart';
import 'package:oro/view/widgets/checkout/couponsection.dart';
import 'package:oro/view/widgets/checkout/deliverytype.dart';
import 'package:oro/view/widgets/checkout/itemview.dart';
import 'package:oro/view/widgets/checkout/shippingaddress.dart';
import 'package:oro/view/widgets/checkout/summaryrow.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutControllerImp());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A131C) : const Color(0xFFFAF7F2),
      body: Stack(
        children: [
          // ── Fondo de lujo Liquid Jungle ──
          Positioned.fill(
            child: Image.asset(
              'assets/images/store_liquid_jungle_background.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: isDark
                    ? OroColors.protectionGradient
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFFBF8F2).withValues(alpha: 0.88),
                          const Color(0xFFF4EDE2).withValues(alpha: 0.96),
                        ],
                      ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Barra Superior Personalizada ──
                _buildAppBar(context, isDark),

                // ── Contenido con Scroll ──
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: GetBuilder<CheckoutControllerImp>(
                        builder: (_) => ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          children: [
                            // 1. Resumen de Productos
                            _buildSectionCard(
                              context: context,
                              isDark: isDark,
                              title: 'Tu Pedido',
                              subtitle: '${controller.orderDetails.length} ${controller.orderDetails.length == 1 ? 'artículo' : 'artículos'}',
                              icon: Icons.shopping_bag_outlined,
                              child: controller.orderDetails.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Center(
                                        child: Text(
                                          'No hay artículos en tu pedido.',
                                          style: TextStyle(
                                            color: isDark
                                                ? OroColors.textSecondaryDark
                                                : OroColors.textSecondaryLight,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 146,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.orderDetails.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 10),
                                        itemBuilder: (_, index) {
                                          final item = controller.orderDetails[index];
                                          return ItemView(
                                            itemName: item.itemName ?? 'Pieza Exclusiva',
                                            itemImage: AppLink.itemimage + (item.itemImg ?? ''),
                                            itemprice: (item.itemFinalPrice ?? item.itemPrice ?? 0)
                                                .toStringAsFixed(0),
                                            itmeQuantity: '${item.countitems ?? 1}',
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 14),

                            // 2. Método de Entrega
                            _buildSectionCard(
                              context: context,
                              isDark: isDark,
                              title: 'Método de Entrega',
                              subtitle: controller.deliveryType == 0
                                  ? 'Envío asegurado a tu domicilio'
                                  : 'Retiro en boutique oficial',
                              icon: Icons.local_shipping_outlined,
                              child: DeliveryType(
                                isDelivery: controller.deliveryType == 0,
                                isPickUp: controller.deliveryType == 1,
                                onTapDelivery: () => controller.changeDeliveryType(0),
                                onTapPickUp: () => controller.changeDeliveryType(1),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // 3. Dirección de Entrega (solo si deliveryType == 0)
                            if (controller.deliveryType == 0) ...[
                              _buildSectionCard(
                                context: context,
                                isDark: isDark,
                                title: 'Dirección de Entrega',
                                icon: Icons.location_on_outlined,
                                trailing: TextButton.icon(
                                  onPressed: () async {
                                    await OroMotion.selectionHaptic();
                                    Get.to(() => const ViewAddress());
                                  },
                                  icon: const Icon(Icons.add_location_alt_rounded, size: 16),
                                  label: const Text('Administrar'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: OroColors.accentGold,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                child: controller.addresses.isEmpty
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: isDark
                                              ? Colors.white.withValues(alpha: 0.04)
                                              : Colors.black.withValues(alpha: 0.02),
                                          border: Border.all(
                                            color: isDark
                                                ? OroColors.borderDark
                                                : OroColors.borderLight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.location_off_rounded,
                                              color: OroColors.accentGold,
                                              size: 32,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'No tienes una dirección registrada',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: isDark
                                                    ? OroColors.crystalWhite
                                                    : OroColors.nightBlue,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Agrega una dirección para recibir tu pedido a domicilio.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                color: isDark
                                                    ? OroColors.textSecondaryDark
                                                    : OroColors.textSecondaryLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: controller.addresses
                                            .map(
                                              (address) => ShippingAddress(
                                                title: address.addressName ?? 'Dirección',
                                                subTitle: [
                                                  address.addressBuilding,
                                                  address.addressStreet,
                                                  address.addressBlock
                                                ]
                                                    .where((e) =>
                                                        e != null && e.trim().isNotEmpty)
                                                    .join(', '),
                                                placeName: address.addressBymap ?? '',
                                                icon: Icons.location_on_rounded,
                                                isSelected: controller.addressId ==
                                                    address.addressId,
                                                onTap: address.addressId == null
                                                    ? null
                                                    : () => controller.chooseAddressId(
                                                        address.addressId!),
                                              ),
                                            )
                                            .toList(),
                                      ),
                              ),
                              const SizedBox(height: 14),
                            ],

                            // 4. Método de Pago Seguro
                            _buildSectionCard(
                              context: context,
                              isDark: isDark,
                              title: 'Método de Pago',
                              icon: Icons.verified_user_outlined,
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF132738)
                                      : const Color(0xFFFAF6EE),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: OroColors.accentGold.withValues(alpha: 0.35),
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: OroColors.accentGold.withValues(alpha: 0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.shield_rounded,
                                        color: OroColors.accentGold,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pago Contra Entrega / Recogida',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 13,
                                              color: isDark
                                                  ? OroColors.crystalWhite
                                                  : OroColors.nightBlue,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Pagas de forma segura en efectivo o datáfono al recibir o recoger tu pedido.',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isDark
                                                  ? OroColors.accentGoldSoft
                                                  : OroColors.textSecondaryLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // 5. Cupón de Descuento
                            _buildSectionCard(
                              context: context,
                              isDark: isDark,
                              title: 'Cupón de Descuento',
                              subtitle: 'Ingresa un código promocional exclusivo',
                              icon: Icons.confirmation_number_outlined,
                              child: const CouponSection(),
                            ),
                            const SizedBox(height: 14),

                            // 6. Resumen de Compra
                            _buildSectionCard(
                              context: context,
                              isDark: isDark,
                              title: 'Resumen de Compra',
                              icon: Icons.receipt_long_outlined,
                              child: Column(
                                children: [
                                  SummaryRow(
                                    label: 'Subtotal',
                                    value: controller.formatMoney(
                                      controller.couponController.subtotal,
                                    ),
                                    isTotal: false,
                                  ),
                                  if (controller.couponController.isCouponUsed &&
                                      controller.couponController.couponList.isNotEmpty) ...[
                                    const SizedBox(height: 10),
                                    SummaryRow(
                                      label: 'Descuento Aplicado',
                                      value:
                                          '-${controller.couponController.couponList.first.couponDiscount ?? 0}%',
                                      isTotal: false,
                                    ),
                                  ],
                                  const SizedBox(height: 10),
                                  SummaryRow(
                                    label: controller.deliveryType == 0
                                        ? 'Costo de Envío'
                                        : 'Recogida en Tienda',
                                    value: controller.deliveryType == 0
                                        ? (controller.shippingFee == 0
                                            ? 'Gratis'
                                            : controller.formatMoney(controller.shippingFee))
                                        : 'Gratis',
                                    isTotal: false,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: OroColors.borderDark,
                                    ),
                                  ),
                                  SummaryRow(
                                    label: 'Total a Pagar',
                                    value: controller.formatMoney(controller.previewTotal),
                                    isTotal: true,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_rounded,
                                        size: 13,
                                        color: OroColors.accentGold,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Precios y disponibilidad verificados con garantía oficial ORO.',
                                          style: TextStyle(
                                            fontSize: 10.5,
                                            color: isDark
                                                ? OroColors.accentGoldSoft.withValues(alpha: 0.85)
                                                : OroColors.textSecondaryLight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // 7. Botón Confirmar Pedido
                            Container(
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: OroColors.emeraldGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: OroColors.emerald.withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: controller.isLoading
                                      ? null
                                      : () async {
                                          await OroMotion.selectionHaptic();
                                          controller.placeOrder();
                                        },
                                  child: Center(
                                    child: controller.isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Confirmar Pedido',
                                                style: TextStyle(
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Botón Atrás de Lujo
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              OroMotion.selectionHaptic();
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark
                    ? OroColors.nightBlue.withValues(alpha: 0.80)
                    : Colors.white.withValues(alpha: 0.90),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: OroColors.accentGold.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 17,
                color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Título Centrado y Subtítulo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finalizar Compra',
                  style: TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                    color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
                  ),
                ),
                Text(
                  'Verifica los detalles de tu pedido',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? OroColors.accentGoldSoft
                        : OroColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),

          // Badge Seguro
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: OroColors.accentGold.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: OroColors.accentGold.withValues(alpha: 0.30),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 13,
                  color: OroColors.accentGold,
                ),
                SizedBox(width: 4),
                Text(
                  '100% Seguro',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: OroColors.accentGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    String? subtitle,
    required IconData icon,
    Widget? trailing,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? OroColors.nightBlue.withValues(alpha: 0.72)
                : Colors.white.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isDark
                  ? OroColors.borderDark
                  : OroColors.borderLight,
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: OroColors.accentGold.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 16, color: OroColors.accentGold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                            color: isDark
                                ? OroColors.crystalWhite
                                : OroColors.nightBlue,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 1),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? OroColors.accentGoldSoft
                                  : OroColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) trailing,
                ],
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
