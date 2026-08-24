import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/constant/imageasset.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    Widget overlayWidget;

    switch (statusRequest) {
      case StatusRequest.loding:
        overlayWidget = Center(
          child: Container(
            color: const Color.fromARGB(186, 0, 0, 0),
            height: double.infinity,
            width: double.infinity,
            child: Lottie.asset(AppImage.loading),
          ),
        );
        break;
      case StatusRequest.offlinefailure:
        overlayWidget = Center(child: Lottie.asset(AppImage.offline));
        break;
      case StatusRequest.serverfailure:
        overlayWidget = Center(child: Lottie.asset(AppImage.e404));
        break;
      default:
        overlayWidget =
            Container(); // Empty container when no overlay is needed
    }

    return Scaffold(
      backgroundColor: Appcolor.white,
      body: Stack(
        children: [
          widget,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: overlayWidget,
          ),
        ],
      ),
    );
  }
}
