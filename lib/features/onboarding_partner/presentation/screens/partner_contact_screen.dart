import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../../../core/widgets/ancestro_stepper.dart';
import '../../domain/models/partner_contact.dart';
import '../providers/partner_onboarding_notifier.dart';

class PartnerContactScreen extends ConsumerStatefulWidget {
  const PartnerContactScreen({super.key});

  @override
  ConsumerState<PartnerContactScreen> createState() =>
      _PartnerContactScreenState();
}

class _PartnerContactScreenState extends ConsumerState<PartnerContactScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _fullNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty &&
      _countryController.text.isNotEmpty &&
      _cityController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(partnerOnboardingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () {
            notifier.previousStep();
            context.go(RouteNames.partnerProfile);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const AncestroStepper(totalSteps: 4, currentStep: 1),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Contact Information',
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tell us how to reach you',
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    AncestroInput(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      controller: _fullNameController,
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    AncestroInput(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    AncestroInput(
                      label: 'Phone',
                      hint: 'Enter your phone number',
                      controller: _phoneController,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    AncestroInput(
                      label: 'Country',
                      hint: 'Enter your country',
                      controller: _countryController,
                      prefixIcon: Icons.public,
                    ),
                    const SizedBox(height: 16),
                    AncestroInput(
                      label: 'City',
                      hint: 'Enter your city',
                      controller: _cityController,
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: 16),
                    AncestroInput(
                      label: 'Company (Optional)',
                      hint: 'Enter your company name',
                      controller: _companyController,
                      prefixIcon: Icons.business,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  if (!_isValid) return;
                  final contact = PartnerContact(
                    fullName: _fullNameController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    country: _countryController.text,
                    city: _cityController.text,
                    company: _companyController.text.isNotEmpty
                        ? _companyController.text
                        : null,
                  );
                  notifier.setContact(contact);
                  notifier.nextStep();
                  context.go(RouteNames.partnerDetails);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
