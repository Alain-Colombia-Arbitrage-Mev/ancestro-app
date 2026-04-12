import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_responsive.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../../../core/widgets/ancestro_input.dart';
import '../../../core/widgets/social_login_buttons.dart';
import '../providers/auth_notifier.dart';
import '../../support/presentation/widgets/chat_fab.dart';

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

    final r = AppResponsive(context);

    return Scaffold(
      floatingActionButton: const ChatFab(),
      body: Stack(
        children: [
          // Ambient glow — matching .pen: circular amber blur, opacity 0.02
          Positioned(
            right: -100,
            bottom: -50,
            child: RepaintBoundary(
              child: Container(
                width: 610,
                height: 610,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.02),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.02),
                      blurRadius: 580,
                      spreadRadius: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: r.spacingXL),

                    // Logo — huella + rayo + ANCESTRO text, proportional to .pen
                    Image.asset(
                      'assets/images/logo_footprint.png',
                      width: r.logoFootprintWidth,
                      height: r.logoFootprintHeight,
                    ),
                    SizedBox(height: r.logoGap),
                    Image.asset(
                      'assets/images/logo_ancestro_text.png',
                      width: r.logoTextWidth,
                    ),
                    SizedBox(height: r.spacingLG),

                    // Title — matching .pen: fontSize 26, fontWeight 600, letterSpacing -1
                    Text(
                      'Welcome to the Barefoot Tribe\nEnergy. Storage. Mobility. Unified',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: r.titleSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        height: 1.38,
                      ),
                    ),
                    SizedBox(height: r.spacingXL),

                    // Email input — matching .pen structure
                    AncestroInput(
                      label: 'Email',
                      hint: 'Email address',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !isLoading,
                    ),
                    SizedBox(height: r.spacingLG),

                    // Password input
                    AncestroInput(
                      label: 'Password',
                      hint: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: Icons.lock_outline,
                      enabled: !isLoading,
                    ),
                    SizedBox(height: r.spacingLG),

                    // Log In button — .pen: height 55, cornerRadius 16, amber fill
                    AncestroButton(
                      label: 'Log In',
                      onPressed: _onLogin,
                      isLoading: isLoading,
                    ),
                    SizedBox(height: r.spacingLG),

                    // Forgot password — .pen: fontSize 14, fontWeight 500, amber
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.push(RouteNames.forgotPassword),
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: r.spacingLG),

                    // OR divider — .pen: line color #1f1f1f, text #6c6c6c
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.surfaceVariant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: AppTypography.body.copyWith(
                              color: AppColors.placeholderText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: r.spacingLG),

                    // Social login — .pen shows Google/Apple buttons with dark fill
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
                    SizedBox(height: r.spacingXL),

                    // Sign up link — .pen: "Don't have an account?" white + "Sign up" amber
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () => context.push(RouteNames.signup),
                          child: Text(
                            'Sign up',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontSize: 14,
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
          ),
        ],
      ),
    );
  }
}
