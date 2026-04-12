import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class InstantProposalScreen extends ConsumerWidget {
  const InstantProposalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final proposal = state.proposal;

    if (proposal == null) {
      return const Scaffold(
        body: Center(child: Text('No proposal available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarAlmostDone),
        ),
        title: Text(
          'Your Solar Proposal',
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildRow('System Size',
                      '${proposal.systemSizeKw.toStringAsFixed(1)} kW'),
                  _buildRow('Number of Panels',
                      '${proposal.numberOfPanels}'),
                  _buildRow('Annual Production',
                      '${proposal.estimatedAnnualProductionKwh.toStringAsFixed(0)} kWh'),
                  _buildRow('Monthly Savings',
                      '\$${proposal.monthlySavings.toStringAsFixed(2)}'),
                  _buildRow('Total Cost',
                      '\$${proposal.totalCost.toStringAsFixed(2)}'),
                  _buildRow('Monthly Payment',
                      '\$${proposal.monthlyPayment.toStringAsFixed(2)}'),
                  _buildRow('Coverage',
                      '${proposal.coverageYears} Years'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: AncestroButton(
                label: 'Continue to Checkout',
                onPressed: () => context.go(RouteNames.solarConfirm),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
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
      ),
    );
  }
}
