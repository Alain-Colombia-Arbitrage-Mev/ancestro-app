import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../../../core/widgets/ancestro_input.dart';
import '../../../core/widgets/social_login_buttons.dart';
import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    ref.read(authNotifierProvider.notifier).signIn(
          email: email,
          password: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // Logo
              Icon(
                Icons.energy_savings_leaf,
                color: AppColors.primary,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'ANCESTRO',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to the Barefoot Tribe\nEnergy. Storage. Mobility. Unified',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),

              // Email input
              AncestroInput(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),

              // Password input
              AncestroInput(
                label: 'Password',
                hint: 'Enter your password',
                controller: _passwordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              // Log In button
              AncestroButton(
                label: 'Log In',
                onPressed: _onLogin,
                isLoading: isLoading,
              ),
              const SizedBox(height: 12),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.push(RouteNames.forgotPassword),
                  child: Text(
                    'Forgot Password?',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
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
                onPhonePressed: () {
                  // Phone login would open a phone input dialog
                },
              ),
              const SizedBox(height: 32),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () => context.push(RouteNames.signup),
                    child: Text(
                      'Sign up',
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
