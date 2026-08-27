import 'package:oro/apilink.dart';

class OfflineDataProvider {
  OfflineDataProvider._();

  static bool isOfflineMode = false;

  static final List<Map<String, dynamic>> mockCategories = [
    {
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 2,
      'category_name': 'Luxury Fashion',
      'category_name_ar': 'أزياء فاخرة',
      'category_name_es': 'Ropa & Alta Costura',
      'category_img': 'real_saint_laurent_jacket.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 20,
      'category_name': 'Designer Footwear',
      'category_name_ar': 'أحذية مصممين',
      'category_name_es': 'Zapatos & Calzado',
      'category_img': 'real_gucci_oxford_shoes.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 30,
      'category_name': 'Bags & Accessories',
      'category_name_ar': 'حقائب وإكسسوارات',
      'category_name_es': 'Bolsos & Accesorios',
      'category_img': 'real_hermes_birkin.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Tecnología & Gadgets',
      'category_img': 'real_iphone15_promax.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 3,
      'category_name': 'Home',
      'category_name_ar': 'منزل',
      'category_name_es': 'Hogar & Cocina',
      'category_img': 'product_airfryer.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 4,
      'category_name': 'Beauty',
      'category_name_ar': 'جمال',
      'category_name_es': 'Belleza & Cuidado',
      'category_img': 'real_dior_sauvage.png',
      'category_date': '2026-01-01 00:00:00',
    },
    {
      'category_id': 5,
      'category_name': 'Sports',
      'category_name_ar': 'رياضة',
      'category_name_es': 'Deportes',
      'category_img': 'product_tennis_racket.png',
      'category_date': '2026-01-01 00:00:00',
    },
  ];

