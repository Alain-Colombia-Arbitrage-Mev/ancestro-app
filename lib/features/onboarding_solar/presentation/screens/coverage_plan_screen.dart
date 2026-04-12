import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarCredit),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '20 Year Coverage',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Your system is fully protected.',
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _coverageItems.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
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
              AncestroButton(
                label: 'Proceed to Checkout',
                onPressed: () => context.go(RouteNames.solarReserve),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
