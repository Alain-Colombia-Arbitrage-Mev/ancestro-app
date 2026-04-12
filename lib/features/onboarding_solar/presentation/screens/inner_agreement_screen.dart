import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class InnerAgreementScreen extends ConsumerWidget {
  final String agreementId;

  const InnerAgreementScreen({super.key, required this.agreementId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final agreement = state.agreements.where((a) => a.id == agreementId).firstOrNull;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarAgreements),
        ),
        title: Text(
          agreement?.title ?? 'Agreement',
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    agreement?.content ?? 'Agreement not found.',
                    style: AppTypography.body
                        .copyWith(color: AppColors.textSecondary, height: 1.6),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  if (agreement != null) {
                    ref
                        .read(solarOnboardingProvider.notifier)
                        .acceptAgreement(agreement.id);
                  }
                  context.go(RouteNames.solarAgreements);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
