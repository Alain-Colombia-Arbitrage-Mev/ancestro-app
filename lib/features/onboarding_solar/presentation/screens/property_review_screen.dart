import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';

class PropertyReviewScreen extends ConsumerWidget {
  const PropertyReviewScreen({super.key});

  static const _reviewResults = {
    'Roof Condition': 'Good - suitable for installation',
    'Electrical Panel': '200A - meets requirements',
    'Shading': 'Minimal - excellent sun exposure',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarLastStep),
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
                      'Here\'s what we found',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingXS),
                    Text(
                      'Our review of your property photos is complete.',
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingLG),
                    ..._reviewResults.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AncestroCard(
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: AppColors.success, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: AppTypography.bodyMedium
                                          .copyWith(
                                              color: AppColors.textPrimary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      entry.value,
                                      style: AppTypography.caption.copyWith(
                                          color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Continue',
                onPressed: () => context.go(RouteNames.solarSchedule),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
