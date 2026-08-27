import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/handlingdata.dart';
import 'package:oro/core/services/services.dart';
import 'package:oro/data/datasource/remote/cart/cartdata.dart';
import 'package:oro/data/datasource/remote/rating/ratingdata.dart';
import 'package:oro/data/model/ratingmodel.dart';
import 'package:oro/view/screens/items/viewrating.dart';
import 'package:oro/view/widgets/items/form.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:oro/apilink.dart';
import 'package:path_provider/path_provider.dart';

abstract class ItemsDetailsController extends GetxController {
  initiateData();
  addCart(String itemId);
  add();
  remove();
  addRating(String itemid, String stars, String comment);
  getRating();
  getIsOrdered();
  goToAllRating();
  Future<void> shareProductWithImage();
}

class ItemsDetailsControllerImp extends ItemsDetailsController {
  int counter = 1;
  dynamic data;
  late StatusRequest statusRequest;
  CartData cartData = CartData(Get.find());
  Services services = Get.find();
  RatingData ratingData = RatingData(Get.find());
  TextEditingController? comment;
  final GlobalKey<AnimatedCommentFieldState> commentKey = GlobalKey();
  double stars = 3;
  List<RatingModel> allRating = [];
  bool isOrdered = false;
  late StatusRequest ratingStatusRequest;

  @override
  void onInit() {
    comment = TextEditingController();
    initiateData();
    getRating();
    getIsOrdered();
    super.onInit();
  }

  @override
  void onClose() {
    comment?.dispose();
    super.onClose();
  }

  @override
  initiateData() async {
    statusRequest = StatusRequest.loding;
    final args = Get.arguments;
    if (args is Map && args['itemsModel'] != null) {
      data = args['itemsModel'];
    } else if (args != null) {
      data = args;
    }
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  addCart(itemId) async {
    statusRequest = StatusRequest.loding;
    dynamic response;
    final userId = services.sharedPreferences.getString("id") ?? '';
    for (int i = 0; i < counter; i++) {
      response = await cartData.cartAdd(userId, itemId);
    }
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Added To Cart",
          "This item has been successfully added to your cart!",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.add_shopping_cart_rounded),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  add() {
    counter++;
    update();
  }

  @override
  remove() {
    if (counter > 1) {
      counter--;
      update();
    }
  }

  @override
  addRating(itemid, stars, comment) async {
    statusRequest = StatusRequest.loding;
    final userId = services.sharedPreferences.getString("id") ?? '';
    var response = await ratingData.addRating(
      userId,
      itemid,
      stars,
      comment,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        if (Get.isRegistered<ItemscontrollerImp>()) {
          final itemsCtrl = Get.find<ItemscontrollerImp>();
          itemsCtrl.statusRequest = StatusRequest.loding;
          itemsCtrl.getData("${data.itemCat}");
        }
        await getRating();
        Get.back();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getRating() async {
    ratingStatusRequest = StatusRequest.loding;
    allRating.clear();
    final itemIdStr = data?.itemId?.toString() ?? '';
    if (itemIdStr.isEmpty) {
      ratingStatusRequest = StatusRequest.failure;
      update();
      return;
    }
    var response = await ratingData.getRating(itemIdStr);
    ratingStatusRequest = handlingdata(response);
    if (ratingStatusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List listData = response['data'] ?? [];
        allRating.addAll(
          listData.map(
            (e) => RatingModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        ratingStatusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getIsOrdered() async {
    final userId = services.sharedPreferences.getString("id") ?? '';
    final itemIdStr = data?.itemId?.toString() ?? '';
    if (userId.isEmpty || itemIdStr.isEmpty) {
      isOrdered = false;
      update();
      return;
    }
    var response = await ratingData.isOrdered(
      userId,
      itemIdStr,
    );
    if (response["status"] == "success") {
      isOrdered = true;
    } else if (response["status"] == "failure") {
      isOrdered = false;
    }
    update();
  }

  @override
  goToAllRating() {
    Get.to(
      () => const ViewRating(),
      arguments: {"allRating": allRating},
    );
  }

  void showReviewDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Appcolor.amaranthpink.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.star_rounded,
                color: Appcolor.amaranthpink,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Leave a Review',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How would you rate your experience?',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 42,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    glow: true,
                    glowColor: Appcolor.amaranthpink.withValues(alpha: 0.3),
                    unratedColor: Colors.grey[300],
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Appcolor.amaranthpink,
                      size: 42,
                    ),
                    onRatingUpdate: (rating) {
                      stars = rating;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Share more about your experience',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              AnimatedCommentField(
                controller: comment!,
                key: commentKey,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.amaranthpink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    if (comment!.text == "") {
                      commentKey.currentState?.triggerShake();
                      Get.snackbar(
                        'Required',
                        'Please write your review',
                        colorText: Appcolor.charcoalGray,
                        backgroundColor: Appcolor.rosePompadour,
                        icon: const Icon(Icons.error_rounded),
                      );
                      return;
                    }

                    await addRating(data.itemId.toString(), stars.toString(),
                        comment!.text);
                    Get.back(closeOverlays: true);
                  },
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> shareProductWithImage() async {
    try {
      final imgName = data?.itemImg?.toString() ?? '';
      final response = await Dio().get(
        AppLink.itemimage + imgName,
        options: Options(responseType: ResponseType.bytes),
      );

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/product_share.jpg').create();
      await file.writeAsBytes(response.data);

      final name = data?.itemName?.toString() ?? 'ORO Product';
      final desc = data?.itemDesc?.toString() ?? '';
      final price = data?.itemFinalPrice ?? data?.itemPrice ?? 0.0;
      final discount = data?.itemDiscount ?? 0;
      final avgRating =
          double.tryParse(data?.itemAvgRating?.toString() ?? '0') ?? 0.0;

      String shareText = '''
🌟 Check out this amazing product: $name!

$desc

💰 Price: \$${price.toStringAsFixed(2)} ${discount > 0 ? '(Was \$${(data?.itemPrice ?? 0.0).toStringAsFixed(2)}, now $discount% off!)' : ''}

${avgRating > 0 ? '⭐ Rating: ${avgRating.toStringAsFixed(1)}/5' : ''}

Don't miss out!
''';

      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: shareText,
        subject: 'Check out $name',
      ));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not share the product',
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.error),
      );
    }
  }
}
