import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../domain/models/property_photo.dart';

class LastStepScreen extends ConsumerWidget {
  const LastStepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarAgreements),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Property Photos',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Take photos of the following areas of your property.',
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              _buildCategoryButton(
                icon: Icons.roofing,
                label: 'Roof Front',
                category: PhotoCategory.roofFront,
              ),
              const SizedBox(height: 12),
              _buildCategoryButton(
                icon: Icons.roofing,
                label: 'Roof Back',
                category: PhotoCategory.roofBack,
              ),
              const SizedBox(height: 12),
              _buildCategoryButton(
                icon: Icons.electrical_services,
                label: 'Electrical Panel',
                category: PhotoCategory.electricalPanel,
              ),
              const SizedBox(height: 12),
              _buildCategoryButton(
                icon: Icons.speed,
                label: 'Meter',
                category: PhotoCategory.meter,
              ),
              const Spacer(),
              AncestroButton(
                label: 'Continue',
                onPressed: () => context.go(RouteNames.solarPropertyReview),
              ),
            ],
          ),
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
