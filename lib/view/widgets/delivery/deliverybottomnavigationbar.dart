import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/controller/delivery/deliveryhomecontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/navitem.dart';

class DeliveryBottomNavigationBar extends StatelessWidget {
  const DeliveryBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryHomeControllerImp>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 106,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
                spreadRadius: -4,
              ),
              BoxShadow(
                color: Appcolor.berry.withValues(alpha: 0.08),
                blurRadius: 40,
                offset: const Offset(0, 8),
                spreadRadius: -8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  controller.listpages.length,
                  (index) => NavItem(
                    controller: controller,
                    index: index,
                    icon: controller.iconpages[index],
                    label: controller.namepages[index],
                    isActive: controller.currentpage == index,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      controller.changePage(index);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
