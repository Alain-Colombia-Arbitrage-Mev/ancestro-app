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
import '../../../../core/widgets/ancestro_stepper.dart';
import '../providers/partner_onboarding_notifier.dart';

class _PartnerOption {
  final PartnerType type;
  final String name;
  final String description;
  final IconData icon;
  final bool recommended;

  const _PartnerOption({
    required this.type,
    required this.name,
    required this.description,
    required this.icon,
    this.recommended = false,
  });
}

const _partnerOptions = <_PartnerOption>[
  _PartnerOption(
    type: PartnerType.socioInversionista,
    name: 'Socio Inversionista',
    description: 'Invest in clean energy projects',
    icon: Icons.trending_up,
    recommended: true,
  ),
  _PartnerOption(
    type: PartnerType.socioEstrategico,
    name: 'Socio Estrategico',
    description: 'Strategic business alliances',
    icon: Icons.handshake,
  ),
  _PartnerOption(
    type: PartnerType.instaladorCertificado,
    name: 'Instalador Certificado',
    description: 'Certified solar installer',
    icon: Icons.build,
  ),
  _PartnerOption(
    type: PartnerType.empresaEnergia,
    name: 'Empresa de Energia',
    description: 'Energy company partner',
    icon: Icons.bolt,
  ),
  _PartnerOption(
    type: PartnerType.socioLogistica,
    name: 'Socio Logistica',
    description: 'Logistics and fleet partner',
    icon: Icons.local_shipping,
  ),
  _PartnerOption(
    type: PartnerType.asesorConsultor,
    name: 'Asesor / Consultor',
    description: 'Energy advisor or consultant',
    icon: Icons.school,
  ),
  _PartnerOption(
    type: PartnerType.gobiernoMunicipio,
    name: 'Gobierno / Municipio',
    description: 'Government or municipality',
    icon: Icons.account_balance,
  ),
];

class PartnerProfileScreen extends ConsumerWidget {
  const PartnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    final state = ref.watch(partnerOnboardingProvider);
    final notifier = ref.read(partnerOnboardingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: r.spacingMD),
              const AncestroStepper(totalSteps: 4, currentStep: 0),
              SizedBox(height: r.spacingLG),
              Text(
                'Join as a Partner',
                textAlign: TextAlign.center,
                style: AppTypography.heading
                    .copyWith(color: AppColors.textPrimary),
              ),
              SizedBox(height: r.spacingXS),
              Text(
                'Select the type of partner that best describes you',
                textAlign: TextAlign.center,
                style: AppTypography.body
                    .copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: r.spacingLG),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _partnerOptions.length,
                  itemBuilder: (context, index) {
                    final option = _partnerOptions[index];
                    final isSelected = state.partnerType == option.type;

                    return AncestroCard(
                      selected: isSelected,
                      onTap: () => notifier.selectPartnerType(option.type),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            option.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            size: 28,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            option.name,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option.description,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (option.recommended) ...[
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryTinted,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Recomendado',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: 'Continue',
                onPressed: state.partnerType != null
                    ? () {
                        notifier.nextStep();
                        context.go(RouteNames.partnerContact);
                      }
                    : null,
                enabled: state.partnerType != null,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
