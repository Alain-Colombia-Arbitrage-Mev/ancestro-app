import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';

class ReserveSystemScreen extends ConsumerWidget {
  const ReserveSystemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarCoverage),
        ),
        title: Text(
          'Reserve Your System',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
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
                      'Payment Method',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 24),
                    AncestroCard(
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.credit_card,
                                color: AppColors.textTertiary, size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '**** **** **** 4242',
                                  style: AppTypography.bodyMedium
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                                Text(
                                  'Visa - Expires 12/28',
                                  style: AppTypography.caption
                                      .copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle,
                              color: AppColors.primary, size: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Reserve',
                onPressed: () => context.go(RouteNames.solarReserving),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
