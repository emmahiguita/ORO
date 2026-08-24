import 'package:flutter/material.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onPressed;
  final StatusRequest statusRequest;
  const SaveButton({super.key, this.onPressed, required this.statusRequest});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: statusRequest == StatusRequest.loding,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: statusRequest == StatusRequest.loding
              ? Appcolor.grey
              : Appcolor.pink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.transparent, // Set transparent here
            shadowColor: Colors.transparent, // So it doesn't double shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            height: 28,
            child: statusRequest == StatusRequest.loding
                ? const GradientProgressIndicator(strokeWidth: 2)
                : const Text(
                    'Save Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
