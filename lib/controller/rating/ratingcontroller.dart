import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/rating/ratingdata.dart';
import 'package:oro/data/model/ratingmodel.dart';

abstract class RatingController extends GetxController {
  deleteRating(String ratingId, int index);
}

class RatingControllerImp extends RatingController {
  List<RatingModel> allRating = [];
  Services services = Get.find();
  late String id;
  RatingData ratingData = RatingData(Get.find());
  late StatusRequest statusRequest;

  List<bool> isFading = [];

  void initializeFadingList() {
    isFading = List.generate(allRating.length, (_) => false);
  }

  @override
  void onInit() {
    allRating = Get.arguments["allRating"];
    id = services.sharedPreferences.getString("id")!;
    isFading = List.generate(allRating.length, (_) => true);
    super.onInit();

    Future.delayed(const Duration(milliseconds: 100), () {
      for (int i = 0; i < isFading.length; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          isFading[i] = false;
          update();
        });
      }
    });
  }

  @override
  deleteRating(ratingId, index) async {
    isFading[index] = true;
    update();
    await Future.delayed(const Duration(milliseconds: 300));

    statusRequest = StatusRequest.loding;
    var response = await ratingData.deleteRating(id, ratingId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        allRating.removeAt(index);
        isFading.removeAt(index);
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        isFading[index] = false;
      }
    }
    update();
  }
}
