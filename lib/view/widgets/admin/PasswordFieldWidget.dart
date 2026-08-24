import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:oro/controller/admin/settings/createnewadminaccountcontroller.dart';
import 'package:oro/core/constant/color.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final bool isConfirmPassword;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.isConfirmPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewAdminAccountControllerImp>(
      builder: (ctrl) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: ctrl.isPasswordHidden ?? true,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
              suffixIcon: isConfirmPassword
                  ? null
                  : IconButton(
                      onPressed: () {
                        ctrl.togglePasswordVisibility();
                      },
                      icon: Icon(
                        (ctrl.isPasswordHidden ?? true)
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[600],
                      ),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Appcolor.berry, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          if (!isConfirmPassword) ...[
            const SizedBox(height: 8),
            Text(
              'Use a strong password with at least 8 characters, including uppercase, lowercase, numbers, and symbols',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
