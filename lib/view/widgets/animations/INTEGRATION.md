# 🎨 Guía de Integración: Componentes ORO Lottie y Animaciones

Esta suite modular de animaciones y micro-interacciones fue diseñada exclusivamente para la plataforma **ORO**, elevando la experiencia visual a un nivel premium con retroalimentación háptica y fluidez a 60fps.

---

## 📦 Estructura de Componentes

```text
lib/view/widgets/animations/
├── animations.dart                 # Exportador central de todos los componentes
├── oro_animation_assets.dart       # Registro estático de rutas Lottie JSON
├── oro_lottie_view.dart            # Wrapper Lottie con carga segura y placeholders
├── oro_animated_button.dart        # Botón interactivo con micro-escala y hápticos
├── oro_animated_cart_badge.dart    # Badge contador de carrito con rebote reactivo
├── oro_product_fly_to_cart.dart    # Animación curva Bezier producto → carrito
├── oro_empty_cart.dart             # Estado vacío premium con llamada a la acción
├── oro_order_success.dart          # Pantalla de confirmación y celebración
└── oro_delivery_status.dart        # Línea de tiempo interactiva de 6 estados de entrega
```

---

## 🚀 Ejemplos de Integración

### 1. Botón con Animación y Feedback Háptico (`OroAnimatedButton`)
```dart
import 'package:oro/view/widgets/animations/animations.dart';

OroAnimatedButton(
  text: 'Añadir al Carrito',
  icon: Icons.shopping_bag_outlined,
  isLoading: controller.isAddingToCart,
  onPressed: () {
    controller.addToCart(productId);
  },
)
```

### 2. Efecto de Vuelo Curvo al Carrito (`OroProductFlyToCart`)
```dart
OroProductFlyToCart.run(
  context: context,
  startKey: productThumbnailKey,
  endKey: cartIconKey,
  imageWidget: Image.network(productImageUrl),
  onComplete: () {
    cartController.incrementCount();
  },
);
```

### 3. Badge Animado en Barra Superior (`OroAnimatedCartBadge`)
```dart
OroAnimatedCartBadge(
  count: cartController.itemCount,
  child: IconButton(
    icon: const Icon(Icons.shopping_cart_outlined),
    onPressed: () => Get.toNamed(Approutes.cart),
  ),
)
```

### 4. Estado de Carrito Vacío (`OroEmptyCart`)
```dart
if (cartController.items.isEmpty)
  OroEmptyCart(
    onExplorePressed: () => Get.offNamed(Approutes.homeScreen),
  )
```

### 5. Confirmación de Pedido (`OroOrderSuccess`)
```dart
OroOrderSuccess(
  orderId: '1042',
  totalPrice: 1233.10,
  deliveryTime: '25 - 35 min',
  onTrackOrder: () => Get.toNamed(Approutes.ordersTracking),
  onContinueShopping: () => Get.offAllNamed(Approutes.homeScreen),
)
```

### 6. Seguimiento de Domicilio (`OroDeliveryStatus`)
```dart
OroDeliveryStatus(
  currentStep: OroDeliveryStep.onTheWay,
  orderId: '1042',
  riderName: 'Carlos Mendoza',
  onContactRider: () => launchUrl(Uri.parse('tel:+573001234567')),
  onViewMap: () => Get.toNamed(Approutes.deliveryMap),
)
```
