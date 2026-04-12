import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';
import 'ancestro_button.dart';

class AncestroModal {
  AncestroModal._();

  static Future<void> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String buttonLabel,
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.overlay,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.large),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.primaryTinted,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 32),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: AppTypography.subheading.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: buttonLabel,
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
