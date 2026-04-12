import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onPhonePressed;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onPhonePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SocialButton(
          icon: Icons.g_mobiledata,
          onPressed: isLoading ? null : onGooglePressed,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.apple,
          onPressed: isLoading ? null : onApplePressed,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.phone,
          onPressed: isLoading ? null : onPhonePressed,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 52,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.surfaceBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.small),
            ),
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 24),
        ),
      ),
    );
  }
}
