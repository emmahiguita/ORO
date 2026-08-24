# 🌟 ORO - Plataforma E-Commerce Premium

&nbsp; ![Flutter](https://img.shields.io/badge/Flutter-3.6.2%2B-02569B?logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-3.6.2%2B-0175C2?logo=dart&logoColor=white) ![PHP](https://img.shields.io/badge/PHP-8.2%2B-777BB4?logo=php&logoColor=white) ![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

> **Plataforma de comercio electrónico premium, multi-rol y auditada, construida con Flutter y PHP con soporte integral en Español, Modo Offline y suite de pruebas automatizadas.**

---

## 📱 Descripción General

**ORO** es una solución de comercio electrónico diseñada para brindar una experiencia de compra fluida, rápida y moderna para clientes, repartidores y administradores.

### 🌟 Características Principales

- **🌎 100% en Español:** Toda la interfaz, mensajes, diálogos y notificaciones están localizados y optimizados en español.
- **🔐 Autenticación Flexible:** Inicio de sesión unificado con **Usuario o Correo Electrónico**, verificación segura de contraseñas y opción de **Recordar Credenciales**.
- **📶 Modo Offline / Demo:** Capacidad de explorar todo el catálogo, categorías, carrito, pedidos y perfiles de forma autónoma sin conexión a internet ni dependencia de backend.
- **🎨 Identidad de Marca:** Logotipo oficial con tonos esmeralda y acentos dorados integrado en Launcher Icons nativos de Android, Splash Screen y cabeceras de la app.
- **🛒 Experiencia de Compra Completa:**
  - Catálogo interactivo por categorías con búsqueda en tiempo real.
  - Carrito de compras con cálculo de subtotales, cupones y tarifas de entrega.
  - Gestión de favoritos y calificaciones de productos.
  - Seguimiento en tiempo real de pedidos activos e histórico archivado.
- **🚚 Módulo para Repartidores:** Aceptación de pedidos, navegación con mapas y gestión de estados de entrega.
- **📊 Panel de Administración:** Métricas de ventas, analítica de productos destacados, gestión de inventario y cupones de descuento.
- **🧪 Pruebas Automatizadas:** Suite completa de tests unitarios y de widgets con cobertura de autenticación, diseño y modo offline.

---

## 🛠️ Tecnologías y Arquitectura

- **Frontend:** Flutter 3.6+ / Dart con arquitectura de estado reactiva mediante **GetX**.
- **Diseño:** Material 3 con paleta de colores personalizada y tipografía legible.
- **Backend:** PHP 8.2+ con PDO preparado contra inyecciones SQL, tokens JWT y endpoints REST auditados.
- **Almacenamiento Local:** `SharedPreferences` + `FlutterSecureStorage` para credenciales y estado de sesión.

---

## 🚀 Instalación y Ejecución

### Prerrequisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versión 3.29+ / Dart 3.6+)
- Dispositivo Android, emulador o navegador web.

### 1. Clonar el repositorio
```bash
git clone https://github.com/emmahiguita/ORO.git
cd ORO
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecutar la aplicación
```bash
# En dispositivo Android conectado
flutter run

# En modo web
flutter run -d chrome
```

### 4. Ejecutar pruebas automatizadas
```bash
flutter test
```

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.
