import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../domain/models/property_photo.dart';

class LastStepScreen extends ConsumerWidget {
  const LastStepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarAgreements),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Property Photos',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingXS),
                    Text(
                      'Take photos of the following areas of your property.',
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingXL),
                    _buildCategoryButton(
                      icon: Icons.roofing,
                      label: 'Roof Front',
                      category: PhotoCategory.roofFront,
                    ),
                    SizedBox(height: r.spacingSM),
                    _buildCategoryButton(
                      icon: Icons.roofing,
                      label: 'Roof Back',
                      category: PhotoCategory.roofBack,
                    ),
                    SizedBox(height: r.spacingSM),
                    _buildCategoryButton(
                      icon: Icons.electrical_services,
                      label: 'Electrical Panel',
                      category: PhotoCategory.electricalPanel,
                    ),
                    SizedBox(height: r.spacingSM),
                    _buildCategoryButton(
                      icon: Icons.speed,
                      label: 'Meter',
                      category: PhotoCategory.meter,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Continue',
                onPressed: () => context.go(RouteNames.solarPropertyReview),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton({
    required IconData icon,
    required String label,
    required PhotoCategory category,
  }) {
    return GestureDetector(
      onTap: () {
        // Placeholder for image picker
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.camera_alt_outlined,
                color: AppColors.textTertiary, size: 24),
          ],
        ),
      ),
    );
  }
}
