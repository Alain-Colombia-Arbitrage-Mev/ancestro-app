import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../providers/solar_onboarding_notifier.dart';

class ConfirmInspectionScreen extends ConsumerWidget {
  const ConfirmInspectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final inspection = state.inspection;
    final basicInfo = state.basicInfo;
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarSchedule),
        ),
        title: Text(
          'Confirm Inspection',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Summary',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 24),
                    if (inspection != null)
                      AncestroCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(Icons.calendar_today, 'Date',
                                dateFormat.format(inspection.date)),
                            const SizedBox(height: 16),
                            _infoRow(Icons.access_time, 'Time',
                                inspection.timeSlot),
                            const SizedBox(height: 16),
                            _infoRow(Icons.location_on, 'Address',
                                basicInfo?.address ?? 'N/A'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: AncestroButton(
                label: 'Confirm',
                onPressed: () => context.go(RouteNames.solarInspector),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.caption
                    .copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
