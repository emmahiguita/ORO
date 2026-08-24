import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/class/statusrequest.dart';

class AUTHAppbar<T extends GetxController> extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final T controller;
  final StatusRequest Function(T controller) statusRequest;

  const AUTHAppbar({
    super.key,
    required this.text,
    required this.controller,
    required this.statusRequest,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: controller,
      builder: (ctrl) {
        return AppBar(
          centerTitle: true,
          title: Text(text),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
