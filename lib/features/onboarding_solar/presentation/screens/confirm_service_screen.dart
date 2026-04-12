import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../providers/solar_onboarding_notifier.dart';

class ConfirmServiceScreen extends ConsumerWidget {
  const ConfirmServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    final state = ref.watch(solarOnboardingProvider);
    final proposal = state.proposal;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
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
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Service Summary',
                            textAlign: TextAlign.center,
                            style: AppTypography.heading
                                .copyWith(color: AppColors.textPrimary),
                          ),
                    SizedBox(height: r.spacingLG),
                    if (proposal != null)
                      AncestroCard(
                        child: Column(
                          children: [
                            _summaryRow('System Size',
                                '${proposal.systemSizeKw.toStringAsFixed(1)} kW'),
                            SizedBox(height: r.spacingSM),
                            _summaryRow(
                                'Panels', '${proposal.numberOfPanels}'),
                            SizedBox(height: r.spacingSM),
                            _summaryRow('Monthly Payment',
                                '\$${proposal.monthlyPayment.toStringAsFixed(2)}'),
                            SizedBox(height: r.spacingSM),
                            _summaryRow('Coverage',
                                '${proposal.coverageYears} Years'),
                          ],
                        ),
                      ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: AncestroButton(
                label: 'Confirm & Activate Services',
                onPressed: () => context.go(RouteNames.solarCredit),
              ),
            ),
          ],
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
