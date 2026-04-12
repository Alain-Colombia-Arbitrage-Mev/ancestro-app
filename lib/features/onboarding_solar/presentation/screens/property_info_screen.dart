import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
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
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'About your property',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingLG),
                    Text(
                      'Property Type',
                      style: AppTypography.label
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingXS),
                    DropdownButtonFormField<PropertyType>(
                      initialValue: _propertyType,
                      dropdownColor: AppColors.surface,
                      style: AppTypography.body
                          .copyWith(color: AppColors.textPrimary),
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
                    SizedBox(height: r.spacingMD),
                    AncestroInput(
                      label: 'Roof Size (sq ft)',
                      hint: 'e.g. 1500',
                      controller: _roofSizeController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.roofing,
                    ),
                    SizedBox(height: r.spacingMD),
                    AncestroInput(
                      label: 'Monthly Consumption (kWh)',
                      hint: 'e.g. 900',
                      controller: _consumptionController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.electric_bolt,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: ListenableBuilder(
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
                                double.tryParse(_roofSizeController.text) ?? 0,
                            monthlyConsumptionKwh:
                                double.tryParse(_consumptionController.text) ??
                                    0,
                          ));
                      context.go(RouteNames.solarAlmostDone);
                    },
                  );
                },
              ),
            ),
          ],
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
