import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../../data/mock_solar_repository.dart';
import '../providers/solar_onboarding_notifier.dart';

class ScheduleInspectionScreen extends ConsumerStatefulWidget {
  const ScheduleInspectionScreen({super.key});

  @override
  ConsumerState<ScheduleInspectionScreen> createState() =>
      _ScheduleInspectionScreenState();
}

class _ScheduleInspectionScreenState
    extends ConsumerState<ScheduleInspectionScreen> {
  List<DateTime> _dates = [];
  DateTime? _selectedDate;
  String _selectedTimeSlot = '9:00 AM - 12:00 PM';
  bool _isLoading = true;

  static const _timeSlots = [
    '9:00 AM - 12:00 PM',
    '12:00 PM - 3:00 PM',
    '3:00 PM - 6:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _loadDates();
  }

  Future<void> _loadDates() async {
    final repo = MockSolarRepository();
    final dates = await repo.getAvailableInspectionDates();
    if (mounted) {
      setState(() {
        _dates = dates;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, MMM d');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarPropertyReview),
        ),
        title: Text(
          'Schedule Inspection',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primary))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select a Date',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        itemCount: _dates.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final date = _dates[index];
                          final isSelected = _selectedDate == date;
                          return AncestroCard(
                            selected: isSelected,
                            onTap: () =>
                                setState(() => _selectedDate = date),
                            child: Text(
                              dateFormat.format(date),
                              style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textPrimary),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Select a Time Slot',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedTimeSlot,
                      dropdownColor: AppColors.surface,
                      style: AppTypography.body
                          .copyWith(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputFill,
                      ),
                      items: _timeSlots.map((slot) {
                        return DropdownMenuItem(
                          value: slot,
                          child: Text(slot),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedTimeSlot = value);
                        }
                      },
                    ),
                    const Spacer(),
                    AncestroButton(
                      label: 'Continue',
                      enabled: _selectedDate != null,
                      onPressed: () async {
                        await ref
                            .read(solarOnboardingProvider.notifier)
                            .scheduleInspection(
                                _selectedDate!, _selectedTimeSlot);
                        if (!context.mounted) return;
                        context.go(RouteNames.solarConfirmInspection);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
