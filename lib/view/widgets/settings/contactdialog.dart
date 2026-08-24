import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oro/controller/setting/settingcontroller.dart';
import 'package:oro/core/constant/color.dart';

class ContactDialog extends StatelessWidget {
  final SettingControllerImp controller;

  const ContactDialog({super.key, required this.controller});

  static void show(SettingControllerImp controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ContactDialog(controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.support_agent,
            size: 50,
            color: Appcolor.indigoBlue,
          ),
          const SizedBox(height: 20),
          const Text(
            "Contáctanos",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Appcolor.indigoBlue,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "How would you like to contact us?",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text("WhatsApp"),
                  onPressed: () {
                    Get.back();
                    controller.contactus(0);
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.indigoBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  icon: const Icon(
                    Icons.sms,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text("SMS"),
                  onPressed: () {
                    Get.back();
                    controller.contactus(1);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextButton(
            child: Text(
              "Cancelar",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
