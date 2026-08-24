import 'package:flutter/material.dart';
import 'package:oro/controller/setting/updateaccountinformationcontroller.dart';
import 'package:oro/core/constant/color.dart';

class SaveChangesButton extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const SaveChangesButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.updateAccountInformation();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.berry,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Guardar cambios',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
