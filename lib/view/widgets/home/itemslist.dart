import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/hotdealsheader.dart';
import 'package:oro/view/widgets/home/itemcard.dart';
import 'package:oro/view/widgets/home/loadingitemstate.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HotDealsHeader(),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columns = width >= 1050
                    ? 4
                    : width >= 720
                        ? 3
                        : 2;
                return MasonryGridView.count(
                  itemCount: controller.statusRequest == StatusRequest.loding
                      ? columns * 3
                      : controller.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: columns,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  itemBuilder: (context, index) {
                    if (controller.statusRequest == StatusRequest.loding) {
                      return const LoadingItemState();
                    }
                    final model = ItemsModel.fromJson(controller.items[index]);
                    return ItemCard(
                      itemsModel: model,
                      onTap: () => controller.goToItemDetails(model),
                      colorIndex: index % controller.gradientColors.length,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
