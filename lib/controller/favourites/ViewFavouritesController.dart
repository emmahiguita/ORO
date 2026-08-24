import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/favourites/favouritesdata.dart';
import 'package:oro/data/datasource/remote/favourites/viewfavouritesdata.dart';
import 'package:oro/data/model/viewfavouritesmodel.dart';

abstract class ViewFavouritesController extends GetxController {
  deleteFavourites(String itemId);
  goToItemDetails(itemModel);
  viewFavourites();
}

class ViewFavouritesControllerImp extends ViewFavouritesController {
  StatusRequest statusRequest = StatusRequest.none;
  final Services services = Get.find();
  final ViewFavouritesData viewFavouritesData = ViewFavouritesData(Get.find());
  final FavouritesData favouritesData = FavouritesData(Get.find());
  final List<ViewFavouritesModel> fav = [];
  final Map<String, bool> _deletingItems = {};

  @override
  Future<void> viewFavourites() async {
    final id = services.sharedPreferences.getString('id');
    fav.clear();
    if (id == null) {
      statusRequest = StatusRequest.none;
      update();
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    final response = await viewFavouritesData.viewFavouritesData(id);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success && response is Map) {
      final rows = response['data'];
      if (response['status'] == 'success' && rows is List) {
        fav.addAll(rows.whereType<Map>().map(
            (e) => ViewFavouritesModel.fromJson(Map<String, dynamic>.from(e))));
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  @override
  Future<void> deleteFavourites(String itemId) async {
    final id = services.sharedPreferences.getString('id');
    if (id == null || itemId.isEmpty || _deletingItems[itemId] == true) return;
    _deletingItems[itemId] = true;
    update();
    await Future.delayed(const Duration(milliseconds: 180));
    final response = await favouritesData.favouritesDelete(id, itemId);
    final state = handlingdata(response);
    if (state == StatusRequest.success &&
        response is Map &&
        response['status'] == 'success') {
      fav.removeWhere((element) => element.itemId.toString() == itemId);
    } else {
      Get.snackbar('No se pudo eliminar', 'Inténtalo nuevamente.');
    }
    _deletingItems.remove(itemId);
    update();
  }

  bool isDeleting(String itemId) => _deletingItems[itemId] ?? false;

  @override
  void onInit() {
    super.onInit();
    viewFavourites();
  }

  @override
  void goToItemDetails(itemModel) =>
      Get.toNamed(Approutes.itemDetails, arguments: {'itemsModel': itemModel});
}
