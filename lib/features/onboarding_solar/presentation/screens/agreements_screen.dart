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

class AgreementsScreen extends ConsumerStatefulWidget {
  const AgreementsScreen({super.key});

  @override
  ConsumerState<AgreementsScreen> createState() => _AgreementsScreenState();
}

class _AgreementsScreenState extends ConsumerState<AgreementsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAgreements();
  }

  Future<void> _loadAgreements() async {
    await ref.read(solarOnboardingProvider.notifier).loadAgreements();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    final state = ref.watch(solarOnboardingProvider);
    final allAccepted =
        state.agreements.isNotEmpty && state.agreements.every((a) => a.accepted);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarVerifyIdentity),
        ),
        title: Text(
          'Agreements',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primary))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.agreements.length,
                        separatorBuilder: (_, _) =>
                            SizedBox(height: r.spacingSM),
                        itemBuilder: (context, index) {
                          final agreement = state.agreements[index];
                          return AncestroCard(
                            onTap: () => context.go(
                              '/onboarding/solar/agreements/${agreement.id}',
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: agreement.accepted,
                                  activeColor: AppColors.primary,
                                  onChanged: (_) {
                                    ref
                                        .read(
                                            solarOnboardingProvider.notifier)
                                        .acceptAgreement(agreement.id);
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    agreement.title,
                                    style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.textPrimary),
                                  ),
                                ),
                                const Icon(Icons.chevron_right,
                                    color: AppColors.textTertiary),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    AncestroButton(
                      label: 'Continue',
                      enabled: allAccepted,
                      onPressed: () =>
                          context.go(RouteNames.solarLastStep),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
