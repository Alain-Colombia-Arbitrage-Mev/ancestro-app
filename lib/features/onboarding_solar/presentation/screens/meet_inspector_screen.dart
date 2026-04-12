import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class MeetInspectorScreen extends ConsumerWidget {
  const MeetInspectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final inspection = state.inspection;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarConfirmInspection),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceVariant,
                ),
                child: const Icon(
                  Icons.person,
                  size: 48,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                inspection?.inspectorName ?? 'Your Inspector',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Solar Installation Inspector',
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              if (inspection?.inspectorPhone != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone,
                        color: AppColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      inspection!.inspectorPhone!,
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              const Spacer(),
              AncestroButton(
                label: 'Done',
                onPressed: () async {
                  await ref
                      .read(solarOnboardingProvider.notifier)
                      .complete();
                  if (context.mounted) {
                    context.go(RouteNames.home);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
