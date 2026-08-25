import 'package:oro/apilink.dart';

class OfflineDataProvider {
  OfflineDataProvider._();

  static bool isOfflineMode = false;

  static final List<Map<String, dynamic>> mockCategories = [
    {
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Electrónica',
      'category_img': 'Electronics.svg',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 2,
      'category_name': 'Fashion',
      'category_name_ar': 'أزياء',
      'category_name_es': 'Moda & Calzado',
      'category_img': 'Fashion.svg',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 3,
      'category_name': 'Home',
      'category_name_ar': 'منزل',
      'category_name_es': 'Hogar & Cocina',
      'category_img': 'Home.svg',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 4,
      'category_name': 'Beauty',
      'category_name_ar': 'جمال',
      'category_name_es': 'Belleza & Cuidado',
      'category_img': 'Beauty.svg',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 5,
      'category_name': 'Sports',
      'category_name_ar': 'رياضة',
      'category_name_es': 'Deportes',
      'category_img': 'Sports.svg',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 6,
      'category_name': 'Books',
      'category_name_ar': 'كتب',
      'category_name_es': 'Libros & Lectura',
      'category_img': 'Books.svg',
      'category_date': '2026-01-01 00:00:00',
    },
  ];

  static final List<Map<String, dynamic>> mockItems = [
    {
      'item_id': 1,
      'item_name': 'iPhone 15 Pro Max',
      'item_name_ar': 'آيفون 15 برو ماكس',
      'item_name_es': 'iPhone 15 Pro Max 256GB Titanio',
      'item_desc': 'Super Retina XDR OLED 6.7 inch, A17 Pro Chip, 48MP Camera',
      'item_desc_ar': 'شاشة سوبر ريتينا، معالج A17 برو',
      'item_desc_es':
          'Pantalla Super Retina XDR OLED 6.7", Chip A17 Pro, Cámara 48MP',
      'item_img':
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=80',
      'item_count': 15,
      'item_active': 1,
      'item_price': 1199.0,
      'item_discount': 10,
      'item_date': '2026-01-10 10:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Electrónica',
      'category_img': 'Electronics.svg',
      'item_final_price': 1079.1,
      'item_avg_rating': 4.9,
      'favorite': 1,
    },
    {
      'item_id': 2,
      'item_name': 'Samsung Galaxy S24 Ultra',
      'item_name_ar': 'سامسونج اس 24 الترا',
      'item_name_es': 'Samsung Galaxy S24 Ultra AI',
      'item_desc': 'Dynamic AMOLED 2X, Snapdragon 8 Gen 3, S-Pen included',
      'item_desc_ar': 'شاشة ديناميك أموليد، قلم إس بين',
      'item_desc_es':
          'Pantalla Dynamic AMOLED 2X, Procesador Snapdragon 8 Gen 3 con Galaxy AI y S-Pen',
      'item_img':
          'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&auto=format&fit=crop&q=80',
      'item_count': 12,
      'item_active': 1,
      'item_price': 1299.0,
      'item_discount': 15,
      'item_date': '2026-01-11 11:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Electrónica',
      'category_img': 'Electronics.svg',
      'item_final_price': 1104.15,
      'item_avg_rating': 4.8,
      'favorite': 0,
    },
    {
      'item_id': 3,
      'item_name': 'Sony WH-1000XM5',
      'item_name_ar': 'سماعات سوني',
      'item_name_es': 'Auriculares Sony WH-1000XM5 Cancelación Ruido',
      'item_desc':
          'Industry leading noise canceling wireless headphones with 30hr battery',
      'item_desc_ar': 'سماعات رأس لاسلكية عازلة للضوضاء',
      'item_desc_es':
          'Cancelación de ruido líder en la industria, sonido de alta resolución y 30h de batería',
      'item_img':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80',
      'item_count': 25,
      'item_active': 1,
      'item_price': 399.0,
      'item_discount': 20,
      'item_date': '2026-01-12 12:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Electrónica',
      'category_img': 'Electronics.svg',
      'item_final_price': 319.2,
      'item_avg_rating': 4.95,
      'favorite': 1,
    },
    {
      'item_id': 4,
      'item_name': 'Nike Air Max 270',
      'item_name_ar': 'حذاء نايك اير ماكس',
      'item_name_es': 'Zapatillas Deportivas Nike Air Max 270',
      'item_desc':
          'Breathable mesh upper with large Max Air unit for all-day comfort',
      'item_desc_ar': 'حذاء رياضي مريح',
      'item_desc_es':
          'Malla transpirable con amortiguación Max Air para máxima comodidad diaria',
      'item_img':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&auto=format&fit=crop&q=80',
      'item_count': 30,
      'item_active': 1,
      'item_price': 160.0,
      'item_discount': 10,
      'item_date': '2026-01-13 13:00:00',
      'item_cat': 2,
      'category_id': 2,
      'category_name': 'Fashion',
      'category_name_ar': 'أزياء',
      'category_name_es': 'Moda & Calzado',
      'category_img': 'Fashion.svg',
      'item_final_price': 144.0,
      'item_avg_rating': 4.7,
      'favorite': 1,
    },
    {
      'item_id': 5,
      'item_name': 'Adidas Ultraboost 22',
      'item_name_ar': 'حذاء اديداس الترا بوست',
      'item_name_es': 'Zapatillas Adidas Ultraboost 22 Running',
      'item_desc':
          'Responsive Boost midsole with Primeknit+ upper for performance running',
      'item_desc_ar': 'حذاء ركض عالي الأداء',
      'item_desc_es':
          'Media suela con retorno de energía Boost y tejido envolvente Primeknit+',
      'item_img':
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=600&auto=format&fit=crop&q=80',
      'item_count': 18,
      'item_active': 1,
      'item_price': 190.0,
      'item_discount': 25,
      'item_date': '2026-01-14 14:00:00',
      'item_cat': 2,
      'category_id': 2,
      'category_name': 'Fashion',
      'category_name_ar': 'أزياء',
      'category_name_es': 'Moda & Calzado',
      'category_img': 'Fashion.svg',
      'item_final_price': 142.5,
      'item_avg_rating': 4.85,
      'favorite': 0,
    },
    {
      'item_id': 6,
      'item_name': 'Philips AirFryer XXL',
      'item_name_ar': 'قلاية هوائية فيليبس',
      'item_name_es': 'Freidora de Aire Philips XXL Smart',
      'item_desc':
          'Twin TurboStar technology removes fat from food, 1.4kg capacity',
      'item_desc_ar': 'قلاية هوائية صحية',
      'item_desc_es':
          'Tecnología Twin TurboStar para cocción saludable sin aceite, capacidad 1.4kg',
      'item_img':
          'https://images.unsplash.com/photo-1585659722983-3a675dabf23d?w=600&auto=format&fit=crop&q=80',
      'item_count': 10,
      'item_active': 1,
      'item_price': 249.0,
      'item_discount': 12,
      'item_date': '2026-01-15 15:00:00',
      'item_cat': 3,
      'category_id': 3,
      'category_name': 'Home',
      'category_name_ar': 'منزل',
      'category_name_es': 'Hogar & Cocina',
      'category_img': 'Home.svg',
      'item_final_price': 219.12,
      'item_avg_rating': 4.9,
      'favorite': 0,
    },
    {
      'item_id': 7,
      'item_name': 'Dior Sauvage Eau de Parfum',
      'item_name_ar': 'عطر ديور سوفاج',
      'item_name_es': 'Perfume Dior Sauvage Eau de Parfum 100ml',
      'item_desc':
          'Noble and powerful fragrance with fresh bergamot and amber wood notes',
      'item_desc_ar': 'عطر فاخر',
      'item_desc_es':
          'Fragancia emblemática con notas de bergamota de Calabria y maderas ambarinas',
      'item_img':
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=600&auto=format&fit=crop&q=80',
      'item_count': 40,
      'item_active': 1,
      'item_price': 145.0,
      'item_discount': 5,
      'item_date': '2026-01-16 16:00:00',
      'item_cat': 4,
      'category_id': 4,
      'category_name': 'Beauty',
      'category_name_ar': 'جمال',
      'category_name_es': 'Belleza & Cuidado',
      'category_img': 'Beauty.svg',
      'item_final_price': 137.75,
      'item_avg_rating': 4.95,
      'favorite': 1,
    },
    {
      'item_id': 8,
      'item_name': 'Wilson Blade 98 V8',
      'item_name_ar': 'مضرب تنس ويلسون',
      'item_name_es': 'Raqueta de Tenis Profesional Wilson Blade 98',
      'item_desc': 'Precision feel and flexibility for competitive players',
      'item_desc_ar': 'مضرب تنس احترافي',
      'item_desc_es':
          'Sensación de control y precisión profesional con tecnología DirectConnect',
      'item_img':
          'https://images.unsplash.com/photo-1617083934555-56360c710f27?w=600&auto=format&fit=crop&q=80',
      'item_count': 8,
      'item_active': 1,
      'item_price': 260.0,
      'item_discount': 10,
      'item_date': '2026-01-17 17:00:00',
      'item_cat': 5,
      'category_id': 5,
      'category_name': 'Sports',
      'category_name_ar': 'رياضة',
      'category_name_es': 'Deportes',
      'category_img': 'Sports.svg',
      'item_final_price': 234.0,
      'item_avg_rating': 4.8,
      'favorite': 0,
    },
    {
      'item_id': 9,
      'item_name': 'Atomic Habits Book',
      'item_name_ar': 'كتاب العادات الذرية',
      'item_name_es': 'Libro Hábitos Atómicos - James Clear',
      'item_desc':
          'An easy and proven way to build good habits and break bad ones',
      'item_desc_ar': 'كتاب تطوير الذات الأكثر مبيعاً',
      'item_desc_es':
          'Bestseller internacional: Un método sencillo y comprobado para desarrollar buenos hábitos',
      'item_img':
          'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=600&auto=format&fit=crop&q=80',
      'item_count': 50,
      'item_active': 1,
      'item_price': 22.0,
      'item_discount': 0,
      'item_date': '2026-01-18 18:00:00',
      'item_cat': 6,
      'category_id': 6,
      'category_name': 'Books',
      'category_name_ar': 'كتب',
      'category_name_es': 'Libros & Lectura',
      'category_img': 'Books.svg',
      'item_final_price': 22.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    }
  ];

