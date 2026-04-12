import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';

class IntroScreen extends ConsumerWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.solar_power,
                size: 96,
                color: AppColors.primary,
              ),
              const SizedBox(height: 32),
              Text(
                'Your Solar Journey\nStarts Here',
                textAlign: TextAlign.center,
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ll guide you through every step to get clean, '
                'affordable energy for your home.',
                textAlign: TextAlign.center,
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              AncestroButton(
                label: 'Get Started',
                onPressed: () => context.go(RouteNames.solarProposal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
