import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';

class IntroScreen extends ConsumerWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
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
                      const Icon(
                        Icons.solar_power,
                        size: 96,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: r.spacingXL),
                      Text(
                        'Your Solar Journey\nStarts Here',
                        textAlign: TextAlign.center,
                        style: AppTypography.heading
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: r.spacingMD),
                      Text(
                        'We\'ll guide you through every step to get clean, '
                        'affordable energy for your home.',
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
                label: 'Get Started',
                onPressed: () => context.go(RouteNames.solarProposal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
