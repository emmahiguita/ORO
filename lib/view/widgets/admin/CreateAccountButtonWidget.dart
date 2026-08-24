import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:oro/controller/admin/settings/createnewadminaccountcontroller.dart';
import 'package:oro/core/constant/color.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  final CreateNewAdminAccountControllerImp controller;

  const CreateAccountButtonWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewAdminAccountControllerImp>(
      builder: (ctrl) => Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Appcolor.berry,
              Appcolor.berry.withValues(alpha: 0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Appcolor.berry.withValues(alpha: 0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: ctrl.isLoading != true
                ? () {
                    controller.createNewAccount();
                  }
                : null,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ctrl.isLoading == true) ...[
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Icon(
                    ctrl.isLoading == true ? null : Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 20,
                  ),
                  if (ctrl.isLoading != true) const SizedBox(width: 8),
                  Text(
                    ctrl.isLoading == true
                        ? 'Creating Admin Account...'
                        : 'Create Administrator Account',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
