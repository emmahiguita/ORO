import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/bottombar.dart';
import 'package:oro/view/widgets/items/productdetailsappbartitle.dart';
import 'package:oro/view/widgets/items/productimagesection.dart';
import 'package:oro/view/widgets/items/productinfocard.dart';
import 'package:oro/view/widgets/items/reviewsection.dart';
import 'package:oro/view/widgets/items/sharebutton.dart';
import 'package:oro/view/widgets/items/specificationscard.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsDetailsControllerImp>(
      init: ItemsDetailsControllerImp(),
      builder: (controller) {
        if (controller.data == null) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const ProductDetailsAppBarTitle(),
            centerTitle: true,
            actions: [ShareButton(controller: controller)],
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: ProductImageSection(controller: controller),
              ),
              SliverToBoxAdapter(
                child: ProductInfoCard(controller: controller),
              ),
              SliverToBoxAdapter(
                child: SpecificationsCard(controller: controller),
              ),
              SliverToBoxAdapter(
                child: ReviewSection(controller: controller),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),
          bottomSheet: BottomBar(controller: controller),
        );
      },
    );
  }
}
