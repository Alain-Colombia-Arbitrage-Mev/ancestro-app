import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../../../core/widgets/ancestro_input.dart';
import '../../../core/widgets/ancestro_modal.dart';
import '../providers/auth_notifier.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onReset() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (password.isEmpty || confirmPassword.isEmpty) return;
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Passwords do not match'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    ref.read(authNotifierProvider.notifier).confirmForgotPassword(
          email: widget.email,
          code: widget.code,
          newPassword: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && !next.codeSent) {
        AncestroModal.show(
          context,
          icon: Icons.check_circle_outline,
          title: 'Password Reset',
          message: 'Your password has been successfully reset.',
          buttonLabel: 'Go to Login',
          onPressed: () {
            Navigator.of(context).pop(); // close modal
            context.go(RouteNames.login);
          },
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Reset Password',
                  style: AppTypography.heading.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create a new password for your account.',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                AncestroInput(
                  label: 'New Password',
                  hint: 'Enter new password',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                AncestroInput(
                  label: 'Confirm Password',
                  hint: 'Confirm new password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
                AncestroButton(
                  label: 'Reset Password',
                  onPressed: _onReset,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
