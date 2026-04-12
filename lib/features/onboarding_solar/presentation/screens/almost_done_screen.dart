import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class AlmostDoneScreen extends ConsumerStatefulWidget {
  const AlmostDoneScreen({super.key});

  @override
  ConsumerState<AlmostDoneScreen> createState() => _AlmostDoneScreenState();
}

class _AlmostDoneScreenState extends ConsumerState<AlmostDoneScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarProperty),
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
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: r.spacingXL),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryTinted,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: r.spacingLG),
                      Text(
                        'Just one more step!',
                        style: AppTypography.heading
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: r.spacingSM),
                      Text(
                        'We have everything we need to generate '
                        'your personalized solar proposal.',
                        textAlign: TextAlign.center,
                        style: AppTypography.body
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Generate My Proposal',
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() => _isLoading = true);
                  await ref
                      .read(solarOnboardingProvider.notifier)
                      .generateProposal();
                  if (!context.mounted) return;
                  setState(() => _isLoading = false);
                  context.go(RouteNames.solarInstantProposal);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
