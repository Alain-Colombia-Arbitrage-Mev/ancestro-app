import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';

class AncestroInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;

  const AncestroInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
  });

  @override
  State<AncestroInput> createState() => _AncestroInputState();
}

class _AncestroInputState extends State<AncestroInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label — .pen: fontSize 12, color #ffffffe5
        Text(
          widget.label,
          style: AppTypography.caption.copyWith(
            color: AppColors.labelText,
          ),
        ),
        const SizedBox(height: 10),
        // Input — .pen: cornerRadius 16, fill #141414, stroke #1f1f1f, height 55
        SizedBox(
          height: 55,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && _obscureText,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.placeholderText,
                fontSize: 18,
              ),
              filled: true,
              fillColor: AppColors.inputFill,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.small),
                borderSide: BorderSide(color: AppColors.inputStroke, width: 1.18),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.small),
                borderSide: BorderSide(color: AppColors.inputStroke, width: 1.18),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.small),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.18),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: Icon(
                        widget.prefixIcon,
                        color: AppColors.placeholderText,
                        size: 20,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 20,
              ),
              suffixIcon: widget.isPassword
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.placeholderText,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
