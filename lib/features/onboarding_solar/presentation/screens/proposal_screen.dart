import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';

class ProposalScreen extends ConsumerWidget {
  const ProposalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    onPressed: () => context.go(RouteNames.solarIntro),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.solar_power_outlined,
                  size: 80,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Let\'s Build Your\nSolar Proposal',
                  textAlign: TextAlign.center,
                  style: AppTypography.heading
                      .copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 12),
                Text(
                  'Answer a few questions and we\'ll create '
                  'a personalized solar plan for your home.',
                  textAlign: TextAlign.center,
                  style: AppTypography.body
                      .copyWith(color: AppColors.textSecondary),
                ),
                const Spacer(),
                AncestroButton(
                  label: 'Continue',
                  onPressed: () => context.go(RouteNames.solarBasicInfo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
