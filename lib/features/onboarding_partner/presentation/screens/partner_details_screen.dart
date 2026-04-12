import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_stepper.dart';
import '../../domain/partner_field_definitions.dart';
import '../providers/partner_onboarding_notifier.dart';
import '../widgets/adaptive_form_field.dart';

class PartnerDetailsScreen extends ConsumerStatefulWidget {
  const PartnerDetailsScreen({super.key});

  @override
  ConsumerState<PartnerDetailsScreen> createState() =>
      _PartnerDetailsScreenState();
}

class _PartnerDetailsScreenState extends ConsumerState<PartnerDetailsScreen> {
  final Map<String, dynamic> _values = {};

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    final state = ref.watch(partnerOnboardingProvider);
    final notifier = ref.read(partnerOnboardingProvider.notifier);

    if (state.partnerType == null) {
      return const SizedBox.shrink();
    }

    final fields = partnerFieldDefinitions[state.partnerType!] ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () {
            notifier.previousStep();
            context.go(RouteNames.partnerContact);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AncestroStepper(totalSteps: 4, currentStep: 2),
              SizedBox(height: r.spacingLG),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Tell us more',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingXS),
                    Text(
                      'Provide details specific to your partner type',
                      textAlign: TextAlign.center,
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingLG),
                    ...fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: AdaptiveFormField(
                          config: field,
                          value: _values[field.key],
                          onChanged: (v) {
                            setState(() {
                              _values[field.key] = v;
                            });
                          },
                        ),
                      );
                    }),
                    SizedBox(height: r.spacingXS),
                  ],
                ),
              ),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  notifier.setDetails(_values);
                  notifier.nextStep();
                  context.go(RouteNames.partnerConfirm);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
