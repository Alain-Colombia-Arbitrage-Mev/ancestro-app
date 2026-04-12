import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../../../../core/widgets/ancestro_loading.dart';
import '../../domain/models/referral.dart';
import '../providers/referral_notifier.dart';

class ReferralScreen extends ConsumerStatefulWidget {
  const ReferralScreen({super.key});

  @override
  ConsumerState<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends ConsumerState<ReferralScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(referralProvider.notifier).loadReferrals('current-user'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(referralProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Earn \$100', style: AppTypography.subheading),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: state.isLoading
          ? const AncestroLoading(message: 'Loading referrals...')
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Refer a Friend',
                  style: AppTypography.heading
                      .copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Earn \$100 for each friend who signs up and completes their first solar installation through Ancestro.',
                  style:
                      AppTypography.body.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),

                // Referral code card
                AncestroCard(
                  child: Column(
                    children: [
                      Text(
                        'Your Referral Code',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.textTertiary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.code,
                        style: AppTypography.heading.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AncestroButton.ghost(
                              label: 'Copy',
                              icon: Icons.copy,
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: state.code),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Code copied to clipboard'),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AncestroButton(
                              label: 'Share',
                              icon: Icons.share,
                              onPressed: () {
                                Share.share(
                                  'Join Ancestro with my referral code: ${state.code}',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Referrals list
                Text(
                  'Your Referrals',
                  style: AppTypography.subheading
                      .copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 16),
                if (state.referrals.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        'No referrals yet. Share your code to get started!',
                        style: AppTypography.body
                            .copyWith(color: AppColors.textTertiary),
                      ),
                    ),
                  )
                else
                  ...state.referrals
                      .map((referral) => _ReferralTile(referral: referral)),
              ],
            ),
    );
  }
}

class _ReferralTile extends StatelessWidget {
  final Referral referral;

  const _ReferralTile({required this.referral});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AncestroCard(
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.surfaceVariant,
              child: Text(
                (referral.referredEmail ?? '?')[0].toUpperCase(),
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    referral.referredEmail ?? 'Unknown',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _statusLabel(referral.status),
                    style: AppTypography.caption.copyWith(
                      color: _statusColor(referral.status),
                    ),
                  ),
                ],
              ),
            ),
            if (referral.reward != null)
              Text(
                '+\$${referral.reward!.toInt()}',
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.success),
              ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.completed:
        return 'Completed';
      case ReferralStatus.registered:
        return 'Registered';
      case ReferralStatus.pending:
        return 'Pending';
    }
  }

  Color _statusColor(ReferralStatus status) {
    switch (status) {
      case ReferralStatus.completed:
        return AppColors.success;
      case ReferralStatus.registered:
        return AppColors.primary;
      case ReferralStatus.pending:
        return AppColors.textTertiary;
    }
  }
}
