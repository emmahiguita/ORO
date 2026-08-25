import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/checkout/checkoutcontroller.dart';
import 'package:oro/view/screens/address/viewaddress.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';
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
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar compra')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: GetBuilder<CheckoutControllerImp>(
                builder: (_) => ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth < 520 ? 16 : 24,
                      vertical: 16),
                  children: [
                    Text('Tu pedido',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 142,
                      child: controller.orderDetails.isEmpty
                          ? const Center(
                              child: Text('No hay productos para mostrar.'))
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.orderDetails.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (_, index) {
                                final item = controller.orderDetails[index];
                                return ItemView(
                                  itemName: item.itemName ?? 'Producto',
                                  itemImage:
                                      AppLink.itemimage + (item.itemImg ?? ''),
                                  itemprice: (item.itemFinalPrice ?? 0)
                                      .toStringAsFixed(0),
                                  itmeQuantity: '${item.countitems ?? 0}',
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 18),
                    _Section(
                      title: 'Entrega',
                      child: DeliveryType(
                        isDelivery: controller.deliveryType == 0,
                        isPickUp: controller.deliveryType == 1,
                        onTapDelivery: () => controller.changeDeliveryType(0),
                        onTapPickUp: () => controller.changeDeliveryType(1),
                      ),
                    ),
                    if (controller.deliveryType == 0) ...[
                      const SizedBox(height: 14),
                      _Section(
                        title: 'Dirección de entrega',
                        trailing: TextButton.icon(
                          onPressed: () => Get.to(() => const ViewAddress()),
                          icon: const Icon(Icons.add_location_alt_outlined),
                          label: const Text('Administrar'),
                        ),
                        child: controller.addresses.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                    'Agrega una dirección para recibir tu pedido.'),
                              )
                            : Column(
                                children: controller.addresses
                                    .map((address) => ShippingAddress(
                                          title: address.addressName ??
                                              'Dirección',
                                          subTitle: [
                                            address.addressBuilding,
                                            address.addressStreet,
                                            address.addressBlock
                                          ]
                                              .where((e) =>
                                                  e != null &&
                                                  e.trim().isNotEmpty)
                                              .join(', '),
                                          placeName: address.addressBymap ?? '',
                                          icon: Icons.location_on_outlined,
                                          isSelected: controller.addressId ==
                                              address.addressId,
                                          onTap: () =>
                                              controller.chooseAddressId(
                                                  address.addressId!),
                                        ))
                                    .toList(),
                              ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    _Section(
                      title: 'Pago',
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer.withValues(alpha: .35),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: scheme.outlineVariant),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.payments_outlined),
                            SizedBox(width: 12),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pago contra entrega o recogida',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                SizedBox(height: 4),
                                Text(
                                    'No se solicitarán datos de tarjeta dentro de la aplicación.'),
                              ],
                            )),
                            Icon(Icons.verified_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _Section(title: 'Cupón', child: CouponSection()),
                    const SizedBox(height: 14),
                    _Section(
                      title: 'Resumen',
                      child: Column(
                        children: [
                          SummaryRow(
                              label: 'Subtotal',
                              value: controller.formatMoney(
                                  controller.couponController.subtotal),
                              isTotal: false),
                          if (controller.couponController.isCouponUsed &&
                              controller
                                  .couponController.couponList.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            SummaryRow(
                                label: 'Descuento',
                                value:
                                    '-${controller.couponController.couponList.first.couponDiscount ?? 0}%',
                                isTotal: false),
                          ],
                          const SizedBox(height: 8),
                          SummaryRow(
                            label: controller.deliveryType == 0
                                ? 'Domicilio'
                                : 'Recogida',
                            value: controller.deliveryType == 0
                                ? controller.formatMoney(controller.shippingFee)
                                : controller.formatMoney(0),
                            isTotal: false,
                          ),
                          const Divider(height: 28),
                          SummaryRow(
                              label: 'Total estimado',
                              value: controller
                                  .formatMoney(controller.previewTotal),
                              isTotal: true),
                          const SizedBox(height: 8),
                          Text(
                              'El servidor recalcula precio, stock, cupón y total antes de confirmar.',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    FilledButton(
                      onPressed:
                          controller.isLoading ? null : controller.placeOrder,
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: GradientProgressIndicator(strokeWidth: 2))
                          : const Text('Confirmar pedido',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  const _Section({required this.title, required this.child, this.trailing});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800))),
            if (trailing != null) trailing!
          ]),
          const SizedBox(height: 14),
          child,
        ]),
      ),
    );
  }
}
