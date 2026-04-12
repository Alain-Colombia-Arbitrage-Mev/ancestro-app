import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_user.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../../../core/widgets/ancestro_card.dart';
import '../../../core/widgets/ancestro_input.dart';
import '../../../core/widgets/social_login_buttons.dart';
import '../providers/auth_notifier.dart';

class SignupScreen extends ConsumerStatefulWidget {
  final String? referralCode;

  const SignupScreen({super.key, this.referralCode});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final TextEditingController _referralController;
  UserRole _selectedRole = UserRole.customer;

  @override
  void initState() {
    super.initState();
    _referralController = TextEditingController(text: widget.referralCode);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    ref.read(authNotifierProvider.notifier).signUp(
          email: email,
          password: password,
          role: _selectedRole,
          referralCode: _referralController.text.trim().isNotEmpty
              ? _referralController.text.trim()
              : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && next.codeSent) {
        context.push(
          '${RouteNames.verifyCode}?email=${Uri.encodeComponent(_emailController.text.trim())}',
        );
      }
      if (next.status == AuthStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(authNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Create Account',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join the Barefoot Tribe',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Role selector
              Text(
                'I am a...',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AncestroCard(
                      selected: _selectedRole == UserRole.customer,
                      onTap: isLoading
                          ? null
                          : () => setState(
                              () => _selectedRole = UserRole.customer),
                      child: Column(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: _selectedRole == UserRole.customer
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Customer',
                            style: AppTypography.bodyMedium.copyWith(
                              color: _selectedRole == UserRole.customer
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AncestroCard(
                      selected: _selectedRole == UserRole.partner,
                      onTap: isLoading
                          ? null
                          : () => setState(
                              () => _selectedRole = UserRole.partner),
                      child: Column(
                        children: [
                          Icon(
                            Icons.handshake_outlined,
                            color: _selectedRole == UserRole.partner
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Partner',
                            style: AppTypography.bodyMedium.copyWith(
                              color: _selectedRole == UserRole.partner
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Email
              AncestroInput(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),

              // Password
              AncestroInput(
                label: 'Password',
                hint: 'Create a password',
                controller: _passwordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),

              // Referral code
              AncestroInput(
                label: 'Referral Code (optional)',
                hint: 'Enter referral code',
                controller: _referralController,
                prefixIcon: Icons.card_giftcard_outlined,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              // Sign Up button
              AncestroButton(
                label: 'Sign Up',
                onPressed: _onSignUp,
                isLoading: isLoading,
              ),
              const SizedBox(height: 24),

              // OR divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.surfaceBorder),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.surfaceBorder),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Social login
              SocialLoginButtons(
                isLoading: isLoading,
                onGooglePressed: () {
                  ref.read(authNotifierProvider.notifier).signInWithGoogle();
                },
                onApplePressed: () {
                  ref.read(authNotifierProvider.notifier).signInWithApple();
                },
                onPhonePressed: () {},
              ),
              const SizedBox(height: 32),

              // Log in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () => context.go(RouteNames.login),
                    child: Text(
                      'Log in',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
