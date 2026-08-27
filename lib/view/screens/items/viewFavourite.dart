import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/ViewFavouritesController.dart';
import 'package:oro/view/widgets/items/favouriteslist.dart';

class ViewFavourite extends StatelessWidget {
  const ViewFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          "Favoritos",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ViewFavouritesControllerImp>(
        init: ViewFavouritesControllerImp(),
        builder: (controller) => FavouritesList(controller: controller),
      ),
    );
  }
}
