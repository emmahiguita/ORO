import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class UpperView extends StatelessWidget {
  final Widget greeting;
  final Widget discountcard;
  final Widget serchBar;
  final Widget categorieslist;

  const UpperView(
      {super.key,
      required this.greeting,
      required this.discountcard,
      required this.serchBar,
      required this.categorieslist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/test.png",
              ),
              fit: BoxFit.cover),
          color: Appcolor.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      // padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          greeting,
          const SizedBox(height: 20),
          discountcard,
          const SizedBox(height: 30),
          serchBar,
          const SizedBox(height: 20),
          categorieslist,
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
