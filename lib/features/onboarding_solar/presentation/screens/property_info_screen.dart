import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../domain/models/property_info.dart';
import '../providers/solar_onboarding_notifier.dart';

class PropertyInfoScreen extends ConsumerStatefulWidget {
  const PropertyInfoScreen({super.key});

  @override
  ConsumerState<PropertyInfoScreen> createState() => _PropertyInfoScreenState();
}

class _PropertyInfoScreenState extends ConsumerState<PropertyInfoScreen> {
  PropertyType _propertyType = PropertyType.singleFamily;
  final _roofSizeController = TextEditingController();
  final _consumptionController = TextEditingController();

  @override
  void dispose() {
    _roofSizeController.dispose();
    _consumptionController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _roofSizeController.text.isNotEmpty &&
      _consumptionController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarBasicInfo),
        ),
        title: Text(
          'Property Details',
          style:
              AppTypography.subheading.copyWith(color: AppColors.textPrimary),
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
                'About your property',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 24),
              Text(
                'Property Type',
                style: AppTypography.label
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<PropertyType>(
                initialValue: _propertyType,
                dropdownColor: AppColors.surface,
                style:
                    AppTypography.body.copyWith(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.inputFill,
                ),
                items: PropertyType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_propertyTypeLabel(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _propertyType = value);
                },
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Roof Size (sq ft)',
                hint: 'e.g. 1500',
                controller: _roofSizeController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.roofing,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Monthly Consumption (kWh)',
                hint: 'e.g. 900',
                controller: _consumptionController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.electric_bolt,
              ),
              const Spacer(),
              ListenableBuilder(
                listenable: Listenable.merge(
                    [_roofSizeController, _consumptionController]),
                builder: (context, _) {
                  return AncestroButton(
                    label: 'Continue',
                    enabled: _isValid,
                    onPressed: () {
                      ref
                          .read(solarOnboardingProvider.notifier)
                          .setPropertyInfo(PropertyInfo(
                            propertyType: _propertyType,
                            roofSizeSqFt:
                                double.tryParse(_roofSizeController.text) ??
                                    0,
                            monthlyConsumptionKwh:
                                double.tryParse(_consumptionController.text) ??
                                    0,
                          ));
                      context.go(RouteNames.solarAlmostDone);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _propertyTypeLabel(PropertyType type) {
    switch (type) {
      case PropertyType.singleFamily:
        return 'Single Family';
      case PropertyType.multiFamily:
        return 'Multi Family';
      case PropertyType.commercial:
        return 'Commercial';
      case PropertyType.other:
        return 'Other';
    }
  }
}
