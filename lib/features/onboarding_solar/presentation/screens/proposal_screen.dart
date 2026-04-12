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
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColors.textPrimary, size: 20),
                  onPressed: () => context.go(RouteNames.solarIntro),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 48),
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
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: AncestroButton(
                  label: 'Continue',
                  onPressed: () => context.go(RouteNames.solarBasicInfo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
