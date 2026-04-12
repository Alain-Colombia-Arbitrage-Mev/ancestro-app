import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../../domain/models/solar_onboarding_state.dart';
import '../providers/solar_onboarding_notifier.dart';

class ChooseFlowScreen extends ConsumerStatefulWidget {
  const ChooseFlowScreen({super.key});

  @override
  ConsumerState<ChooseFlowScreen> createState() => _ChooseFlowScreenState();
}

class _ChooseFlowScreenState extends ConsumerState<ChooseFlowScreen> {
  SystemType? _selected;

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: r.spacingXL),
                    Text(
                      'What are you interested in?',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingXS),
                    Text(
                      'Select the service that best fits your needs.',
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingXL),
                    _buildOption(
                      icon: Icons.solar_power,
                      title: 'Solar Energy',
                      subtitle: 'Power your home with the sun',
                      type: SystemType.solar,
                    ),
                    SizedBox(height: r.spacingSM),
                    _buildOption(
                      icon: Icons.electric_car,
                      title: 'EV Charging',
                      subtitle: 'Charge your vehicle at home',
                      type: SystemType.ev,
                    ),
                    SizedBox(height: r.spacingSM),
                    _buildOption(
                      icon: Icons.bolt,
                      title: 'Solar + EV',
                      subtitle: 'The complete energy package',
                      type: SystemType.both,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Continue',
                enabled: _selected != null,
                onPressed: () {
                  ref
                      .read(solarOnboardingProvider.notifier)
                      .selectSystemType(_selected!);
                  context.go(RouteNames.solarIntro);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required SystemType type,
  }) {
    final isSelected = _selected == type;
    return AncestroCard(
      selected: isSelected,
      onTap: () => setState(() => _selected = type),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppColors.primary, size: 24),
        ],
      ),
    );
  }
}
