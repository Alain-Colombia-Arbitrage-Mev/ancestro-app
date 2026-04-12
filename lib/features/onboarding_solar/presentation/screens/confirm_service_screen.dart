import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../providers/solar_onboarding_notifier.dart';

class ConfirmServiceScreen extends ConsumerWidget {
  const ConfirmServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final proposal = state.proposal;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarInstantProposal),
        ),
        title: Text(
          'Confirm Service',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
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
                'Service Summary',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 24),
              if (proposal != null)
                AncestroCard(
                  child: Column(
                    children: [
                      _summaryRow('System Size',
                          '${proposal.systemSizeKw.toStringAsFixed(1)} kW'),
                      const SizedBox(height: 12),
                      _summaryRow(
                          'Panels', '${proposal.numberOfPanels}'),
                      const SizedBox(height: 12),
                      _summaryRow('Monthly Payment',
                          '\$${proposal.monthlyPayment.toStringAsFixed(2)}'),
                      const SizedBox(height: 12),
                      _summaryRow('Coverage',
                          '${proposal.coverageYears} Years'),
                    ],
                  ),
                ),
              const Spacer(),
              AncestroButton(
                label: 'Confirm & Activate Services',
                onPressed: () => context.go(RouteNames.solarCredit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style:
              AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
