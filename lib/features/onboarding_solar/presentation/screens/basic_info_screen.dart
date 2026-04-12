import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../domain/models/basic_info.dart';
import '../providers/solar_onboarding_notifier.dart';

class BasicInfoScreen extends ConsumerStatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  ConsumerState<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends ConsumerState<BasicInfoScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty &&
      _addressController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(RouteNames.solarProposal),
        ),
        title: Text(
          'Basic Information',
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
                'Tell us about yourself',
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 24),
              AncestroInput(
                label: 'Full Name',
                hint: 'John Doe',
                controller: _nameController,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Phone Number',
                hint: '(555) 000-0000',
                controller: _phoneController,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Property Address',
                hint: '123 Main St, City, State',
                controller: _addressController,
                prefixIcon: Icons.location_on_outlined,
              ),
              const Spacer(),
              ListenableBuilder(
                listenable: Listenable.merge(
                    [_nameController, _phoneController, _addressController]),
                builder: (context, _) {
                  return AncestroButton(
                    label: 'Continue',
                    enabled: _isValid,
                    onPressed: () {
                      ref
                          .read(solarOnboardingProvider.notifier)
                          .setBasicInfo(BasicInfo(
                            fullName: _nameController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                          ));
                      context.go(RouteNames.solarProperty);
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
}
