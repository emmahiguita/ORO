import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/search/searchdata.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/data/model/suggestionmodel.dart';

abstract class SearchController extends GetxController {
  search(String input);
  suggestion();
  goToItemDetails(itemModel);
}

class SearchControllerImp extends SearchController {
  StatusRequest statusRequest = StatusRequest.none;
  SearchData searchData = SearchData(Get.find());
  List<ItemsModel> results = [];
  List<SuggestionModel> suggestions = [];
  String input = "";
  TextEditingController? textEditingController;

  // ── Filtros y Ordenamiento Avanzados ──────────────────────────────────────
  String? selectedCategory;
  String selectedSort = 'relevance';
  double minPrice = 0;
  double maxPrice = 200000000; // 200 Millones COP
  bool onlyDiscount = false;
  bool highRating = false;
  bool isGridView = true; // Alternador Cuadrícula / Lista

  // ── Historial de Búsquedas Recientes ───────────────────────────────────────
  List<String> recentSearches = [];
  static const String _recentSearchesKey = 'recent_searches_oro';

  // ── Trending Searches ──────────────────────────────────────────────────────
  final List<String> trendingSearches = [
    'Rolex Submariner',
    'Cartier Love',
    'Tiffany Diamante',
    'Van Cleef Alhambra',
    'Esmeralda de Muzo',
    'Saint Laurent Biker',
    'Gucci Oxford',
    'Nike Jordan 1',
    'Hermès Birkin',
    'Chanel Flap Bag',
    'iPhone 15 Pro Max',
    'Dior Sauvage',
  ];

  int get activeFiltersCount {
    int count = 0;
    if (selectedCategory != null) count++;
    if (selectedSort != 'relevance') count++;
    if (minPrice > 0 || maxPrice < 200000000) count++;
    if (onlyDiscount) count++;
    if (highRating) count++;
    return count;
  }

  List<ItemsModel> get filteredResults {
    List<ItemsModel> list = List.from(results);

    // 1. Filtrar por categoría
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      final catKey = selectedCategory!.toLowerCase();
      list = list.where((item) {
        final catName = (item.categoryName ?? '').toLowerCase();
        final catNameEs = (item.categoryNameEs ?? '').toLowerCase();
        final itemName = (item.itemName ?? '').toLowerCase();
        final itemNameEs = (item.itemNameEs ?? '').toLowerCase();
        final catId = item.itemCat ?? item.categoryId ?? 0;

        if (catKey == 'oro') {
          return catId == 100 ||
              catName.contains('jewel') ||
              catName.contains('watch') ||
              catNameEs.contains('joya') ||
              catNameEs.contains('reloj') ||
              itemName.contains('rolex') ||
              itemName.contains('cartier') ||
              itemName.contains('tiffany') ||
              itemName.contains('patek') ||
              itemName.contains('oro') ||
              itemName.contains('esmeralda') ||
              itemName.contains('diamante') ||
              itemName.contains('van cleef');
        }
        if (catKey == 'electronica') {
          return catId == 1 ||
              catName.contains('electr') ||
              catNameEs.contains('tecnolog') ||
              catNameEs.contains('electr') ||
              itemName.contains('iphone') ||
              itemName.contains('macbook') ||
              itemName.contains('sony') ||
              itemName.contains('auricular') ||
              itemName.contains('apple');
        }
        if (catKey == 'moda') {
          return catId == 2 ||
              catName.contains('fashion') ||
              catNameEs.contains('moda') ||
              catNameEs.contains('ropa') ||
              itemName.contains('saint laurent') ||
              itemName.contains('gucci') ||
              itemName.contains('dior') ||
              itemName.contains('chaqueta') ||
              itemName.contains('vestido') ||
              itemName.contains('camisa');
        }
        if (catKey == 'calzado') {
          return catId == 20 ||
              catName.contains('footwear') ||
              catName.contains('shoe') ||
              catNameEs.contains('calzado') ||
              catNameEs.contains('zapato') ||
              itemName.contains('jordan') ||
              itemName.contains('oxford') ||
              itemName.contains('bota') ||
              itemName.contains('balenciaga') ||
              itemName.contains('prada');
        }
        if (catKey == 'bolsos') {
          return catId == 30 ||
              catName.contains('bag') ||
              catName.contains('accessories') ||
              catNameEs.contains('bolso') ||
              catNameEs.contains('accesorio') ||
              itemName.contains('birkin') ||
              itemName.contains('chanel') ||
              itemName.contains('speedy') ||
              itemName.contains('rayban');
        }
        if (catKey == 'belleza') {
          return catId == 4 ||
              catName.contains('beauty') ||
              catNameEs.contains('belleza') ||
              catNameEs.contains('perfume') ||
              itemName.contains('sauvage') ||
              itemName.contains('dior');
        }
        if (catKey == 'hogar') {
          return catId == 3 ||
              catName.contains('home') ||
              catNameEs.contains('hogar') ||
              itemName.contains('airfryer');
        }
        return catName.contains(catKey) ||
            catNameEs.contains(catKey) ||
            itemName.contains(catKey) ||
            itemNameEs.contains(catKey);
      }).toList();
    }

