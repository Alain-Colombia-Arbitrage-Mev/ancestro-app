import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_providers.dart';
import '../auth/auth_user.dart';
import 'route_names.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
// success_screen.dart is available for use in custom routes

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final user = authState.valueOrNull;
      final currentPath = state.matchedLocation;
      final isAuthRoute = currentPath == RouteNames.splash ||
          currentPath == RouteNames.login ||
          currentPath == RouteNames.signup ||
          currentPath == RouteNames.forgotPassword ||
          currentPath == RouteNames.verifyCode ||
          currentPath == RouteNames.resetPassword;

      if (user == null && !isAuthRoute) return RouteNames.login;
      if (user == null) return null;
      if (isAuthRoute) {
        if (!user.onboardingComplete) {
          return user.role == UserRole.customer
              ? RouteNames.solarOnboarding
              : RouteNames.partnerProfile;
        }
        return RouteNames.home;
      }
      if (!user.onboardingComplete) {
        final isOnboardingRoute = currentPath.startsWith('/onboarding');
        if (!isOnboardingRoute) {
          return user.role == UserRole.customer
              ? RouteNames.solarOnboarding
              : RouteNames.partnerProfile;
        }
      }
      return null;
    },
    routes: [
      // ── Auth routes ──
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) {
          final referralCode = state.uri.queryParameters['referralCode'];
          return SignupScreen(referralCode: referralCode);
        },
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.verifyCode,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final code = state.uri.queryParameters['code'] ?? '';
          return ResetPasswordScreen(email: email, code: code);
        },
      ),

      // ── Solar onboarding routes ──
      GoRoute(
        path: RouteNames.solarOnboarding,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Onboarding'),
      ),
      GoRoute(
        path: RouteNames.solarIntro,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Intro'),
      ),
      GoRoute(
        path: RouteNames.solarProposal,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Proposal'),
      ),
      GoRoute(
        path: RouteNames.solarBasicInfo,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Basic Info'),
      ),
      GoRoute(
        path: RouteNames.solarProperty,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Property'),
      ),
      GoRoute(
        path: RouteNames.solarAlmostDone,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Almost Done'),
      ),
      GoRoute(
        path: RouteNames.solarInstantProposal,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Instant Proposal'),
      ),
      GoRoute(
        path: RouteNames.solarConfirm,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Confirm'),
      ),
      GoRoute(
        path: RouteNames.solarCredit,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Credit'),
      ),
      GoRoute(
        path: RouteNames.solarCoverage,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Coverage'),
      ),
      GoRoute(
        path: RouteNames.solarReserve,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Reserve'),
      ),
      GoRoute(
        path: RouteNames.solarReserving,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Reserving'),
      ),
      GoRoute(
        path: RouteNames.solarFinances,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Finances'),
      ),
      GoRoute(
        path: RouteNames.solarVerifyIdentity,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Verify Identity'),
      ),
      GoRoute(
        path: RouteNames.solarAgreements,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Agreements'),
      ),
      GoRoute(
        path: RouteNames.solarInnerAgreement,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _PlaceholderScreen(title: 'Agreement $id');
        },
      ),
      GoRoute(
        path: RouteNames.solarLastStep,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Last Step'),
      ),
      GoRoute(
        path: RouteNames.solarPropertyReview,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Property Review'),
      ),
      GoRoute(
        path: RouteNames.solarSchedule,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Schedule'),
      ),
      GoRoute(
        path: RouteNames.solarConfirmInspection,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Confirm Inspection'),
      ),
      GoRoute(
        path: RouteNames.solarInspector,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Solar Inspector'),
      ),

      // ── Partner onboarding routes ──
      GoRoute(
        path: RouteNames.partnerProfile,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Partner Profile'),
      ),
      GoRoute(
        path: RouteNames.partnerContact,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Partner Contact'),
      ),
      GoRoute(
        path: RouteNames.partnerDetails,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Partner Details'),
      ),
      GoRoute(
        path: RouteNames.partnerConfirm,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Partner Confirm'),
      ),

      // ── Referral ──
      GoRoute(
        path: RouteNames.referral,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Referral'),
      ),

      // ── Home ──
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Home'),
      ),
    ],
  );
});

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