  static final List<Map<String, dynamic>> mockItems = [
    // === CATEGORÍA: ALTA JOYERÍA & RELOJES (ID: 100) ===
    {
      'item_id': 101,
      'item_name': 'Rolex Submariner Date Oro Amarillo 18K',
      'item_name_ar': 'ساعة رولكس سابمارينر ذهب أصفر عيار 18',
      'item_name_es': 'Rolex Submariner Date Oro Amarillo 18K',
      'item_desc': 'Reloj icónico de buceo en oro amarillo de 18K con esfera azul royal, bisel cerámico Cerachrom y calibre 3235 automático con certificado Cronómetro Superlativo.',
      'item_desc_ar': 'ساعة رولكس غواص أصلية من الذهب الخالص',
      'item_desc_es': 'Reloj icónico en oro amarillo de 18K, esfera azul royal, bisel Cerachrom y calibre 3235.',
      'item_img': 'real_rolex_submariner.png',
      'item_count': 3,
      'item_active': 1,
      'item_price': 148000000.0,
      'item_discount': 5,
      'item_date': '2026-01-08 10:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 140600000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },
    {
      'item_id': 102,
      'item_name': 'Cartier Love Bracelet Oro Amarillo 18K',
      'item_name_ar': 'سوار كارتييه لوف ذهب عيار 18',
      'item_desc': 'El legendario brazalete ovalado cerrado con tornillos en oro amarillo macizo de 18 kilates. Incluye destornillador ergonómico y certificado de autenticidad Cartier.',
      'item_desc_ar': 'سوار كارتييه لوف الشهير من الذهب الخالص',
      'item_name_es': 'Brazalete Cartier Love Oro Amarillo 18K',
      'item_desc_es': 'Legendario brazalete ovalado con motivos de tornillos en oro macizo de 18K y destornillador.',
      'item_img': 'real_cartier_love.png',
      'item_count': 6,
      'item_active': 1,
      'item_price': 32500000.0,
      'item_discount': 8,
      'item_date': '2026-01-09 10:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 29900000.0,
      'item_avg_rating': 4.99,
      'favorite': 1,
    },
    {
      'item_id': 103,
      'item_name': 'Tiffany & Co. Anillo Solitario Diamante',
      'item_name_ar': 'خاتم ألماس تيفاني أند كو',
      'item_name_es': 'Tiffany & Co. Anillo Solitario Diamante 2.0ct Platino',
      'item_desc': 'El legendario engaste de seis garras Tiffany Setting en platino puro 950 con diamante solitario natural corte brillante de 2.00 quilates, color D, claridad VVS1.',
      'item_desc_ar': 'خاتم خطوبة تيفاني سوليتير ألماس نقي',
      'item_desc_es': 'Engaste Tiffany Setting de seis garras en platino 950 con diamante natural 2.0ct VVS1.',
      'item_img': 'real_tiffany_diamond_ring.png',
      'item_count': 4,
      'item_active': 1,
      'item_price': 85000000.0,
      'item_discount': 10,
      'item_date': '2026-01-09 12:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 76500000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },
    {
      'item_id': 104,
      'item_name': 'Van Cleef & Arpels Alhambra Collar Oro 18K',
      'item_name_ar': 'قلادة فان كليف أند أربلز ألهامبرا',
      'item_name_es': 'Collar Vintage Alhambra 10 Motivos Oro 18K',
      'item_desc': 'Collar icónico de 10 motivos de trébol de la suerte en oro amarillo guilloché de 18 kilates con borde de perlas de oro.',
      'item_desc_ar': 'قلادة فان كليف الشهيرة من الذهب عيار 18',
      'item_desc_es': 'Collar con 10 motivos de trébol en oro amarillo de 18K guilloché y borde perlado.',
      'item_img': 'real_vancleef_necklace.png',
      'item_count': 5,
      'item_active': 1,
      'item_price': 42000000.0,
      'item_discount': 5,
      'item_date': '2026-01-09 14:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 39900000.0,
      'item_avg_rating': 4.98,
      'favorite': 1,
    },
    {
      'item_id': 105,
      'item_name': 'Anillo Esmeralda Colombiana de Muzo 18K',
      'item_name_ar': 'خاتم زمرد كولومبي طبيعي 18 قيراط',
      'item_name_es': 'Anillo Esmeralda Colombiana de Muzo 3.2ct Oro 18K',
      'item_desc': 'Anillo de alta joyería artesanal con esmeralda natural de Muzo (Boyacá, Colombia) corte esmeralda de 3.2 quilates y halo de diamantes en oro de 18K.',
      'item_desc_ar': 'خاتم زمرد كولومبي أصلي فاخر',
      'item_desc_es': 'Esmeralda colombiana de Muzo 3.2ct certificada con halo de diamantes en oro amarillo 18K.',
      'item_img': 'real_emerald_ring.png',
      'item_count': 6,
      'item_active': 1,
      'item_price': 28000000.0,
      'item_discount': 12,
      'item_date': '2026-01-10 10:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 24640000.0,
      'item_avg_rating': 4.97,
      'favorite': 1,
    },
    {
      'item_id': 106,
      'item_name': 'Cadena Eslabón Cubano Miami Oro Macizo 18K (65g)',
      'item_name_ar': 'سلسلة كوبان ميامي ذهب عيار 18',
      'item_name_es': 'Cadena Eslabón Cubano Miami Oro Macizo 18K 65g',
      'item_desc': 'Cadena gruesa de 10mm estilo Miami Cuban Link en oro macizo de 18K de 65 gramos con broche de caja reforzado de doble seguridad.',
      'item_desc_ar': 'سلسلة كوبية ثقيلة من الذهب عيار 18',
      'item_desc_es': 'Cadena de 10mm en oro macizo 18K con 65g de peso y broche de caja con doble traba.',
      'item_img': 'real_gold_cuban_chain.png',
      'item_count': 5,
      'item_active': 1,
      'item_price': 21500000.0,
      'item_discount': 10,
      'item_date': '2026-01-11 10:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 19350000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },
    {
      'item_id': 107,
      'item_name': 'Patek Philippe Nautilus 5711 Oro Rosa',
      'item_name_ar': 'ساعة باتيك فيليب نوتيلوس ذهب وردي',
      'item_name_es': 'Patek Philippe Nautilus 5711/1R Oro Rosa 18K',
      'item_desc': 'La máxima cúspide de la relojería suiza. Caja octogonal en oro rosa de 18K con brazalete integrado y calibre automático 26-330 S C.',
      'item_desc_ar': 'ساعة باتيك فيليب نوتيلوس الأصلية الفاخرة',
      'item_desc_es': 'Caja octogonal en oro rosa de 18K, brazalete integrado y calibre automático suizo.',
      'item_img': 'real_patek_nautilus.png',
      'item_count': 2,
      'item_active': 1,
      'item_price': 380000000.0,
      'item_discount': 5,
      'item_date': '2026-01-12 10:00:00',
      'item_cat': 100,
      'category_id': 100,
      'category_name': 'High Jewelry & Watches',
      'category_name_ar': 'مجوهرات وساعات فاخرة',
      'category_name_es': 'Alta Joyería & Relojes',
      'category_img': 'real_rolex_submariner.png',
      'item_final_price': 361000000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },

    // === CATEGORÍA: ROPA & ALTA COSTURA (ID: 2) ===
    {
      'item_id': 201,
      'item_name': 'Saint Laurent Chaqueta Biker Cuero Genuino',
      'item_name_ar': 'سترة جلدية سان لوران',
      'item_name_es': 'Saint Laurent Chaqueta Biker Cuero Lambskin',
      'item_desc': 'La legendaria chaqueta motera de Saint Laurent confeccionada en 100% cuero de cordero suave con herrajes metálicos plateados y corte entallado.',
      'item_desc_ar': 'سترة جلدية راقية من سان لوران باريس',
      'item_desc_es': '100% cuero de cordero suave italiano, cremalleras asimétricas y solapas con broches.',
      'item_img': 'real_saint_laurent_jacket.png',
      'item_count': 8,
      'item_active': 1,
      'item_price': 18900000.0,
      'item_discount': 15,
      'item_date': '2026-01-12 11:00:00',
      'item_cat': 2,
      'category_id': 2,
      'category_name': 'Luxury Fashion',
      'category_name_ar': 'أزياء فاخرة',
      'category_name_es': 'Ropa & Alta Costura',
      'category_img': 'real_saint_laurent_jacket.png',
      'item_final_price': 16065000.0,
      'item_avg_rating': 4.95,
      'favorite': 1,
    },
    {
      'item_id': 202,
      'item_name': 'Camisa Formal de Seda Gucci Heritage',
      'item_name_ar': 'قميص حرير غوتشي',
      'item_name_es': 'Camisa Formal 100% Seda Pura Gucci Heritage',
      'item_desc': 'Camisa de corte italiano confeccionada en seda natural brillante con botones de nácar genuino y cuello clásico reforzado.',
      'item_desc_ar': 'قميص حريري فاخر من غوتشي إيطاليا',
      'item_desc_es': '100% seda pura natural con botones de nácar y acabado satinado.',
      'item_img': 'real_gucci_silk_shirt.png',
      'item_count': 12,
      'item_active': 1,
      'item_price': 5200000.0,
      'item_discount': 10,
      'item_date': '2026-01-12 11:30:00',
      'item_cat': 2,
      'category_id': 2,
      'category_name': 'Luxury Fashion',
      'category_name_ar': 'أزياء فاخرة',
      'category_name_es': 'Ropa & Alta Costura',
      'category_img': 'real_saint_laurent_jacket.png',
      'item_final_price': 4680000.0,
      'item_avg_rating': 4.89,
      'favorite': 0,
    },
    {
      'item_id': 203,
      'item_name': 'Vestido de Gala Haute Couture Dior',
      'item_name_ar': 'فستان سهرة ديور كوتور',
      'item_name_es': 'Vestido de Noche en Seda Dior Haute Couture',
      'item_desc': 'Vestido de noche exclusivo con corpiño estructurado y falda con caída fluida en seda de alta costura parisina.',
      'item_desc_ar': 'فستان سهرة راقي من دار كريستيان ديور',
      'item_desc_es': 'Vestido de alta costura parisina en seda natural con corsé estructurado.',
      'item_img': 'real_dior_dress.png',
      'item_count': 4,
      'item_active': 1,
      'item_price': 26500000.0,
      'item_discount': 10,
      'item_date': '2026-01-12 11:45:00',
      'item_cat': 2,
      'category_id': 2,
      'category_name': 'Luxury Fashion',
      'category_name_ar': 'أزياء فاخرة',
      'category_name_es': 'Ropa & Alta Costura',
      'category_img': 'real_saint_laurent_jacket.png',
      'item_final_price': 23850000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },

    // === CATEGORÍA: ZAPATOS & CALZADO (ID: 20) ===
    {
      'item_id': 210,
      'item_name': 'Zapatos Oxford Cuero Italiano Gucci',
      'item_name_ar': 'حذاء أوكسفورد جلدي غوتشي',
      'item_name_es': 'Zapatos Oxford Artesanales Gucci Brogue',
      'item_desc': 'Zapatos formales cosidos a mano en Florencia con cuero de becerro plena flor, suela de cuero curtido y plantilla viscoelástica acolchada.',
      'item_desc_ar': 'حذاء رسمي إيطالي كلاسيكي مصنوع يدوياً',
      'item_desc_es': 'Cuero vacuno plena flor con costura Blake, suela de cuero curtido y acabado brillante.',
      'item_img': 'real_gucci_oxford_shoes.png',
      'item_count': 10,
      'item_active': 1,
      'item_price': 4800000.0,
      'item_discount': 10,
      'item_date': '2026-01-12 12:00:00',
      'item_cat': 20,
      'category_id': 20,
      'category_name': 'Designer Footwear',
      'category_name_ar': 'أحذية مصممين',
      'category_name_es': 'Zapatos & Calzado',
      'category_img': 'real_gucci_oxford_shoes.png',
      'item_final_price': 4320000.0,
      'item_avg_rating': 4.94,
      'favorite': 1,
    },
    {
      'item_id': 211,
      'item_name': 'Botas Chelsea Cuero Nobuk Prada',
      'item_name_ar': 'بوت تشيلسي برادا',
      'item_name_es': 'Botas Chelsea en Cuero Nobuk Prada Milano',
      'item_desc': 'Botas Chelsea contemporáneas con el icónico logo triangular esmaltado de Prada, suela monoblock de caucho y elásticos laterales reforzados.',
      'item_desc_ar': 'بوت تشيلسي رجالي أنيق من برادا ميلانو',
      'item_desc_es': 'Cuero nobuk italiano con suela tractor antideslizante y logo triangular Prada.',
      'item_img': 'real_prada_boots.png',
      'item_count': 8,
      'item_active': 1,
      'item_price': 5900000.0,
      'item_discount': 12,
      'item_date': '2026-01-12 12:30:00',
      'item_cat': 20,
      'category_id': 20,
      'category_name': 'Designer Footwear',
      'category_name_ar': 'أحذية مصممين',
      'category_name_es': 'Zapatos & Calzado',
      'category_img': 'real_gucci_oxford_shoes.png',
      'item_final_price': 5192000.0,
      'item_avg_rating': 4.9,
      'favorite': 0,
    },
    {
      'item_id': 212,
      'item_name': 'Nike Air Jordan 1 Retro High Chicago',
      'item_name_ar': 'سنيكرز نايك اير جوردان 1 شيكاغو',
      'item_name_es': 'Nike Air Jordan 1 Retro High OG Chicago',
      'item_desc': 'El sneaker más legendario de la historia del baloncesto y el streetwear en su combinación de colores original Chicago (rojo, blanco y negro) con cuero premium.',
      'item_desc_ar': 'حذاء نايك جوردان 1 الأصلي الأكثر طلباً',
      'item_desc_es': 'Cuero premium original Chicago OG con cámara de aire Nike Air encapsulada.',
      'item_img': 'real_nike_jordan1_chicago.png',
      'item_count': 15,
      'item_active': 1,
      'item_price': 2400000.0,
      'item_discount': 10,
      'item_date': '2026-01-12 12:45:00',
      'item_cat': 20,
      'category_id': 20,
      'category_name': 'Designer Footwear',
      'category_name_ar': 'أحذية مصممين',
      'category_name_es': 'Zapatos & Calzado',
      'category_img': 'real_gucci_oxford_shoes.png',
      'item_final_price': 2160000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },
    {
      'item_id': 213,
      'item_name': 'Sneakers Balenciaga Triple S Clear Sole',
      'item_name_ar': 'سنيكرز بالنسياغا تريبل إس',
      'item_name_es': 'Sneakers Balenciaga Triple S Clear Sole',
      'item_desc': 'Zapatilla oversize de diseñador con suela de triple capa transparente de amortiguación extrema y paneles de malla y cuero superpuestos.',
      'item_desc_ar': 'سنيكرز بالنسياغا تريبل اس الشهير',
      'item_desc_es': 'Suela de 3 capas con tecnología de cámara de aire Clear Sole y bordado Balenciaga.',
      'item_img': 'real_balenciaga_triples.png',
      'item_count': 9,
      'item_active': 1,
      'item_price': 5400000.0,
      'item_discount': 15,
      'item_date': '2026-01-12 12:55:00',
      'item_cat': 20,
      'category_id': 20,
      'category_name': 'Designer Footwear',
      'category_name_ar': 'أحذية مصممين',
      'category_name_es': 'Zapatos & Calzado',
      'category_img': 'real_gucci_oxford_shoes.png',
      'item_final_price': 4590000.0,
      'item_avg_rating': 4.88,
      'favorite': 0,
    },

    // === CATEGORÍA: BOLSOS & ACCESORIOS (ID: 30) ===
    {
      'item_id': 301,
      'item_name': 'Hermès Birkin 30 Cuero Togo & Oro',
      'item_name_ar': 'حقيبة هيرميس بيركين 30 جلد توغو',
      'item_name_es': 'Hermès Birkin 30 Cuero Togo con Herrajes Oro',
      'item_desc': 'La pieza cumbre del lujo internacional. Bolso Birkin hecho a mano con cuero Togo granulado resistente a rayones y candado bañado en oro de 24K.',
      'item_desc_ar': 'حقيبة هيرميس بيركين النادرة الأكثر فخامة في العالم',
      'item_desc_es': 'Hecha a mano en Francia con cuero Togo natural y candado con llave en oro 24K.',
      'item_img': 'real_hermes_birkin.png',
      'item_count': 2,
      'item_active': 1,
      'item_price': 115000000.0,
      'item_discount': 5,
      'item_date': '2026-01-13 15:00:00',
      'item_cat': 30,
      'category_id': 30,
      'category_name': 'Bags & Accessories',
      'category_name_ar': 'حقائب وإكسسوارات',
      'category_name_es': 'Bolsos & Accesorios',
      'category_img': 'real_hermes_birkin.png',
      'item_final_price': 109250000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    },
    {
      'item_id': 302,
      'item_name': 'Chanel Classic Flap Bag Cuero Caviar',
      'item_name_ar': 'حقيبة شانيل كلاسيك فلاب جلد كافيار',
      'item_name_es': 'Chanel Classic Medium Double Flap Bag Oro',
      'item_desc': 'El icónico bolso acolchado de Chanel con cadena entrelazada de cuero y oro, cierre de giro doble C y piel de becerro graneada Caviar.',
      'item_desc_ar': 'حقيبة شانيل كلاسيكية جلد فاخر',
      'item_desc_es': 'Piel de becerro Caviar acolchada con acolchado diamante y cierre doble C dorado.',
      'item_img': 'real_chanel_flap_bag.png',
      'item_count': 4,
      'item_active': 1,
      'item_price': 48000000.0,
      'item_discount': 8,
      'item_date': '2026-01-13 15:30:00',
      'item_cat': 30,
      'category_id': 30,
      'category_name': 'Bags & Accessories',
      'category_name_ar': 'حقائب وإكسسوارات',
      'category_name_es': 'Bolsos & Accesorios',
      'category_img': 'real_hermes_birkin.png',
      'item_final_price': 44160000.0,
      'item_avg_rating': 4.99,
      'favorite': 1,
    },
    {
      'item_id': 303,
      'item_name': 'Louis Vuitton Speedy Bandoulière 25 Monogram',
      'item_name_ar': 'حقيبة لويس فيتون سبيدي مونوغرام',
      'item_name_es': 'Louis Vuitton Speedy 25 Monogram Canvas',
      'item_desc': 'El clásico atemporal de Louis Vuitton en lona Monogram con acabados en piel de vaca natural y correa de hombro ajustable y candado dorado.',
      'item_desc_ar': 'حقيبة لويس فيتون سبيدي الأصلية',
      'item_desc_es': 'Lona Monogram clásica con ribetes de cuero natural y herrajes dorados grabados.',
      'item_img': 'real_louis_vuitton_speedy.png',
      'item_count': 7,
      'item_active': 1,
      'item_price': 9800000.0,
      'item_discount': 10,
      'item_date': '2026-01-13 15:45:00',
      'item_cat': 30,
      'category_id': 30,
      'category_name': 'Bags & Accessories',
      'category_name_ar': 'حقائب وإكسسوارات',
      'category_name_es': 'Bolsos & Accesorios',
      'category_img': 'real_hermes_birkin.png',
      'item_final_price': 8820000.0,
      'item_avg_rating': 4.96,
      'favorite': 0,
    },
    {
      'item_id': 304,
      'item_name': 'Gafas de Sol Ray-Ban Aviator Classic Oro',
      'item_name_ar': 'نظارات ريبان أفياتور ذهبية',
      'item_name_es': 'Ray-Ban Aviator Classic Marco Oro Lentes G-15',
      'item_desc': 'El modelo de gafas de sol más famoso del mundo con montura de metal pulido dorado y lentes minerales G-15 verdes polarizados de máxima nitidez.',
      'item_desc_ar': 'نظارات شمسية كلاسيكية ريبان إطار ذهبي',
      'item_desc_es': 'Montura metálica dorada con lentes de cristal mineral verde G-15 polarizadas UV400.',
      'item_img': 'real_rayban_aviator.png',
      'item_count': 25,
      'item_active': 1,
      'item_price': 890000.0,
      'item_discount': 15,
      'item_date': '2026-01-13 16:00:00',
      'item_cat': 30,
      'category_id': 30,
      'category_name': 'Bags & Accessories',
      'category_name_ar': 'حقائب وإكسسوارات',
      'category_name_es': 'Bolsos & Accesorios',
      'category_img': 'real_hermes_birkin.png',
      'item_final_price': 756500.0,
      'item_avg_rating': 4.93,
      'favorite': 1,
    },

    // === CATEGORÍA: TECNOLOGÍA & GADGETS (ID: 1) ===
    {
      'item_id': 1,
      'item_name': 'iPhone 15 Pro Max',
      'item_name_ar': 'آيفون 15 برو ماكس',
      'item_name_es': 'iPhone 15 Pro Max 256GB Titanio',
      'item_desc': 'Super Retina XDR OLED 6.7 inch, Chip A17 Pro, Cámara 48MP con zoom óptico 5x y acabado en titanio espacial.',
      'item_desc_ar': 'شاشة سوبر ريتينا، معالج A17 برو',
      'item_desc_es':
          'Pantalla Super Retina XDR OLED 6.7", Chip A17 Pro, Cámara 48MP con zoom óptico 5x y titanio aeroespacial.',
      'item_img': 'real_iphone15_promax.png',
      'item_count': 15,
      'item_active': 1,
      'item_price': 5490000.0,
      'item_discount': 10,
      'item_date': '2026-01-10 10:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Tecnología & Gadgets',
      'category_img': 'real_iphone15_promax.png',
      'item_final_price': 4941000.0,
      'item_avg_rating': 4.9,
      'favorite': 1,
    },
    {
      'item_id': 3,
      'item_name': 'Sony WH-1000XM5',
      'item_name_ar': 'سماعات سوني',
      'item_name_es': 'Auriculares Sony WH-1000XM5 Cancelación Ruido',
      'item_desc':
          'Cancelación de ruido líder en la industria con 8 micrófonos, sonido Hi-Res LDAC y 30 horas de batería continua.',
      'item_desc_ar': 'سماعات رأس لاسلكية عازلة للضوضاء',
      'item_desc_es':
          'Cancelación de ruido líder en la industria, sonido de alta resolución y 30h de batería.',
      'item_img': 'real_sony_headphones_xm5.png',
      'item_count': 25,
      'item_active': 1,
      'item_price': 1650000.0,
      'item_discount': 20,
      'item_date': '2026-01-12 12:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Tecnología & Gadgets',
      'category_img': 'real_iphone15_promax.png',
      'item_final_price': 1320000.0,
      'item_avg_rating': 4.95,
      'favorite': 1,
    },
    {
      'item_id': 11,
      'item_name': 'MacBook Pro 16 M3 Max',
      'item_name_ar': 'ماك بوك برو 16 إنش',
      'item_name_es': 'MacBook Pro 16" Chip M3 Max 36GB RAM',
      'item_desc': 'Pantalla Liquid Retina XDR de 16.2 pulgadas, procesador Apple M3 Max de 14 núcleos y almacenamiento SSD de 1TB.',
      'item_desc_ar': 'كمبيوتر أبل ماك بوك برو إم 3 ماكس',
      'item_desc_es': 'Pantalla Liquid Retina XDR 16.2", Chip M3 Max 14-core, 36GB RAM unificada y 1TB SSD ultra rápido.',
      'item_img': 'real_macbook_pro.png',
      'item_count': 5,
      'item_active': 1,
      'item_price': 14990000.0,
      'item_discount': 10,
      'item_date': '2026-01-13 10:00:00',
      'item_cat': 1,
      'category_id': 1,
      'category_name': 'Electronics',
      'category_name_ar': 'إلكترونيات',
      'category_name_es': 'Tecnología & Gadgets',
      'category_img': 'real_iphone15_promax.png',
      'item_final_price': 13491000.0,
      'item_avg_rating': 4.99,
      'favorite': 1,
    },

    // === CATEGORÍA: BELLEZA & CUIDADO (ID: 4) ===
    {
      'item_id': 7,
      'item_name': 'Dior Sauvage Eau de Parfum',
      'item_name_ar': 'عطر ديور سوفاج',
      'item_name_es': 'Perfume Dior Sauvage Eau de Parfum 100ml',
      'item_desc':
          'Fragancia emblemática con notas de bergamota de Calabria, pimienta de Sichuan y fondo envolvente de maderas ambarinas.',
      'item_desc_ar': 'عطر فاخر',
      'item_desc_es':
          'Fragancia emblemática con notas de bergamota de Calabria y maderas ambarinas.',
      'item_img': 'real_dior_sauvage.png',
      'item_count': 40,
      'item_active': 1,
      'item_price': 580000.0,
      'item_discount': 5,
      'item_date': '2026-01-16 16:00:00',
      'item_cat': 4,
      'category_id': 4,
      'category_name': 'Beauty',
      'category_name_ar': 'جمال',
      'category_name_es': 'Belleza & Cuidado',
      'category_img': 'real_dior_sauvage.png',
      'item_final_price': 551000.0,
      'item_avg_rating': 4.95,
      'favorite': 1,
    },

    // === CATEGORÍA: DEPORTES (ID: 5) ===
    {
      'item_id': 8,
      'item_name': 'Wilson Blade 98 V8',
      'item_name_ar': 'مضرب تنس ويلسون',
      'item_name_es': 'Raqueta de Tenis Profesional Wilson Blade 98',
      'item_desc': 'Sensación de control y precisión profesional con tecnología DirectConnect de fibra de carbono.',
      'item_desc_ar': 'مضرب تنس احترافي',
      'item_desc_es':
          'Sensación de control y precisión profesional con tecnología DirectConnect.',
      'item_img': 'product_tennis_racket.png',
      'item_count': 8,
      'item_active': 1,
      'item_price': 1150000.0,
      'item_discount': 10,
      'item_date': '2026-01-17 17:00:00',
      'item_cat': 5,
      'category_id': 5,
      'category_name': 'Sports',
      'category_name_ar': 'رياضة',
      'category_name_es': 'Deportes',
      'category_img': 'product_tennis_racket.png',
      'item_final_price': 1035000.0,
      'item_avg_rating': 4.8,
      'favorite': 0,
    },
    {
      'item_id': 9,
      'item_name': 'Atomic Habits Book',
      'item_name_ar': 'كتاب العادات الذرية',
      'item_name_es': 'Libro Hábitos Atómicos - James Clear',
      'item_desc':
          'Bestseller internacional: Un método sencillo y comprobado para desarrollar buenos hábitos y romper los malos.',
      'item_desc_ar': 'كتاب تطوير الذات الأكثر مبيعاً',
      'item_desc_es':
          'Bestseller internacional: Un método sencillo y comprobado para desarrollar buenos hábitos.',
      'item_img': 'product_book_habits.png',
      'item_count': 50,
      'item_active': 1,
      'item_price': 85000.0,
      'item_discount': 0,
      'item_date': '2026-01-18 18:00:00',
      'item_cat': 6,
      'category_id': 6,
      'category_name': 'Books',
      'category_name_ar': 'كتب',
      'category_name_es': 'Libros & Lectura',
      'category_img': 'product_book_habits.png',
      'item_final_price': 85000.0,
      'item_avg_rating': 5.0,
      'favorite': 1,
    }
  ];

  // In-memory state for interactive offline simulation
  static final Map<int, int> _cartCounts = {101: 1, 102: 1};
  static final Set<int> _favoritesSet = {101, 102, 104, 1, 3, 7};
  static final List<Map<String, dynamic>> _pendingOrders = [
    {
      'order_id': 1042,
      'order_userid': 1,
      'order_addressid': 1,
      'order_type': 0,
      'order_price': 12940000.0,
      'order_pricedelivery': 0.0,
      'order_totalprice': 12940000.0,
      'order_paymenttype': 0,
      'order_coupon': 0,
      'order_status': 2,
      'order_datetime': '2026-08-27 15:30:00',
      'address_name': 'Sede Principal Oro',
      'address_street': 'El Poblado Cra 43A #1-50',
      'address_building': 'Torre Financiera',
      'address_floor': '14',
      'address_apt': '1402',
      'address_city': 'Medellín, Colombia',
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
        'order_price': 4930000.0,
        'order_pricedelivery': 0.0,
        'order_totalprice': 4930000.0,
        'order_paymenttype': 0,
        'order_coupon': 0,
        'order_status': 0,
        'order_datetime': '2026-08-27 15:35:00',
        'address_name': 'Sede Principal Oro',
        'address_street': 'El Poblado Cra 43A #1-50',
        'address_building': 'Torre Financiera, Piso 14',
        'address_city': 'Medellín, Colombia',
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
            'order_price': 1320000.0,
            'order_pricedelivery': 0.0,
            'order_totalprice': 1320000.0,
            'order_paymenttype': 1,
            'order_coupon': 0,
            'order_status': 4,
            'order_datetime': '2026-08-15 14:20:00',
            'address_name': 'Oficina',
            'address_street': 'Calle 10 #32-15',
            'address_building': 'Centro Empresarial',
            'address_floor': '3',
            'address_apt': '301',
            'address_city': 'Medellín, Colombia',
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