    // 2. Filtrar por rango de precio
    list = list.where((item) {
      final price = (item.itemFinalPrice ?? item.itemPrice ?? 0).toDouble();
      return price >= minPrice && price <= maxPrice;
    }).toList();

    // 3. Filtrar por solo descuentos
    if (onlyDiscount) {
      list = list.where((item) => (item.itemDiscount ?? 0) > 0).toList();
    }

    // 4. Filtrar por alta calificación
    if (highRating) {
      list = list.where((item) {
        final r = double.tryParse('${item.itemAvgRating}') ?? 0.0;
        return r >= 4.5;
      }).toList();
    }

    // 5. Ordenamiento
    switch (selectedSort) {
      case 'price_asc':
        list.sort((a, b) {
          final pA = (a.itemFinalPrice ?? a.itemPrice ?? 0).toDouble();
          final pB = (b.itemFinalPrice ?? b.itemPrice ?? 0).toDouble();
          return pA.compareTo(pB);
        });
        break;
      case 'price_desc':
        list.sort((a, b) {
          final pA = (a.itemFinalPrice ?? a.itemPrice ?? 0).toDouble();
          final pB = (b.itemFinalPrice ?? b.itemPrice ?? 0).toDouble();
          return pB.compareTo(pA);
        });
        break;
      case 'rating':
        list.sort((a, b) {
          final rA = double.tryParse('${a.itemAvgRating}') ?? 0.0;
          final rB = double.tryParse('${b.itemAvgRating}') ?? 0.0;
          return rB.compareTo(rA);
        });
        break;
      case 'discount':
        list.sort((a, b) => (b.itemDiscount ?? 0).compareTo(a.itemDiscount ?? 0));
        break;
      case 'relevance':
      default:
        break;
    }

