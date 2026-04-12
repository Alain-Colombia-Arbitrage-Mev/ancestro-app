import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_user.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../../../../core/widgets/ancestro_modal.dart';
import '../../../../core/widgets/ancestro_stepper.dart';
import '../providers/partner_onboarding_notifier.dart';

class PartnerConfirmScreen extends ConsumerStatefulWidget {
  const PartnerConfirmScreen({super.key});

  @override
  ConsumerState<PartnerConfirmScreen> createState() =>
      _PartnerConfirmScreenState();
}

class _PartnerConfirmScreenState extends ConsumerState<PartnerConfirmScreen> {
  bool _isSubmitting = false;

  String _partnerTypeName(PartnerType type) {
    switch (type) {
      case PartnerType.socioInversionista:
        return 'Socio Inversionista';
      case PartnerType.socioEstrategico:
        return 'Socio Estrategico';
      case PartnerType.instaladorCertificado:
        return 'Instalador Certificado';
      case PartnerType.empresaEnergia:
        return 'Empresa de Energia';
      case PartnerType.socioLogistica:
        return 'Socio Logistica';
      case PartnerType.asesorConsultor:
        return 'Asesor / Consultor';
      case PartnerType.gobiernoMunicipio:
        return 'Gobierno / Municipio';
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);
    final state = ref.watch(partnerOnboardingProvider);
    final notifier = ref.read(partnerOnboardingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () {
            notifier.previousStep();
            context.go(RouteNames.partnerDetails);
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AncestroStepper(totalSteps: 4, currentStep: 3),
              SizedBox(height: r.spacingLG),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Review & Submit',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: r.spacingXS),
                    Text(
                      'Please review your information before submitting',
                      textAlign: TextAlign.center,
                      style: AppTypography.body
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: r.spacingLG),

                    // Partner Type Section
                    AncestroCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Partner Type',
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.primary),
                          ),
                          SizedBox(height: r.spacingXS),
                          Text(
                            state.partnerType != null
                                ? _partnerTypeName(state.partnerType!)
                                : '--',
                            style: AppTypography.body
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: r.spacingMD),

                    // Contact Info Section
                    if (state.contact != null)
                      AncestroCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact Information',
                              style: AppTypography.bodyMedium
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: r.spacingSM),
                            _buildInfoRow('Name', state.contact!.fullName),
                            _buildInfoRow('Email', state.contact!.email),
                            _buildInfoRow('Phone', state.contact!.phone),
                            _buildInfoRow('Country', state.contact!.country),
                            _buildInfoRow('City', state.contact!.city),
                            if (state.contact!.company != null)
                              _buildInfoRow('Company', state.contact!.company!),
                          ],
                        ),
                      ),
                    SizedBox(height: r.spacingMD),

                    // Details Section
                    if (state.details.isNotEmpty)
                      AncestroCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Additional Details',
                              style: AppTypography.bodyMedium
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: r.spacingSM),
                            ...state.details.entries.map((entry) {
                              final displayValue = entry.value is List
                                  ? (entry.value as List).join(', ')
                                  : entry.value?.toString() ?? '--';
                              return _buildInfoRow(
                                _formatKey(entry.key),
                                displayValue,
                              );
                            }),
                          ],
                        ),
                      ),
                    SizedBox(height: r.spacingLG),
                  ],
                ),
              ),
              AncestroButton(
                label: 'Submit Application',
                isLoading: _isSubmitting,
                onPressed: () async {
                  setState(() => _isSubmitting = true);
                  await notifier.submit();
                  setState(() => _isSubmitting = false);

                  if (!context.mounted) return;

                  await AncestroModal.show(
                    context,
                    icon: Icons.check_circle,
                    title: 'Application Submitted!',
                    message:
                        'Your partner application has been received. We will review it and get back to you soon.',
                    buttonLabel: 'Go to Home',
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(RouteNames.home);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.caption
                  .copyWith(color: AppColors.textTertiary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style:
                  AppTypography.body.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    // Convert camelCase to Title Case
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result[0].toUpperCase() + result.substring(1);
  }
}
