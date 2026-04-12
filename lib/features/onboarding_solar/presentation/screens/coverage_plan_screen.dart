import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';

class CoveragePlanScreen extends ConsumerWidget {
  const CoveragePlanScreen({super.key});

  static const _coverageItems = [
    'Panel performance warranty',
    'Inverter replacement coverage',
    'Annual system inspections',
    'Monitoring and maintenance',
    'Roof penetration warranty',
    'Storm and weather damage',
    'System removal and reinstallation',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarCredit),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '20 Year Coverage',
                    textAlign: TextAlign.center,
                    style: AppTypography.heading
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: r.spacingXS),
                  Text(
                    'Your system is fully protected.',
                    textAlign: TextAlign.center,
                    style:
                        AppTypography.body.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: r.spacingLG),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _coverageItems.length,
                separatorBuilder: (context, index) => SizedBox(height: r.spacingMD),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: AppColors.success, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _coverageItems[index],
                          style: AppTypography.body
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: AncestroButton(
                label: 'Proceed to Checkout',
                onPressed: () => context.go(RouteNames.solarReserve),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