    return list;
  }

  void toggleViewMode() {
    isGridView = !isGridView;
    update();
  }

  void applyFilters({
    String? category,
    required String sort,
    required double minP,
    required double maxP,
    required bool discountOnly,
    required bool ratingHigh,
  }) {
    selectedCategory = category;
    selectedSort = sort;
    minPrice = minP;
    maxPrice = maxP;
    onlyDiscount = discountOnly;
    highRating = ratingHigh;

    // Si la lista de resultados está vacía, cargar elementos del catálogo
    if (results.isEmpty) {
      results.clear();
      if (selectedCategory != null) {
        results.addAll(_searchLocalCatalog(selectedCategory!));
      } else {
        results.addAll(_searchLocalCatalog(''));
      }
      statusRequest = StatusRequest.success;
    }
    update();
  }

  void setCategory(String? category) {
    selectedCategory = selectedCategory == category ? null : category;
    
    // Si la búsqueda de texto está vacía o no hay resultados, alimentar con el catálogo correspondiente
    final currentQuery = textEditingController?.text.trim() ?? '';
    if (results.isEmpty || currentQuery.isEmpty) {
      results.clear();
      if (selectedCategory != null) {
        results.addAll(_searchLocalCatalog(selectedCategory!));
        statusRequest = StatusRequest.success;
      } else if (currentQuery.isNotEmpty) {
        results.addAll(_searchLocalCatalog(currentQuery));
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  void _loadRecentSearches() {
    try {
      final services = Get.find<Services>();
      recentSearches = services.sharedPreferences.getStringList(_recentSearchesKey) ?? [];
    } catch (_) {
      recentSearches = [];
    }
  }

  void saveRecentSearch(String query) {
    if (query.trim().isEmpty) return;
    try {
      final clean = query.trim();
      recentSearches.remove(clean);
      recentSearches.insert(0, clean);
      if (recentSearches.length > 10) {
        recentSearches = recentSearches.sublist(0, 10);
      }
      final services = Get.find<Services>();
      services.sharedPreferences.setStringList(_recentSearchesKey, recentSearches);
      update();
    } catch (_) {}
  }

  void removeRecentSearch(String query) {
    try {
      recentSearches.remove(query);
      final services = Get.find<Services>();
      services.sharedPreferences.setStringList(_recentSearchesKey, recentSearches);
      update();
    } catch (_) {}
  }

  void clearRecentSearches() {
    try {
      recentSearches.clear();
      final services = Get.find<Services>();
      services.sharedPreferences.remove(_recentSearchesKey);
      update();
    } catch (_) {}
  }

  @override
  search(input) async {
    final query = input.toString().trim();
    if (query.isEmpty) {
      results.clear();
      statusRequest = StatusRequest.none;
      update();
      return;
    }

    saveRecentSearch(query);
    this.input = query;
    textEditingController?.text = query;
    statusRequest = StatusRequest.loding;
    update();

    bool foundRemote = false;
    try {
      var response = await searchData.search(query);
      final status = handlingdata(response);
      if (status == StatusRequest.success && response is Map && response["status"] == "success") {
        final responsedata = response["data"];
        if (responsedata is List && responsedata.isNotEmpty) {
          results.clear();
          results.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
          foundRemote = true;
          statusRequest = StatusRequest.success;
        }
      }
    } catch (_) {
      foundRemote = false;
    }

    // ── Respaldo Inteligente con Catálogo Local y Offline ────────────────
    if (!foundRemote) {
      results.clear();
      final localItems = _searchLocalCatalog(query);
      if (localItems.isNotEmpty) {
        results.addAll(localItems);
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  List<ItemsModel> _searchLocalCatalog(String query) {
    final cleanQuery = query.toLowerCase().trim();
    final words = cleanQuery.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    Map<int, ItemsModel> allPoolMap = {};

    // 1. Catálogo Offline Completo con todos los productos de lujo
    for (var raw in OfflineDataProvider.mockItems) {
      try {
        final item = ItemsModel.fromJson(raw);
        if (item.itemId != null) {
          allPoolMap[item.itemId!] = item;
        }
      } catch (_) {}
    }

    // 2. Elementos en memoria de Home
    if (Get.isRegistered<HomeControllerImp>()) {
      final homeCtrl = Get.find<HomeControllerImp>();
      for (var item in homeCtrl.itemsList) {
        if (item.itemId != null) {
          allPoolMap[item.itemId!] = item;
        }
      }
    }

    final allPool = allPoolMap.values.toList();

    // 3. Mapeo Semántico de Sinónimos para Búsquedas en Español
    final isJewelryQuery = cleanQuery.contains('joya') ||
        cleanQuery.contains('reloj') ||
        cleanQuery.contains('oro') ||
        cleanQuery.contains('diamante') ||
        cleanQuery.contains('esmeralda') ||
        cleanQuery.contains('anillo') ||
        cleanQuery.contains('collar') ||
        cleanQuery.contains('pulsera') ||
        cleanQuery.contains('brazalete') ||
        cleanQuery.contains('cadena') ||
        cleanQuery.contains('rolex') ||
        cleanQuery.contains('cartier') ||
        cleanQuery.contains('tiffany') ||
        cleanQuery.contains('patek') ||
        cleanQuery.contains('van cleef');

    final isFashionQuery = cleanQuery.contains('ropa') ||
        cleanQuery.contains('moda') ||
        cleanQuery.contains('vestido') ||
        cleanQuery.contains('chaqueta') ||
        cleanQuery.contains('camisa') ||
        cleanQuery.contains('seda') ||
        cleanQuery.contains('cuero') ||
        cleanQuery.contains('saint laurent') ||
        cleanQuery.contains('gucci');

    final isShoesQuery = cleanQuery.contains('zapato') ||
        cleanQuery.contains('calzado') ||
        cleanQuery.contains('bota') ||
        cleanQuery.contains('tenis') ||
        cleanQuery.contains('zapatilla') ||
        cleanQuery.contains('sneaker') ||
        cleanQuery.contains('jordan') ||
        cleanQuery.contains('nike') ||
        cleanQuery.contains('balenciaga') ||
        cleanQuery.contains('prada');

    final isBagsQuery = cleanQuery.contains('bolso') ||
        cleanQuery.contains('cartera') ||
        cleanQuery.contains('mochila') ||
        cleanQuery.contains('accesorio') ||
        cleanQuery.contains('gafas') ||
        cleanQuery.contains('lentes') ||
        cleanQuery.contains('hermes') ||
        cleanQuery.contains('chanel') ||
        cleanQuery.contains('louis vuitton') ||
        cleanQuery.contains('rayban');

    final isTechQuery = cleanQuery.contains('tecnologia') ||
        cleanQuery.contains('electronica') ||
        cleanQuery.contains('celular') ||
        cleanQuery.contains('telefono') ||
        cleanQuery.contains('laptop') ||
        cleanQuery.contains('computador') ||
        cleanQuery.contains('audifono') ||
        cleanQuery.contains('auricular') ||
        cleanQuery.contains('iphone') ||
        cleanQuery.contains('macbook') ||
        cleanQuery.contains('sony') ||
        cleanQuery.contains('apple');

    final isBeautyQuery = cleanQuery.contains('perfume') ||
        cleanQuery.contains('belleza') ||
        cleanQuery.contains('fragancia') ||
        cleanQuery.contains('locion') ||
        cleanQuery.contains('dior') ||
        cleanQuery.contains('sauvage');

    // 4. Búsqueda con Coincidencia Ponderada
    final matches = allPool.where((item) {
      final searchable = '${item.itemName ?? ''} ${item.itemNameEs ?? ''} ${item.itemNameAr ?? ''} ${item.categoryName ?? ''} ${item.categoryNameEs ?? ''} ${item.itemDesc ?? ''} ${item.itemDescEs ?? ''}'.toLowerCase();
      
      // Coincidencia exacta de frase
      if (searchable.contains(cleanQuery)) return true;

      // Coincidencias Semánticas por Categoría
      if (isJewelryQuery && (item.itemCat == 100 || item.categoryId == 100)) return true;
      if (isFashionQuery && (item.itemCat == 2 || item.categoryId == 2)) return true;
      if (isShoesQuery && (item.itemCat == 20 || item.categoryId == 20)) return true;
      if (isBagsQuery && (item.itemCat == 30 || item.categoryId == 30)) return true;
      if (isTechQuery && (item.itemCat == 1 || item.categoryId == 1)) return true;
      if (isBeautyQuery && (item.itemCat == 4 || item.categoryId == 4)) return true;

      // Coincidencia por palabras clave
      for (final word in words) {
        if (word.length >= 2 && searchable.contains(word)) {
          return true;
        }
      }
      return false;
    }).toList();

    // Si la búsqueda es muy general o no encuentra, sugerir catálogo relevante
    if (matches.isEmpty && allPool.isNotEmpty) {
      return allPool.take(8).toList();
    }

    return matches;
  }

  @override
  suggestion() async {
    var response = await searchData.suggestion();
    final status = handlingdata(response);
    if (status == StatusRequest.success && response is Map) {
      if (response["status"] == "success") {
        suggestions.clear();
        final responsedata = response["data"];
        if (responsedata is List) {
          suggestions.addAll(responsedata.map(
            (e) => SuggestionModel.fromJson(e),
          ));
        }
      }
    }
  }

  static List<String> getSuggestions(String query, List<SuggestionModel> all) {
    List<String> matches = [];
    matches.addAll(all
        .map((e) => e.itemName?.trim() ?? '')
        .where((s) => s.isNotEmpty));
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void onInit() {
    _loadRecentSearches();
    final args = Get.arguments;
    if (args is Map && args['input'] != null) {
      input = args['input'].toString();
    } else if (args is String) {
      input = args;
    } else {
      input = '';
    }
    suggestion();
    textEditingController = TextEditingController(text: input);
    if (input.trim().isNotEmpty) {
      search(input.trim());
    } else {
      statusRequest = StatusRequest.none;
    }
    super.onInit();
  }

  @override
  goToItemDetails(itemModel) {
    Get.toNamed(Approutes.itemDetails, arguments: {"itemsModel": itemModel});
  }
}
