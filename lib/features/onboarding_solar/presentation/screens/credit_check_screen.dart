import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../domain/models/solar_onboarding_state.dart';
import '../providers/solar_onboarding_notifier.dart';

class CreditCheckScreen extends ConsumerStatefulWidget {
  const CreditCheckScreen({super.key});

  @override
  ConsumerState<CreditCheckScreen> createState() => _CreditCheckScreenState();
}

class _CreditCheckScreenState extends ConsumerState<CreditCheckScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _runCreditCheck();
  }

  Future<void> _runCreditCheck() async {
    await ref.read(solarOnboardingProvider.notifier).checkCredit();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    final state = ref.watch(solarOnboardingProvider);
    final isApproved = state.creditStatus == CreditStatus.approved;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarConfirm),
        ),
        title: Text(
          'Credit Check',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
            : Column(
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
                                  Center(
                                    child: Icon(
                                      isApproved
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      size: 80,
                                      color: isApproved
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                  ),
                                  SizedBox(height: r.spacingLG),
                                  Text(
                                    isApproved ? 'Approved!' : 'Not Approved',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.heading
                                        .copyWith(color: AppColors.textPrimary),
                                  ),
                                  SizedBox(height: r.spacingSM),
                                  Text(
                                    isApproved
                                        ? 'Your credit has been approved. You\'re ready '
                                            'to proceed with your solar installation.'
                                        : 'Unfortunately, we couldn\'t approve your credit '
                                            'at this time. Please contact us for alternatives.',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.body
                                        .copyWith(color: AppColors.textSecondary),
                                  ),
                                  if (isApproved) ...[
                                    SizedBox(height: r.spacingXL),
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceVariant,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Production Chart Placeholder',
                                          style: AppTypography.caption.copyWith(
                                              color: AppColors.textTertiary),
                                        ),
                                      ),
                                    ),
                                  ],
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
                        label: 'Continue',
                        onPressed: isApproved
                            ? () => context.go(RouteNames.solarCoverage)
                            : null,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