  // In-memory state for interactive offline simulation
  static final Map<int, int> _cartCounts = {1: 1, 4: 2};
  static final Set<int> _favoritesSet = {1, 3, 4, 7, 9};
  static final List<Map<String, dynamic>> _pendingOrders = [
    {
      'order_id': 1042,
      'order_userid': 1,
      'order_addressid': 1,
      'order_type': 0,
      'order_price': 1223.1,
      'order_pricedelivery': 10.0,
      'order_totalprice': 1233.1,
      'order_paymenttype': 0,
      'order_coupon': 0,
      'order_status': 2,
      'order_datetime': '2026-08-23 18:30:00',
      'address_name': 'Casa Principal',
      'address_street': 'Cra 43A #1-50',
      'address_building': 'Torre Alta',
      'address_floor': '8',
      'address_apt': '802',
      'address_city': 'Medellín',
    }
  ];

  static Map<String, dynamic> getMockResponse(String linkurl, Map data) {
    // 1. Auth & Login
    if (linkurl.contains('login') || linkurl.contains('auth/login')) {
      final role = (data['username'] == 'admin' ||
              data['username'] == 'admin@devemm.com')
          ? 2
          : (data['username'] == 'delivery' ||
                  data['username'] == 'delivery@devemm.com')
              ? 1
              : 0;
      return {
        'status': 'success',
        'data': {
          'user_id': 1,
          'user_name': data['username']?.toString().isNotEmpty == true
              ? data['username'].toString()
              : 'Emmanuel (Modo Offline)',
          'user_email': 'emmanuel@devemm.com',
          'user_phone': '+57 300 123 4567',
          'user_pfp': 'default.png',
          'user_banner': 'default.png',
          'user_approve': 1,
          'user_keyaccess': role,
        },
        'token': 'demo_offline_session_token_2026',
      };
    }

    if (linkurl.contains('signup') || linkurl.contains('auth/signup')) {
      return {
        'status': 'success',
        'message': 'Cuenta demo creada exitosamente.'
      };
    }

    // 2. Home data
    if (linkurl.contains('home/home') || linkurl == AppLink.home) {
      final itemsWithDynamicFav = mockItems.map((item) {
        final id = item['item_id'] as int;
        return {
          ...item,
          'favorite': _favoritesSet.contains(id) ? 1 : 0,
        };
      }).toList();

      return {
        'status': 'success',
        'categories': mockCategories,
        'items': itemsWithDynamicFav,
        'mainpage': [
          {
            'mainpage_id': 1,
            'mainpage_title': 'Colección ORO 2026',
            'mainpage_title_ar': 'مجموعة أورو 2026',
            'mainpage_title_es': 'Colección ORO 2026',
            'mainpage_body':
                'Catálogo offline interactivo. Puedes añadir artículos a tu carrito, favoritos y probar la app 100% funcional.',
            'mainpage_body_ar': 'تسوق بلا إنترنت',
            'mainpage_body_es':
                'Catálogo offline interactivo. Puedes añadir artículos a tu carrito, favoritos y probar la app 100% funcional.',
          }
        ],
      };
    }

    // 3. Items by category / search
    if (linkurl.contains('items/items') || linkurl == AppLink.items) {
      final catId = data['id']?.toString() ?? data['catid']?.toString();
      final filtered = catId != null && catId.isNotEmpty && catId != '0'
          ? mockItems.where((i) => i['item_cat'].toString() == catId).toList()
          : mockItems;
      final withFav = (filtered.isNotEmpty ? filtered : mockItems).map((i) {
        final id = i['item_id'] as int;
        return {
          ...i,
          'favorite': _favoritesSet.contains(id) ? 1 : 0,
        };
      }).toList();

      return {
        'status': 'success',
        'data': withFav,
      };
    }

    // 4. Cart (Interactive)
    if (linkurl.contains('cart/addcart')) {
      final id = int.tryParse('${data['itemsid'] ?? data['itemid']}') ?? 1;
      _cartCounts[id] = (_cartCounts[id] ?? 0) + 1;
      return {'status': 'success'};
    }

    if (linkurl.contains('cart/deletecart')) {
      final id = int.tryParse('${data['itemsid'] ?? data['itemid']}') ?? 1;
      if (_cartCounts.containsKey(id)) {
        if (_cartCounts[id]! > 1) {
          _cartCounts[id] = _cartCounts[id]! - 1;
        } else {
          _cartCounts.remove(id);
        }
      }
      return {'status': 'success'};
    }

    if (linkurl.contains('cart/countcart')) {
      final total = _cartCounts.values.fold(0, (sum, count) => sum + count);
      return {'status': 'success', 'data': total};
    }

    if (linkurl.contains('cart/viewcart') || linkurl == AppLink.cartView) {
      final currentCart = <Map<String, dynamic>>[];
      double totalPrice = 0.0;
      int totalCount = 0;

      for (final entry in _cartCounts.entries) {
        final item = mockItems.firstWhere(
          (i) => i['item_id'] == entry.key,
          orElse: () => mockItems[0],
        );
        final count = entry.value;
        final sub = (item['item_final_price'] as double) * count;
        totalPrice += sub;
        totalCount += count;

        currentCart.add({
          ...item,
          'cart_id': 100 + entry.key,
          'cart_itemid': entry.key,
          'countitems': count,
          'totalprice': sub,
        });
      }

      return {
        'status': 'success',
        'datacart': currentCart,
        'countprice': {
          'totalprice': totalPrice,
          'totalcount': totalCount,
        },
      };
    }

    // 5. Favourites (Interactive)
    if (linkurl.contains('favourites/add')) {
      final id = int.tryParse('${data['itemsid'] ?? data['itemid']}') ?? 1;
      _favoritesSet.add(id);
      return {'status': 'success'};
    }

    if (linkurl.contains('favourites/delete')) {
      final id = int.tryParse('${data['itemsid'] ?? data['itemid']}') ?? 1;
      _favoritesSet.remove(id);
      return {'status': 'success'};
    }

    if (linkurl.contains('favourites/view') ||
        linkurl == AppLink.favouritesView) {
      final favs = mockItems
          .where((i) => _favoritesSet.contains(i['item_id'] as int))
          .map((i) => {...i, 'favorite': 1})
          .toList();
      return {
        'status': 'success',
        'data': favs,
      };
    }

    // 6. Orders & Checkout (Interactive)
    if (linkurl.contains('orders/checkout') || linkurl.contains('orders/add')) {
      _cartCounts.clear();
      final newOrderId = 1043 + _pendingOrders.length;
      _pendingOrders.insert(0, {
        'order_id': newOrderId,
        'order_userid': 1,
        'order_addressid': 1,
        'order_type': 0,
        'order_price': 144.0,
        'order_pricedelivery': 10.0,
        'order_totalprice': 154.0,
        'order_paymenttype': 0,
        'order_coupon': 0,
        'order_status': 0,
        'order_datetime': '2026-08-23 23:00:00',
        'address_name': 'Casa Principal',
        'address_street': 'Cra 43A #1-50',
        'address_building': 'Torre Alta, Apt 802',
        'address_city': 'Medellín',
      });
      return {'status': 'success', 'order_id': newOrderId};
    }

    if (linkurl.contains('orders/pending')) {
      return {'status': 'success', 'data': _pendingOrders};
    }

    if (linkurl.contains('orders/archived')) {
      return {
        'status': 'success',
        'data': [
          {
            'order_id': 1018,
            'order_userid': 1,
            'order_addressid': 1,
            'order_type': 0,
            'order_price': 319.2,
            'order_pricedelivery': 10.0,
            'order_totalprice': 329.2,
            'order_paymenttype': 1,
            'order_coupon': 0,
            'order_status': 4,
            'order_datetime': '2026-08-15 14:20:00',
            'address_name': 'Oficina',
            'address_street': 'Calle 10 #32-15',
            'address_building': 'Centro Empresarial',
            'address_floor': '3',
            'address_apt': '301',
            'address_city': 'Medellín',
          }
        ],
      };
    }

    if (linkurl.contains('orders/vieworder') ||
        linkurl.contains('orderdetails')) {
      return {
        'status': 'success',
        'data': [
          {
            ...mockItems[0],
            'countitems': 1,
            'item_price': mockItems[0]['item_final_price'],
          },
          {
            ...mockItems[2],
            'countitems': 1,
            'item_price': mockItems[2]['item_final_price'],
          },
        ],
      };
    }

    // 7. Notifications
    if (linkurl.contains('notification/viewnotification') ||
        linkurl == AppLink.viewNotification) {
      return {
        'status': 'success',
        'data': [
          {
            'notification_id': 1,
            'notification_title': '¡Pedido #1042 en camino!',
            'notification_body':
                'Tu pedido ha sido asignado a un repartidor y llegará en aproximadamente 25 minutos.',
            'notification_datetime': '2026-08-23 18:35:00',
            'is_read': 0,
          },
          {
            'notification_id': 2,
            'notification_title': 'Colección ORO Verano 2026',
            'notification_body':
                'Hasta 25% de descuento en Calzado deportivo y Moda esta semana.',
            'notification_datetime': '2026-08-22 10:00:00',
            'is_read': 1,
          },
        ],
      };
    }

    if (linkurl.contains('notification/getunreadcount')) {
      return {'status': 'success', 'data': 1};
    }

    // 8. Addresses
    if (linkurl.contains('address/view') || linkurl == AppLink.viewAddress) {
      return {
        'status': 'success',
        'data': [
          {
            'address_id': 1,
            'address_name': 'Casa',
            'address_street': 'Avenida El Poblado #5-20',
            'address_building': 'Residencial Los Álamos',
            'address_floor': '4',
            'address_apt': '402',
            'address_city': 'Medellín',
            'address_lat': 6.2088,
            'address_long': -75.5678,
          },
          {
            'address_id': 2,
            'address_name': 'Oficina',
            'address_street': 'Calle 10 #43E-12',
            'address_building': 'Edificio Sigma',
            'address_floor': '12',
            'address_apt': '1205',
            'address_city': 'Medellín',
            'address_lat': 6.2100,
            'address_long': -75.5700,
          },
        ],
      };
    }

    if (linkurl.contains('address/add') ||
        linkurl.contains('address/edit') ||
        linkurl.contains('address/delete')) {
      return {'status': 'success'};
    }

    // 9. Ratings & Profile
    if (linkurl.contains('rating/viewrating') ||
        linkurl.contains('rating/get')) {
      return {
        'status': 'success',
        'data': [
          {
            'rating_id': 1,
            'rating_stars': 5.0,
            'rating_comment':
                'Excelente calidad de construcción y sonido premium. Muy recomendado.',
            'rating_datetime': '2026-08-20 16:45:00',
            'user_name': 'Carlos M.',
            'user_pfp': 'default.png',
          },
          {
            'rating_id': 2,
            'rating_stars': 4.5,
            'rating_comment':
                'Entrega rápida y producto 100% original con empaque impecable.',
            'rating_datetime': '2026-08-19 11:20:00',
            'user_name': 'Laura G.',
            'user_pfp': 'default.png',
          },
        ],
      };
    }

    if (linkurl.contains('profile/orderscount')) {
      return {'status': 'success', 'data': 14};
    }

    // 10. Admin dashboard
    if (linkurl.contains('admin/dashboard') ||
        linkurl == AppLink.dashboardInfo) {
      return {
        'status': 'success',
        'total_sales': 48500.0,
        'total_orders': 312,
        'total_users': 158,
        'total_products': 45,
        'recent_orders': [
          {
            'order_id': 1042,
            'user_name': 'Emmanuel',
            'order_totalprice': 1233.1,
            'order_status': 2,
            'order_datetime': '2026-08-23 18:30:00',
          },
          {
            'order_id': 1041,
            'user_name': 'Sofía Gómez',
            'order_totalprice': 450.0,
            'order_status': 1,
            'order_datetime': '2026-08-23 17:15:00',
          },
        ],
        'top_categories': [
          {'category_name': 'Electrónica', 'sales_count': 145},
          {'category_name': 'Moda & Calzado', 'sales_count': 98},
          {'category_name': 'Hogar & Cocina', 'sales_count': 69},
        ],
      };
    }

    if (linkurl.contains('admin/categories/view')) {
      return {'status': 'success', 'data': mockCategories};
    }

    if (linkurl.contains('admin/items/view')) {
      return {'status': 'success', 'data': mockItems};
    }

    if (linkurl.contains('admin/coupon/viewcoupons')) {
      return {
        'status': 'success',
        'data': [
          {
            'coupon_id': 1,
            'coupon_code': 'ORO2026',
            'coupon_discount': 20,
            'coupon_count': 100,
            'coupon_expirydate': '2026-12-31 23:59:59',
          },
          {
            'coupon_id': 2,
            'coupon_code': 'VERANO15',
            'coupon_discount': 15,
            'coupon_count': 50,
            'coupon_expirydate': '2026-09-30 23:59:59',
          },
        ],
      };
    }

    // 11. Delivery requests
    if (linkurl.contains('delivery/requests') ||
        linkurl.contains('delivery/viewaccepted')) {
      return {
        'status': 'success',
        'data': [
          {
            'order_id': 1042,
            'order_userid': 1,
            'user_name': 'Emmanuel',
            'user_phone': '+57 300 123 4567',
            'address_name': 'Casa Principal',
            'address_street': 'Cra 43A #1-50',
            'address_building': 'Torre Alta, Apt 802',
            'address_city': 'Medellín',
            'order_totalprice': 1233.1,
            'order_pricedelivery': 10.0,
            'order_paymenttype': 0,
            'order_status': 2,
            'order_datetime': '2026-08-23 18:30:00',
          }
        ],
      };
    }

    if (linkurl.contains('delivery/countdelivered')) {
      return {'status': 'success', 'data': 28};
    }

    // Default success fallback
    return {'status': 'success', 'data': []};
  }
}
