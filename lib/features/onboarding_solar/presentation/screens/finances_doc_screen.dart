import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';

class FinancesDocScreen extends ConsumerWidget {
  const FinancesDocScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = AppResponsive(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(RouteNames.solarReserve),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Upload Financial Documents',
                            textAlign: TextAlign.center,
                            style: AppTypography.heading
                                .copyWith(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: r.spacingXS),
                          Text(
                            'We need proof of income or financial documents to proceed.',
                            textAlign: TextAlign.center,
                            style: AppTypography.body
                                .copyWith(color: AppColors.textSecondary),
                          ),
                    SizedBox(height: r.spacingXL),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Placeholder for file picker
                        },
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.surfaceBorder,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cloud_upload_outlined,
                                  color: AppColors.primary, size: 48),
                              SizedBox(height: r.spacingSM),
                              Text(
                                'Tap to upload documents',
                                style: AppTypography.bodyMedium
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'PDF, JPG, PNG up to 10MB',
                                style: AppTypography.caption
                                    .copyWith(color: AppColors.textTertiary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: AncestroButton(
                label: 'Continue',
                onPressed: () => context.go(RouteNames.solarVerifyIdentity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
