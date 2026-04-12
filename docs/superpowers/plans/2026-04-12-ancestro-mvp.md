# Ancestro MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Flutter mobile app for Ancestro's clean energy platform covering authentication (Cognito), solar customer onboarding (21 screens), partner onboarding (7 profiles, 4 steps), and referral system.

**Architecture:** Clean Architecture with feature-based structure (domain/data/presentation per feature). Riverpod for state management, GoRouter for routing with auth guards, Freezed for immutable models. All backend calls go through abstract repositories with mock implementations.

**Tech Stack:** Flutter 3.x, Dart, Riverpod, GoRouter, Freezed, Dio, SharedPreferences, AWS Cognito (amazon_cognito_identity_dart_2), google_sign_in, sign_in_with_apple

---

## File Structure

```
lib/
├── main.dart                                    # App entry point, ProviderScope, MaterialApp.router
├── core/
│   ├── config/
│   │   ├── env.dart                             # Environment config (useMocks flag, Cognito IDs)
│   │   └── constants.dart                       # App-wide constants
│   ├── design/
│   │   ├── app_colors.dart                      # Color palette from .pen
│   │   ├── app_typography.dart                   # DM Sans text styles
│   │   ├── app_radii.dart                       # Corner radius tokens
│   │   └── app_theme.dart                       # ThemeData assembling colors + typography
│   ├── router/
│   │   ├── route_names.dart                     # Named route string constants
│   │   └── app_router.dart                      # GoRouter config + auth redirect
│   ├── network/
│   │   ├── api_client.dart                      # Dio instance + interceptors
│   │   └── api_endpoints.dart                   # URL constants
│   ├── auth/
│   │   ├── auth_repository.dart                 # Abstract AuthRepository
│   │   ├── cognito_auth_repository.dart         # Real Cognito implementation
│   │   ├── mock_auth_repository.dart            # Mock implementation
│   │   ├── auth_user.dart                       # AuthUser model (Freezed)
│   │   └── auth_providers.dart                  # Riverpod providers
│   └── widgets/
│       ├── ancestro_button.dart                 # Primary + ghost button
│       ├── ancestro_input.dart                  # Text input with label
│       ├── ancestro_card.dart                   # Dark card
│       ├── ancestro_stepper.dart                # Progress dots
│       ├── ancestro_modal.dart                  # Overlay modal
│       ├── ancestro_loading.dart                # Loading spinner
│       ├── ancestro_nav_bar.dart                # Bottom nav glassmorphism
│       ├── ancestro_app_bar.dart                # Top bar with greeting
│       └── social_login_buttons.dart            # Google/Apple/Phone buttons
│
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── splash_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   ├── otp_screen.dart
│   │   │   ├── reset_password_screen.dart
│   │   │   └── success_screen.dart
│   │   └── providers/
│   │       └── auth_notifier.dart               # StateNotifier for auth actions
│   │
│   ├── onboarding_solar/
│   │   ├── domain/
│   │   │   ├── models/
│   │   │   │   ├── solar_onboarding_state.dart  # Freezed state
│   │   │   │   ├── basic_info.dart
│   │   │   │   ├── property_info.dart
│   │   │   │   ├── solar_proposal.dart
│   │   │   │   ├── uploaded_document.dart
│   │   │   │   ├── agreement.dart
│   │   │   │   ├── property_photo.dart
│   │   │   │   └── inspection_schedule.dart
│   │   │   └── solar_repository.dart            # Abstract
│   │   ├── data/
│   │   │   └── mock_solar_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── solar_onboarding_notifier.dart
│   │       └── screens/
│   │           ├── choose_flow_screen.dart
│   │           ├── intro_screen.dart
│   │           ├── proposal_screen.dart
│   │           ├── basic_info_screen.dart
│   │           ├── property_info_screen.dart
│   │           ├── almost_done_screen.dart
│   │           ├── instant_proposal_screen.dart
│   │           ├── confirm_service_screen.dart
│   │           ├── credit_check_screen.dart
│   │           ├── coverage_plan_screen.dart
│   │           ├── reserve_system_screen.dart
│   │           ├── reserving_spot_screen.dart
│   │           ├── finances_doc_screen.dart
│   │           ├── verify_identity_screen.dart
│   │           ├── agreements_screen.dart
│   │           ├── inner_agreement_screen.dart
│   │           ├── last_step_screen.dart
│   │           ├── property_review_screen.dart
│   │           ├── schedule_inspection_screen.dart
│   │           ├── confirm_inspection_screen.dart
│   │           └── meet_inspector_screen.dart
│   │
│   ├── onboarding_partner/
│   │   ├── domain/
│   │   │   ├── models/
│   │   │   │   ├── partner_type.dart
│   │   │   │   ├── partner_onboarding_state.dart
│   │   │   │   ├── partner_contact.dart
│   │   │   │   └── partner_field_config.dart
│   │   │   ├── partner_field_definitions.dart   # Static field configs per type
│   │   │   └── partner_repository.dart          # Abstract
│   │   ├── data/
│   │   │   └── mock_partner_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── partner_onboarding_notifier.dart
│   │       ├── screens/
│   │       │   ├── partner_profile_screen.dart
│   │       │   ├── partner_contact_screen.dart
│   │       │   ├── partner_details_screen.dart
│   │       │   └── partner_confirm_screen.dart
│   │       └── widgets/
│   │           └── adaptive_form_field.dart      # Renders field from PartnerFieldConfig
│   │
│   └── referral/
│       ├── domain/
│       │   ├── models/
│       │   │   └── referral.dart
│       │   └── referral_repository.dart
│       ├── data/
│       │   └── mock_referral_repository.dart
│       └── presentation/
│           ├── providers/
│           │   └── referral_notifier.dart
│           └── screens/
│               └── referral_screen.dart
│
├── l10n/
│   ├── app_es.arb                               # Spanish strings
│   └── app_en.arb                               # English strings
│
test/
├── core/
│   ├── auth/
│   │   └── mock_auth_repository_test.dart
│   └── widgets/
│       ├── ancestro_button_test.dart
│       └── ancestro_input_test.dart
├── features/
│   ├── auth/
│   │   ├── login_screen_test.dart
│   │   └── signup_screen_test.dart
│   ├── onboarding_solar/
│   │   ├── solar_onboarding_notifier_test.dart
│   │   └── choose_flow_screen_test.dart
│   ├── onboarding_partner/
│   │   ├── partner_onboarding_notifier_test.dart
│   │   ├── partner_field_definitions_test.dart
│   │   └── adaptive_form_field_test.dart
│   └── referral/
│       └── referral_notifier_test.dart
```

---

## Task 1: Flutter Project Scaffold + Dependencies

**Files:**
- Create: `pubspec.yaml`
- Create: `lib/main.dart`
- Create: `lib/core/config/env.dart`
- Create: `lib/core/config/constants.dart`
- Create: `analysis_options.yaml`

- [ ] **Step 1: Create Flutter project**

```bash
cd /Users/luisagiraldo/Documents/ancestroapp
flutter create . --org com.ancestro --project-name ancestro --platforms ios,android,web
```

- [ ] **Step 2: Add dependencies to pubspec.yaml**

Replace the `dependencies` and `dev_dependencies` sections in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  go_router: ^14.8.1
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  dio: ^5.7.0
  shared_preferences: ^2.3.4
  amazon_cognito_identity_dart_2: ^3.6.5
  google_sign_in: ^6.2.2
  sign_in_with_apple: ^6.1.4
  image_picker: ^1.1.2
  share_plus: ^10.1.4
  flutter_svg: ^2.0.17
  cached_network_image: ^3.4.1
  google_fonts: ^6.2.1
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.14
  freezed: ^2.5.8
  json_serializable: ^6.9.0
  riverpod_generator: ^2.6.3
  mocktail: ^1.0.4

flutter:
  generate: true
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

- [ ] **Step 3: Create asset directories**

```bash
mkdir -p assets/images assets/icons
```

- [ ] **Step 4: Create l10n.yaml**

Create `l10n.yaml` in project root:

```yaml
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations.dart
```

- [ ] **Step 5: Create initial ARB files**

Create `lib/l10n/app_es.arb`:

```json
{
  "@@locale": "es",
  "appName": "Ancestro",
  "welcomeTitle": "Bienvenido a Ancestro",
  "welcomeSubtitle": "Energía. Almacenamiento. Movilidad. Unificados",
  "login": "Iniciar Sesión",
  "signup": "Registrarse",
  "email": "Correo electrónico",
  "password": "Contraseña",
  "forgotPassword": "¿Olvidaste tu contraseña?",
  "dontHaveAccount": "¿No tienes cuenta?",
  "alreadyHaveAccount": "¿Ya tienes cuenta?",
  "or": "O",
  "next": "Siguiente",
  "back": "Atrás",
  "confirm": "Confirmar",
  "submit": "Enviar",
  "cancel": "Cancelar"
}
```

Create `lib/l10n/app_en.arb`:

```json
{
  "@@locale": "en",
  "appName": "Ancestro",
  "welcomeTitle": "Welcome to Ancestro",
  "welcomeSubtitle": "Energy. Storage. Mobility. Unified",
  "login": "Log In",
  "signup": "Sign Up",
  "email": "Email address",
  "password": "Password",
  "forgotPassword": "Forgot Password?",
  "dontHaveAccount": "Don't have an account?",
  "alreadyHaveAccount": "Already have an account?",
  "or": "OR",
  "next": "Next",
  "back": "Back",
  "confirm": "Confirm",
  "submit": "Submit",
  "cancel": "Cancel"
}
```

- [ ] **Step 6: Create env.dart**

Create `lib/core/config/env.dart`:

```dart
class Env {
  Env._();

  static const bool useMocks = true;

  // Cognito config — replace with real values when connecting backend
  static const String cognitoUserPoolId = 'us-east-1_XXXXXXXXX';
  static const String cognitoClientId = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';
  static const String cognitoRegion = 'us-east-1';

  // API
  static const String apiBaseUrl = 'https://api.ancestro.ai/v1';
}
```

- [ ] **Step 7: Create constants.dart**

Create `lib/core/config/constants.dart`:

```dart
class AppConstants {
  AppConstants._();

  static const String appName = 'Ancestro';
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration mockDelay = Duration(milliseconds: 500);
  static const String mockOtpCode = '123456';
  static const String mockReferralCode = 'MOCK123';
  static const int otpLength = 6;
  static const int otpResendSeconds = 35;
  static const double minTouchTarget = 44.0;
}
```

- [ ] **Step 8: Create minimal main.dart**

Create `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AncestroApp()));
}

class AncestroApp extends StatelessWidget {
  const AncestroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ancestro',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: Text('Ancestro')),
      ),
    );
  }
}
```

- [ ] **Step 9: Run to verify setup**

```bash
flutter pub get
flutter analyze
flutter test
```

Expected: No errors, no test failures (default test file may need removal).

- [ ] **Step 10: Commit**

```bash
git add -A
git commit -m "feat: scaffold Flutter project with dependencies and config"
```

---

## Task 2: Design System — Colors, Typography, Radii, Theme

**Files:**
- Create: `lib/core/design/app_colors.dart`
- Create: `lib/core/design/app_typography.dart`
- Create: `lib/core/design/app_radii.dart`
- Create: `lib/core/design/app_theme.dart`

- [ ] **Step 1: Create app_colors.dart**

Create `lib/core/design/app_colors.dart`:

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceVariant = Color(0xFF1F1F1F);

  // Borders
  static const Color surfaceBorder = Color(0x1AFFFFFF);
  static const Color inputBorder = Color(0x0DFFFFFF);

  // Fills
  static const Color inputFill = Color(0x14FFFFFF);
  static const Color navFill = Color(0x33141414);

  // Primary (amber/gold)
  static const Color primary = Color(0xFFF8B03B);
  static const Color primaryTinted = Color(0x1AF0B535);
  static const Color primaryBorder = Color(0x4DF0B535);
  static const Color onPrimary = Color(0xFF0D0D0D);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB5B5B5);
  static const Color textTertiary = Color(0xFF9A9A9A);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color overlay = Color(0x73000000);
}
```

- [ ] **Step 2: Create app_typography.dart**

Create `lib/core/design/app_typography.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static String get _fontFamily => GoogleFonts.dmSans().fontFamily!;

  static TextStyle get heading => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get subheading => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get caption => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get label => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );
}
```

- [ ] **Step 3: Create app_radii.dart**

Create `lib/core/design/app_radii.dart`:

```dart
class AppRadii {
  AppRadii._();

  static const double small = 14.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double pill = 500.0;
}
```

- [ ] **Step 4: Create app_theme.dart**

Create `lib/core/design/app_theme.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_radii.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.small),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        labelStyle: const TextStyle(color: AppColors.textTertiary),
        hintStyle: const TextStyle(color: AppColors.textTertiary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.small),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
    );
  }
}
```

- [ ] **Step 5: Update main.dart to use theme**

Update `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/design/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AncestroApp()));
}

class AncestroApp extends StatelessWidget {
  const AncestroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ancestro',
      theme: AppTheme.dark,
      home: const Scaffold(
        body: Center(
          child: Text('Ancestro', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: Run to verify**

```bash
flutter analyze
flutter run -d chrome
```

Expected: App launches with dark background (#0d0d0d), white text, DM Sans font.

- [ ] **Step 7: Commit**

```bash
git add lib/core/design/
git commit -m "feat: add design system — colors, typography, radii, theme from .pen"
```

---

## Task 3: Core Widgets — Button, Input, Card

**Files:**
- Create: `lib/core/widgets/ancestro_button.dart`
- Create: `lib/core/widgets/ancestro_input.dart`
- Create: `lib/core/widgets/ancestro_card.dart`
- Create: `test/core/widgets/ancestro_button_test.dart`
- Create: `test/core/widgets/ancestro_input_test.dart`

- [ ] **Step 1: Write failing test for AncestroButton**

Create `test/core/widgets/ancestro_button_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/core/widgets/ancestro_button.dart';
import 'package:ancestro/core/design/app_colors.dart';

void main() {
  group('AncestroButton', () {
    testWidgets('primary variant renders gold background', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroButton(
              label: 'Log In',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Log In'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button, isNotNull);
    });

    testWidgets('ghost variant renders transparent background', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroButton.ghost(
              label: 'Cancel',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button, isNotNull);
    });

    testWidgets('disabled button does not respond to taps', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroButton(
              label: 'Submit',
              onPressed: () => tapped = true,
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Submit'));
      expect(tapped, isFalse);
    });

    testWidgets('loading state shows CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroButton(
              label: 'Submit',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/core/widgets/ancestro_button_test.dart
```

Expected: FAIL — `ancestro_button.dart` does not exist.

- [ ] **Step 3: Implement AncestroButton**

Create `lib/core/widgets/ancestro_button.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';

class AncestroButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;
  final bool _isGhost;
  final IconData? icon;

  const AncestroButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.icon,
  }) : _isGhost = false;

  const AncestroButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.icon,
  }) : _isGhost = true;

  @override
  Widget build(BuildContext context) {
    if (_isGhost) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: enabled && !isLoading ? onPressed : null,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.surfaceBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.small),
            ),
          ),
          child: _buildChild(AppColors.textPrimary),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.small),
          ),
        ),
        child: _buildChild(AppColors.onPrimary),
      ),
    );
  }

  Widget _buildChild(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.button),
        ],
      );
    }

    return Text(label, style: AppTypography.button);
  }
}
```

- [ ] **Step 4: Run button test to verify it passes**

```bash
flutter test test/core/widgets/ancestro_button_test.dart
```

Expected: All 4 tests PASS.

- [ ] **Step 5: Write failing test for AncestroInput**

Create `test/core/widgets/ancestro_input_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/core/widgets/ancestro_input.dart';

void main() {
  group('AncestroInput', () {
    testWidgets('renders label and hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroInput(
              label: 'Email',
              hint: 'Enter your email',
              controller: TextEditingController(),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('password field has visibility toggle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroInput(
              label: 'Password',
              hint: 'Enter password',
              controller: TextEditingController(),
              isPassword: true,
            ),
          ),
        ),
      );

      // Initially obscured
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);

      // Tap toggle
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      final updatedField = tester.widget<TextField>(find.byType(TextField));
      expect(updatedField.obscureText, isFalse);
    });

    testWidgets('shows prefix icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AncestroInput(
              label: 'Email',
              hint: 'Enter your email',
              controller: TextEditingController(),
              prefixIcon: Icons.email_outlined,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });
  });
}
```

- [ ] **Step 6: Run test to verify it fails**

```bash
flutter test test/core/widgets/ancestro_input_test.dart
```

Expected: FAIL.

- [ ] **Step 7: Implement AncestroInput**

Create `lib/core/widgets/ancestro_input.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';

class AncestroInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;

  const AncestroInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
  });

  @override
  State<AncestroInput> createState() => _AncestroInputState();
}

class _AncestroInputState extends State<AncestroInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: AppTypography.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.textTertiary, size: 20)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 8: Run input test to verify it passes**

```bash
flutter test test/core/widgets/ancestro_input_test.dart
```

Expected: All 3 tests PASS.

- [ ] **Step 9: Implement AncestroCard**

Create `lib/core/widgets/ancestro_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';

class AncestroCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool selected;

  const AncestroCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.medium),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.surfaceBorder,
          ),
        ),
        child: child,
      ),
    );
  }
}
```

- [ ] **Step 10: Run all widget tests**

```bash
flutter test test/core/widgets/
```

Expected: All tests PASS.

- [ ] **Step 11: Commit**

```bash
git add lib/core/widgets/ancestro_button.dart lib/core/widgets/ancestro_input.dart lib/core/widgets/ancestro_card.dart test/core/widgets/
git commit -m "feat: add core widgets — AncestroButton, AncestroInput, AncestroCard with tests"
```

---

## Task 4: Core Widgets — Stepper, Modal, Loading

**Files:**
- Create: `lib/core/widgets/ancestro_stepper.dart`
- Create: `lib/core/widgets/ancestro_modal.dart`
- Create: `lib/core/widgets/ancestro_loading.dart`

- [ ] **Step 1: Implement AncestroStepper**

Create `lib/core/widgets/ancestro_stepper.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';

class AncestroStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const AncestroStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Container(
          width: isActive ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.surfaceBorder,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
```

- [ ] **Step 2: Implement AncestroModal**

Create `lib/core/widgets/ancestro_modal.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';
import 'ancestro_button.dart';

class AncestroModal {
  AncestroModal._();

  static Future<void> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String buttonLabel,
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.overlay,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.large),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.primaryTinted,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 32),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: AppTypography.subheading.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: buttonLabel,
                onPressed: onPressed ?? () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Implement AncestroLoading**

Create `lib/core/widgets/ancestro_loading.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';

class AncestroLoading extends StatelessWidget {
  final String? message;

  const AncestroLoading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Run analyze**

```bash
flutter analyze
```

Expected: No issues.

- [ ] **Step 5: Commit**

```bash
git add lib/core/widgets/ancestro_stepper.dart lib/core/widgets/ancestro_modal.dart lib/core/widgets/ancestro_loading.dart
git commit -m "feat: add AncestroStepper, AncestroModal, AncestroLoading widgets"
```

---

## Task 5: Auth Domain — AuthUser Model + AuthRepository Interface

**Files:**
- Create: `lib/core/auth/auth_user.dart`
- Create: `lib/core/auth/auth_repository.dart`

- [ ] **Step 1: Create AuthUser with Freezed**

Create `lib/core/auth/auth_user.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

enum UserRole { customer, partner }

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    String? phone,
    required UserRole role,
    PartnerType? partnerType,
    String? referredBy,
    @Default(false) bool onboardingComplete,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

enum PartnerType {
  socioInversionista,
  socioEstrategico,
  instaladorCertificado,
  empresaEnergia,
  socioLogistica,
  asesorConsultor,
  gobiernoMunicipio,
}
```

- [ ] **Step 2: Create AuthRepository interface**

Create `lib/core/auth/auth_repository.dart`:

```dart
import 'auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithApple();

  Future<void> signInWithPhone({required String phoneNumber});

  Future<AuthUser> confirmPhoneSignIn({required String code});

  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  });

  Future<void> confirmSignUp({
    required String email,
    required String code,
  });

  Future<void> forgotPassword({required String email});

  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<void> signOut();
}
```

- [ ] **Step 3: Run code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `auth_user.freezed.dart` and `auth_user.g.dart`.

- [ ] **Step 4: Run analyze**

```bash
flutter analyze
```

Expected: No issues.

- [ ] **Step 5: Commit**

```bash
git add lib/core/auth/auth_user.dart lib/core/auth/auth_user.freezed.dart lib/core/auth/auth_user.g.dart lib/core/auth/auth_repository.dart
git commit -m "feat: add AuthUser model (Freezed) and AuthRepository interface"
```

---

## Task 6: Mock Auth Repository + Auth Providers

**Files:**
- Create: `lib/core/auth/mock_auth_repository.dart`
- Create: `lib/core/auth/auth_providers.dart`
- Create: `test/core/auth/mock_auth_repository_test.dart`

- [ ] **Step 1: Write failing test for MockAuthRepository**

Create `test/core/auth/mock_auth_repository_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/core/auth/mock_auth_repository.dart';
import 'package:ancestro/core/auth/auth_user.dart';

void main() {
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
  });

  group('MockAuthRepository', () {
    test('signIn returns AuthUser with given email', () async {
      final user = await repo.signIn(
        email: 'test@example.com',
        password: 'password123',
      );
      expect(user.email, 'test@example.com');
      expect(user.id, isNotEmpty);
    });

    test('signUp returns user with correct role', () async {
      final user = await repo.signUp(
        email: 'new@example.com',
        password: 'password123',
        role: UserRole.partner,
      );
      expect(user.role, UserRole.partner);
      expect(user.onboardingComplete, isFalse);
    });

    test('signUp stores referralCode', () async {
      final user = await repo.signUp(
        email: 'ref@example.com',
        password: 'password123',
        role: UserRole.customer,
        referralCode: 'ABC123',
      );
      expect(user.referredBy, 'ABC123');
    });

    test('confirmSignUp does not throw', () async {
      await repo.signUp(
        email: 'confirm@example.com',
        password: 'pass',
        role: UserRole.customer,
      );
      await expectLater(
        repo.confirmSignUp(email: 'confirm@example.com', code: '123456'),
        completes,
      );
    });

    test('forgotPassword and confirmForgotPassword flow', () async {
      await expectLater(
        repo.forgotPassword(email: 'test@example.com'),
        completes,
      );
      await expectLater(
        repo.confirmForgotPassword(
          email: 'test@example.com',
          code: '123456',
          newPassword: 'newpass',
        ),
        completes,
      );
    });

    test('signOut clears current user', () async {
      await repo.signIn(email: 'test@example.com', password: 'pass');
      await repo.signOut();

      // After sign-out, authStateChanges should emit null
      expect(await repo.authStateChanges.first, isNull);
    });

    test('authStateChanges emits user after signIn', () async {
      final user = await repo.signIn(email: 'stream@example.com', password: 'pass');
      final emitted = await repo.authStateChanges.first;
      expect(emitted?.email, user.email);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/core/auth/mock_auth_repository_test.dart
```

Expected: FAIL — file does not exist.

- [ ] **Step 3: Implement MockAuthRepository**

Create `lib/core/auth/mock_auth_repository.dart`:

```dart
import 'dart:async';
import 'dart:math';
import '../config/constants.dart';
import 'auth_repository.dart';
import 'auth_user.dart';

class MockAuthRepository implements AuthRepository {
  final _authStateController = StreamController<AuthUser?>.broadcast();
  AuthUser? _currentUser;
  String? _pendingPhoneNumber;

  @override
  Stream<AuthUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: email,
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: 'google.user@gmail.com',
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signInWithApple() async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: 'apple.user@icloud.com',
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> signInWithPhone({required String phoneNumber}) async {
    await Future.delayed(AppConstants.mockDelay);
    _pendingPhoneNumber = phoneNumber;
  }

  @override
  Future<AuthUser> confirmPhoneSignIn({required String code}) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: '',
      phone: _pendingPhoneNumber,
      role: UserRole.customer,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    _pendingPhoneNumber = null;
    return user;
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    final user = AuthUser(
      id: _generateId(),
      email: email,
      role: role,
      referredBy: referralCode,
      onboardingComplete: false,
    );
    _currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(AppConstants.mockDelay);
    _currentUser = null;
    _authStateController.add(null);
  }

  String _generateId() => Random().nextInt(999999).toString().padLeft(6, '0');
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/core/auth/mock_auth_repository_test.dart
```

Expected: All 7 tests PASS.

- [ ] **Step 5: Create auth providers**

Create `lib/core/auth/auth_providers.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env.dart';
import 'auth_repository.dart';
import 'auth_user.dart';
import 'mock_auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (Env.useMocks) return MockAuthRepository();
  // TODO: return CognitoAuthRepository() when backend is ready
  return MockAuthRepository();
});

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
});
```

- [ ] **Step 6: Commit**

```bash
git add lib/core/auth/mock_auth_repository.dart lib/core/auth/auth_providers.dart test/core/auth/
git commit -m "feat: add MockAuthRepository with tests and auth Riverpod providers"
```

---

## Task 7: Router Setup with Auth Guards

**Files:**
- Create: `lib/core/router/route_names.dart`
- Create: `lib/core/router/app_router.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create route names**

Create `lib/core/router/route_names.dart`:

```dart
class RouteNames {
  RouteNames._();

  // Auth
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const verifyCode = '/verify-code';
  static const resetPassword = '/reset-password';

  // Onboarding Solar
  static const solarOnboarding = '/onboarding/solar';
  static const solarIntro = '/onboarding/solar/intro';
  static const solarProposal = '/onboarding/solar/proposal';
  static const solarBasicInfo = '/onboarding/solar/basic-info';
  static const solarProperty = '/onboarding/solar/property';
  static const solarAlmostDone = '/onboarding/solar/almost-done';
  static const solarInstantProposal = '/onboarding/solar/instant-proposal';
  static const solarConfirm = '/onboarding/solar/confirm';
  static const solarCredit = '/onboarding/solar/credit';
  static const solarCoverage = '/onboarding/solar/coverage';
  static const solarReserve = '/onboarding/solar/reserve';
  static const solarReserving = '/onboarding/solar/reserving';
  static const solarFinances = '/onboarding/solar/finances';
  static const solarVerifyIdentity = '/onboarding/solar/verify-identity';
  static const solarAgreements = '/onboarding/solar/agreements';
  static const solarInnerAgreement = '/onboarding/solar/agreements/:id';
  static const solarLastStep = '/onboarding/solar/last-step';
  static const solarPropertyReview = '/onboarding/solar/property-review';
  static const solarSchedule = '/onboarding/solar/schedule';
  static const solarConfirmInspection = '/onboarding/solar/confirm-inspection';
  static const solarInspector = '/onboarding/solar/inspector';

  // Onboarding Partner
  static const partnerProfile = '/onboarding/partner/profile';
  static const partnerContact = '/onboarding/partner/contact';
  static const partnerDetails = '/onboarding/partner/details';
  static const partnerConfirm = '/onboarding/partner/confirm';

  // Referral
  static const referral = '/referral';

  // Home (post-onboarding placeholder)
  static const home = '/home';
}
```

- [ ] **Step 2: Create app_router.dart with auth guard**

Create `lib/core/router/app_router.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_providers.dart';
import '../auth/auth_user.dart';
import 'route_names.dart';

// Placeholder screen for routes not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  final String name;
  const _PlaceholderScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('$name\n(Coming soon)', textAlign: TextAlign.center)),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (context, state) {
      final user = authState.valueOrNull;
      final currentPath = state.matchedLocation;

      final isAuthRoute = currentPath == RouteNames.splash ||
          currentPath == RouteNames.login ||
          currentPath == RouteNames.signup ||
          currentPath == RouteNames.forgotPassword ||
          currentPath == RouteNames.verifyCode ||
          currentPath == RouteNames.resetPassword;

      // Not logged in — only allow auth routes
      if (user == null && !isAuthRoute) return RouteNames.login;

      // Logged in — redirect away from auth routes
      if (user != null && isAuthRoute) {
        if (!user.onboardingComplete) {
          return user.role == UserRole.customer
              ? RouteNames.solarOnboarding
              : RouteNames.partnerProfile;
        }
        return RouteNames.home;
      }

      // Logged in but onboarding incomplete — force onboarding
      if (user != null && !user.onboardingComplete) {
        final isOnboardingRoute = currentPath.startsWith('/onboarding');
        if (!isOnboardingRoute && currentPath != RouteNames.home) {
          return user.role == UserRole.customer
              ? RouteNames.solarOnboarding
              : RouteNames.partnerProfile;
        }
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: RouteNames.splash,
        builder: (_, __) => const _PlaceholderScreen(name: 'Splash'),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (_, __) => const _PlaceholderScreen(name: 'Login'),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (_, __) => const _PlaceholderScreen(name: 'Signup'),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (_, __) => const _PlaceholderScreen(name: 'Forgot Password'),
      ),
      GoRoute(
        path: RouteNames.verifyCode,
        builder: (_, __) => const _PlaceholderScreen(name: 'Verify Code'),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (_, __) => const _PlaceholderScreen(name: 'Reset Password'),
      ),

      // Solar onboarding routes
      GoRoute(
        path: RouteNames.solarOnboarding,
        builder: (_, __) => const _PlaceholderScreen(name: 'Choose Flow'),
      ),
      GoRoute(
        path: RouteNames.solarIntro,
        builder: (_, __) => const _PlaceholderScreen(name: 'Intro'),
      ),
      GoRoute(
        path: RouteNames.solarProposal,
        builder: (_, __) => const _PlaceholderScreen(name: 'Proposal'),
      ),
      GoRoute(
        path: RouteNames.solarBasicInfo,
        builder: (_, __) => const _PlaceholderScreen(name: 'Basic Info'),
      ),
      GoRoute(
        path: RouteNames.solarProperty,
        builder: (_, __) => const _PlaceholderScreen(name: 'Property Info'),
      ),
      GoRoute(
        path: RouteNames.solarAlmostDone,
        builder: (_, __) => const _PlaceholderScreen(name: 'Almost Done'),
      ),
      GoRoute(
        path: RouteNames.solarInstantProposal,
        builder: (_, __) => const _PlaceholderScreen(name: 'Instant Proposal'),
      ),
      GoRoute(
        path: RouteNames.solarConfirm,
        builder: (_, __) => const _PlaceholderScreen(name: 'Confirm Service'),
      ),
      GoRoute(
        path: RouteNames.solarCredit,
        builder: (_, __) => const _PlaceholderScreen(name: 'Credit Check'),
      ),
      GoRoute(
        path: RouteNames.solarCoverage,
        builder: (_, __) => const _PlaceholderScreen(name: 'Coverage Plan'),
      ),
      GoRoute(
        path: RouteNames.solarReserve,
        builder: (_, __) => const _PlaceholderScreen(name: 'Reserve System'),
      ),
      GoRoute(
        path: RouteNames.solarReserving,
        builder: (_, __) => const _PlaceholderScreen(name: 'Reserving Spot'),
      ),
      GoRoute(
        path: RouteNames.solarFinances,
        builder: (_, __) => const _PlaceholderScreen(name: 'Finances Doc'),
      ),
      GoRoute(
        path: RouteNames.solarVerifyIdentity,
        builder: (_, __) => const _PlaceholderScreen(name: 'Verify Identity'),
      ),
      GoRoute(
        path: RouteNames.solarAgreements,
        builder: (_, __) => const _PlaceholderScreen(name: 'Agreements'),
      ),
      GoRoute(
        path: RouteNames.solarInnerAgreement,
        builder: (_, state) => _PlaceholderScreen(
          name: 'Agreement ${state.pathParameters['id']}',
        ),
      ),
      GoRoute(
        path: RouteNames.solarLastStep,
        builder: (_, __) => const _PlaceholderScreen(name: 'Last Step'),
      ),
      GoRoute(
        path: RouteNames.solarPropertyReview,
        builder: (_, __) => const _PlaceholderScreen(name: 'Property Review'),
      ),
      GoRoute(
        path: RouteNames.solarSchedule,
        builder: (_, __) => const _PlaceholderScreen(name: 'Schedule Inspection'),
      ),
      GoRoute(
        path: RouteNames.solarConfirmInspection,
        builder: (_, __) => const _PlaceholderScreen(name: 'Confirm Inspection'),
      ),
      GoRoute(
        path: RouteNames.solarInspector,
        builder: (_, __) => const _PlaceholderScreen(name: 'Meet Inspector'),
      ),

      // Partner onboarding routes
      GoRoute(
        path: RouteNames.partnerProfile,
        builder: (_, __) => const _PlaceholderScreen(name: 'Partner Profile'),
      ),
      GoRoute(
        path: RouteNames.partnerContact,
        builder: (_, __) => const _PlaceholderScreen(name: 'Partner Contact'),
      ),
      GoRoute(
        path: RouteNames.partnerDetails,
        builder: (_, __) => const _PlaceholderScreen(name: 'Partner Details'),
      ),
      GoRoute(
        path: RouteNames.partnerConfirm,
        builder: (_, __) => const _PlaceholderScreen(name: 'Partner Confirm'),
      ),

      // Referral
      GoRoute(
        path: RouteNames.referral,
        builder: (_, __) => const _PlaceholderScreen(name: 'Referral'),
      ),

      // Home
      GoRoute(
        path: RouteNames.home,
        builder: (_, __) => const _PlaceholderScreen(name: 'Home'),
      ),
    ],
  );
});
```

- [ ] **Step 3: Update main.dart to use GoRouter**

Replace `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/design/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AncestroApp()));
}

class AncestroApp extends ConsumerWidget {
  const AncestroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Ancestro',
      theme: AppTheme.dark,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
    );
  }
}
```

- [ ] **Step 4: Run to verify routing works**

```bash
flutter run -d chrome
```

Expected: App launches, shows Splash placeholder (since user is null, redirect to Login placeholder).

- [ ] **Step 5: Commit**

```bash
git add lib/core/router/ lib/main.dart
git commit -m "feat: add GoRouter with auth guards and all route definitions"
```

---

## Task 8: Auth Screens — Splash + Login

**Files:**
- Create: `lib/features/auth/providers/auth_notifier.dart`
- Create: `lib/features/auth/presentation/splash_screen.dart`
- Create: `lib/features/auth/presentation/login_screen.dart`
- Create: `lib/core/widgets/social_login_buttons.dart`
- Create: `test/features/auth/login_screen_test.dart`

- [ ] **Step 1: Create AuthNotifier**

Create `lib/features/auth/providers/auth_notifier.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/auth_repository.dart';
import '../../../core/auth/auth_user.dart';

enum AuthStatus { idle, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? error;
  final bool codeSent;

  const AuthState({
    this.status = AuthStatus.idle,
    this.error,
    this.codeSent = false,
  });

  AuthState copyWith({AuthStatus? status, String? error, bool? codeSent}) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      codeSent: codeSent ?? this.codeSent,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState());

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signIn(email: email, password: password);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithGoogle();
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithApple();
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithPhone({required String phoneNumber}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signInWithPhone(phoneNumber: phoneNumber);
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required UserRole role,
    String? referralCode,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.signUp(
        email: email,
        password: password,
        role: role,
        referralCode: referralCode,
      );
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.confirmSignUp(email: email, code: code);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> forgotPassword({required String email}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.forgotPassword(email: email);
      state = state.copyWith(status: AuthStatus.success, codeSent: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.confirmForgotPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(status: AuthStatus.idle, error: null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthNotifier(repo);
});
```

- [ ] **Step 2: Create SocialLoginButtons widget**

Create `lib/core/widgets/social_login_buttons.dart`:

```dart
import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../design/app_radii.dart';
import '../design/app_typography.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onPhonePressed;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onPhonePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SocialButton(
          icon: Icons.g_mobiledata,
          label: 'Google',
          onPressed: isLoading ? null : onGooglePressed,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.apple,
          label: 'Apple',
          onPressed: isLoading ? null : onApplePressed,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.phone,
          label: 'Phone',
          onPressed: isLoading ? null : onPhonePressed,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 52,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.surfaceBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.small),
            ),
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 24),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create SplashScreen**

Create `lib/features/auth/presentation/splash_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/constants.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(AppConstants.splashDuration, () {
      if (mounted) context.go(RouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background — placeholder color until real image is added
          Container(color: AppColors.background),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background.withOpacity(0.8),
                  AppColors.background,
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to\nAncestro',
                    style: AppTypography.heading.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your solar system & EV Charging in one app',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Create LoginScreen**

Create `lib/features/auth/presentation/login_screen.dart`:

```dart
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
        ref.read(authNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Logo area
              Icon(Icons.energy_savings_leaf, color: AppColors.primary, size: 48),
              const SizedBox(height: 8),
              Text(
                'ANCESTRO',
                style: AppTypography.heading.copyWith(
                  color: AppColors.primary,
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

              const Spacer(flex: 1),

              // Form
              AncestroInput(
                label: 'Email',
                hint: 'Email address',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Password',
                hint: 'Password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // Login button
              AncestroButton(
                label: 'Log In',
                isLoading: isLoading,
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );
                },
              ),
              const SizedBox(height: 16),

              // Forgot password
              TextButton(
                onPressed: () => context.push(RouteNames.forgotPassword),
                child: Text(
                  'Forgot Password?',
                  style: AppTypography.body.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 16),

              // OR divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.surfaceBorder)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.surfaceBorder)),
                ],
              ),
              const SizedBox(height: 16),

              // Social login
              SocialLoginButtons(
                isLoading: isLoading,
                onGooglePressed: () =>
                    ref.read(authNotifierProvider.notifier).signInWithGoogle(),
                onApplePressed: () =>
                    ref.read(authNotifierProvider.notifier).signInWithApple(),
                onPhonePressed: () {
                  // Navigate to phone input flow
                },
              ),

              const Spacer(flex: 1),

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
                  TextButton(
                    onPressed: () => context.push(RouteNames.signup),
                    child: Text(
                      'Sign up',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Wire screens into router**

Update the splash and login routes in `lib/core/router/app_router.dart`:

Replace the splash and login route builders:

```dart
// At the top of app_router.dart, add imports:
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';

// Replace the splash route:
GoRoute(
  path: RouteNames.splash,
  builder: (_, __) => const SplashScreen(),
),
// Replace the login route:
GoRoute(
  path: RouteNames.login,
  builder: (_, __) => const LoginScreen(),
),
```

- [ ] **Step 6: Write login screen test**

Create `test/features/auth/login_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/features/auth/presentation/login_screen.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: LoginScreen()),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
    });

    testWidgets('renders social login buttons', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: LoginScreen()),
        ),
      );

      expect(find.text('OR'), findsOneWidget);
      expect(find.byIcon(Icons.g_mobiledata), findsOneWidget);
      expect(find.byIcon(Icons.apple), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('renders sign up link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: LoginScreen()),
        ),
      );

      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
    });
  });
}
```

- [ ] **Step 7: Run tests**

```bash
flutter test test/features/auth/login_screen_test.dart
```

Expected: All 3 tests PASS.

- [ ] **Step 8: Run app to verify visually**

```bash
flutter run -d chrome
```

Expected: App shows splash briefly, then redirects to login with dark theme, gold ANCESTRO logo, email/password fields, Log In button, social buttons, and signup link.

- [ ] **Step 9: Commit**

```bash
git add lib/features/auth/ lib/core/widgets/social_login_buttons.dart lib/core/router/app_router.dart
git commit -m "feat: add Splash and Login screens with AuthNotifier"
```

---

## Task 9: Auth Screens — Signup + OTP + Forgot/Reset Password + Success

**Files:**
- Create: `lib/features/auth/presentation/signup_screen.dart`
- Create: `lib/features/auth/presentation/forgot_password_screen.dart`
- Create: `lib/features/auth/presentation/otp_screen.dart`
- Create: `lib/features/auth/presentation/reset_password_screen.dart`
- Create: `lib/features/auth/presentation/success_screen.dart`
- Modify: `lib/core/router/app_router.dart` (wire new screens)

- [ ] **Step 1: Create SignupScreen**

Create `lib/features/auth/presentation/signup_screen.dart`:

```dart
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
  final _referralController = TextEditingController();
  UserRole _selectedRole = UserRole.customer;

  @override
  void initState() {
    super.initState();
    if (widget.referralCode != null) {
      _referralController.text = widget.referralCode!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && next.codeSent) {
        context.push(RouteNames.verifyCode);
      }
      if (next.status == AuthStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
        ref.read(authNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Logo
              Icon(Icons.energy_savings_leaf, color: AppColors.primary, size: 48),
              const SizedBox(height: 8),
              Text(
                'ANCESTRO',
                textAlign: TextAlign.center,
                style: AppTypography.heading.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 32),

              // Role selector
              Text(
                'I want to join as',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AncestroCard(
                      selected: _selectedRole == UserRole.customer,
                      onTap: () => setState(() => _selectedRole = UserRole.customer),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: _selectedRole == UserRole.customer
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Customer',
                            style: AppTypography.caption.copyWith(
                              color: _selectedRole == UserRole.customer
                                  ? AppColors.textPrimary
                                  : AppColors.textTertiary,
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
                      onTap: () => setState(() => _selectedRole = UserRole.partner),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(
                            Icons.handshake,
                            color: _selectedRole == UserRole.partner
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Partner',
                            style: AppTypography.caption.copyWith(
                              color: _selectedRole == UserRole.partner
                                  ? AppColors.textPrimary
                                  : AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Form
              AncestroInput(
                label: 'Email',
                hint: 'Email address',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Password',
                hint: 'Create a password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Referral Code (optional)',
                hint: 'Enter referral code',
                controller: _referralController,
                prefixIcon: Icons.card_giftcard,
              ),
              const SizedBox(height: 24),

              // Signup button
              AncestroButton(
                label: 'Sign Up',
                isLoading: isLoading,
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signUp(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        role: _selectedRole,
                        referralCode: _referralController.text.isNotEmpty
                            ? _referralController.text.trim()
                            : null,
                      );
                },
              ),
              const SizedBox(height: 16),

              // OR divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.surfaceBorder)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.surfaceBorder)),
                ],
              ),
              const SizedBox(height: 16),

              // Social login
              SocialLoginButtons(
                isLoading: isLoading,
                onGooglePressed: () =>
                    ref.read(authNotifierProvider.notifier).signInWithGoogle(),
                onApplePressed: () =>
                    ref.read(authNotifierProvider.notifier).signInWithApple(),
                onPhonePressed: () {},
              ),
              const SizedBox(height: 24),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.login),
                    child: Text(
                      'Log in',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create ForgotPasswordScreen**

Create `lib/features/auth/presentation/forgot_password_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../../../core/widgets/ancestro_input.dart';
import '../providers/auth_notifier.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && next.codeSent) {
        context.push(RouteNames.verifyCode);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Text(
                'Forgot Password',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Make sure you enter the email linked to your account.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              AncestroInput(
                label: 'Email',
                hint: 'Email address',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: 'Send Code',
                isLoading: isLoading,
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).forgotPassword(
                        email: _emailController.text.trim(),
                      );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create OtpScreen**

Create `lib/features/auth/presentation/otp_screen.dart`:

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/constants.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_radii.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/ancestro_button.dart';
import '../providers/auth_notifier.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(AppConstants.otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(AppConstants.otpLength, (_) => FocusNode());
  int _secondsRemaining = AppConstants.otpResendSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = AppConstants.otpResendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _otpCode =>
      _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && !next.codeSent) {
        context.go(RouteNames.login);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Text(
                'Enter Code',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We sent a verification code to\n${widget.email}',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(AppConstants.otpLength, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTypography.heading.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.small),
                          borderSide: const BorderSide(color: AppColors.surfaceBorder),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < AppConstants.otpLength - 1) {
                          _focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Resend
              Center(
                child: _secondsRemaining > 0
                    ? Text(
                        "Didn't get the code yet? Resend (0:${_secondsRemaining.toString().padLeft(2, '0')})",
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _startTimer();
                          ref.read(authNotifierProvider.notifier).forgotPassword(
                                email: widget.email,
                              );
                        },
                        child: Text(
                          'Resend Code',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 24),

              AncestroButton(
                label: 'Verify',
                isLoading: isLoading,
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).confirmSignUp(
                        email: widget.email,
                        code: _otpCode,
                      );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Create ResetPasswordScreen**

Create `lib/features/auth/presentation/reset_password_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
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
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next.status == AuthStatus.success && !next.codeSent) {
        AncestroModal.show(
          context,
          icon: Icons.check_circle,
          title: 'Password Reset!',
          message: 'Your password has been reset successfully.',
          buttonLabel: 'Continue to Login',
          onPressed: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Text(
                'Reset Password',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your new password below.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              AncestroInput(
                label: 'New Password',
                hint: 'Enter new password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              AncestroInput(
                label: 'Confirm Password',
                hint: 'Confirm new password',
                controller: _confirmController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: 'Reset Password',
                isLoading: isLoading,
                onPressed: () {
                  if (_passwordController.text != _confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }
                  ref
                      .read(authNotifierProvider.notifier)
                      .confirmForgotPassword(
                        email: widget.email,
                        code: widget.code,
                        newPassword: _passwordController.text,
                      );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Create SuccessScreen**

Create `lib/features/auth/presentation/success_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_radii.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/widgets/ancestro_button.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;
  final String navigateTo;

  const SuccessScreen({
    super.key,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.overlay,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.large),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.primaryTinted,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: AppTypography.subheading.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AncestroButton(
                label: buttonLabel,
                onPressed: () => context.go(navigateTo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: Wire all auth screens into router**

Update `lib/core/router/app_router.dart` — add imports and replace placeholder routes for signup, forgot, verify, reset:

```dart
// Add imports at top:
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/auth/presentation/success_screen.dart';

// Replace signup route:
GoRoute(
  path: RouteNames.signup,
  builder: (_, state) => SignupScreen(
    referralCode: state.uri.queryParameters['ref'],
  ),
),

// Replace forgot password route:
GoRoute(
  path: RouteNames.forgotPassword,
  builder: (_, __) => const ForgotPasswordScreen(),
),

// Replace verify code route:
GoRoute(
  path: RouteNames.verifyCode,
  builder: (_, state) => OtpScreen(
    email: state.uri.queryParameters['email'] ?? '',
  ),
),

// Replace reset password route:
GoRoute(
  path: RouteNames.resetPassword,
  builder: (_, state) => ResetPasswordScreen(
    email: state.uri.queryParameters['email'] ?? '',
    code: state.uri.queryParameters['code'] ?? '',
  ),
),
```

- [ ] **Step 7: Run app to verify full auth flow**

```bash
flutter run -d chrome
```

Expected: Can navigate Splash → Login → Signup (with role picker) → back to Login. Forgot Password shows email input. All screens use dark theme.

- [ ] **Step 8: Commit**

```bash
git add lib/features/auth/presentation/ lib/core/router/app_router.dart
git commit -m "feat: add Signup, ForgotPassword, OTP, ResetPassword, Success screens"
```

---

## Task 10: Solar Onboarding — Domain Models

**Files:**
- Create: `lib/features/onboarding_solar/domain/models/solar_onboarding_state.dart`
- Create: `lib/features/onboarding_solar/domain/models/basic_info.dart`
- Create: `lib/features/onboarding_solar/domain/models/property_info.dart`
- Create: `lib/features/onboarding_solar/domain/models/solar_proposal.dart`
- Create: `lib/features/onboarding_solar/domain/models/uploaded_document.dart`
- Create: `lib/features/onboarding_solar/domain/models/agreement.dart`
- Create: `lib/features/onboarding_solar/domain/models/property_photo.dart`
- Create: `lib/features/onboarding_solar/domain/models/inspection_schedule.dart`
- Create: `lib/features/onboarding_solar/domain/solar_repository.dart`

- [ ] **Step 1: Create all Freezed models**

Create `lib/features/onboarding_solar/domain/models/basic_info.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_info.freezed.dart';
part 'basic_info.g.dart';

@freezed
class BasicInfo with _$BasicInfo {
  const factory BasicInfo({
    required String fullName,
    required String phone,
    required String address,
    String? city,
    String? state,
    String? zipCode,
  }) = _BasicInfo;

  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/property_info.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_info.freezed.dart';
part 'property_info.g.dart';

enum PropertyType { singleFamily, multiFamily, commercial, other }

@freezed
class PropertyInfo with _$PropertyInfo {
  const factory PropertyInfo({
    required PropertyType propertyType,
    required double roofSizeSqFt,
    required double monthlyConsumptionKwh,
    String? utilityProvider,
  }) = _PropertyInfo;

  factory PropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$PropertyInfoFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/solar_proposal.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'solar_proposal.freezed.dart';
part 'solar_proposal.g.dart';

@freezed
class SolarProposal with _$SolarProposal {
  const factory SolarProposal({
    required double systemSizeKw,
    required int numberOfPanels,
    required double estimatedAnnualProductionKwh,
    required double monthlySavings,
    required double totalCost,
    required double monthlyPayment,
    required int coverageYears,
    String? propertyImageUrl,
  }) = _SolarProposal;

  factory SolarProposal.fromJson(Map<String, dynamic> json) =>
      _$SolarProposalFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/uploaded_document.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'uploaded_document.freezed.dart';
part 'uploaded_document.g.dart';

enum DocumentType { financialProof, idFront, idBack }

@freezed
class UploadedDocument with _$UploadedDocument {
  const factory UploadedDocument({
    required String id,
    required DocumentType type,
    required String filePath,
    required DateTime uploadedAt,
  }) = _UploadedDocument;

  factory UploadedDocument.fromJson(Map<String, dynamic> json) =>
      _$UploadedDocumentFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/agreement.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agreement.freezed.dart';
part 'agreement.g.dart';

@freezed
class Agreement with _$Agreement {
  const factory Agreement({
    required String id,
    required String title,
    required String content,
    @Default(false) bool accepted,
  }) = _Agreement;

  factory Agreement.fromJson(Map<String, dynamic> json) =>
      _$AgreementFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/property_photo.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_photo.freezed.dart';
part 'property_photo.g.dart';

enum PhotoCategory { roofFront, roofBack, electricalPanel, meter }

@freezed
class PropertyPhoto with _$PropertyPhoto {
  const factory PropertyPhoto({
    required String id,
    required PhotoCategory category,
    required String filePath,
    required DateTime uploadedAt,
  }) = _PropertyPhoto;

  factory PropertyPhoto.fromJson(Map<String, dynamic> json) =>
      _$PropertyPhotoFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/inspection_schedule.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_schedule.freezed.dart';
part 'inspection_schedule.g.dart';

@freezed
class InspectionSchedule with _$InspectionSchedule {
  const factory InspectionSchedule({
    required DateTime date,
    required String timeSlot,
    String? inspectorName,
    String? inspectorPhoto,
    String? inspectorPhone,
  }) = _InspectionSchedule;

  factory InspectionSchedule.fromJson(Map<String, dynamic> json) =>
      _$InspectionScheduleFromJson(json);
}
```

Create `lib/features/onboarding_solar/domain/models/solar_onboarding_state.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'basic_info.dart';
import 'property_info.dart';
import 'solar_proposal.dart';
import 'uploaded_document.dart';
import 'agreement.dart';
import 'property_photo.dart';
import 'inspection_schedule.dart';

part 'solar_onboarding_state.freezed.dart';
part 'solar_onboarding_state.g.dart';

enum SystemType { solar, ev, both }
enum CreditStatus { pending, approved, denied }

@freezed
class SolarOnboardingState with _$SolarOnboardingState {
  const factory SolarOnboardingState({
    @Default(0) int currentStep,
    @Default(SystemType.solar) SystemType systemType,
    BasicInfo? basicInfo,
    PropertyInfo? propertyInfo,
    SolarProposal? proposal,
    @Default(CreditStatus.pending) CreditStatus creditStatus,
    @Default([]) List<UploadedDocument> documents,
    @Default([]) List<Agreement> agreements,
    @Default([]) List<PropertyPhoto> propertyPhotos,
    InspectionSchedule? inspection,
    @Default(false) bool completed,
  }) = _SolarOnboardingState;

  factory SolarOnboardingState.fromJson(Map<String, dynamic> json) =>
      _$SolarOnboardingStateFromJson(json);
}
```

- [ ] **Step 2: Create SolarRepository interface**

Create `lib/features/onboarding_solar/domain/solar_repository.dart`:

```dart
import 'models/basic_info.dart';
import 'models/property_info.dart';
import 'models/solar_proposal.dart';
import 'models/agreement.dart';
import 'models/inspection_schedule.dart';
import 'models/solar_onboarding_state.dart';

abstract class SolarRepository {
  Future<SolarProposal> generateProposal({
    required BasicInfo basicInfo,
    required PropertyInfo propertyInfo,
    required SystemType systemType,
  });

  Future<CreditStatus> checkCredit({required String userId});

  Future<List<Agreement>> getAgreements();

  Future<void> submitDocuments({required List<String> filePaths});

  Future<void> submitPropertyPhotos({required List<String> filePaths});

  Future<Map<String, String>> reviewPropertyPhotos();

  Future<List<DateTime>> getAvailableInspectionDates();

  Future<InspectionSchedule> scheduleInspection({
    required DateTime date,
    required String timeSlot,
  });

  Future<void> completeOnboarding({required String userId});
}
```

- [ ] **Step 3: Run code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: All `.freezed.dart` and `.g.dart` files generated without errors.

- [ ] **Step 4: Run analyze**

```bash
flutter analyze
```

Expected: No issues.

- [ ] **Step 5: Commit**

```bash
git add lib/features/onboarding_solar/domain/
git commit -m "feat: add solar onboarding domain models (Freezed) and repository interface"
```

---

## Task 11: Solar Onboarding — Mock Repository + Notifier

**Files:**
- Create: `lib/features/onboarding_solar/data/mock_solar_repository.dart`
- Create: `lib/features/onboarding_solar/presentation/providers/solar_onboarding_notifier.dart`
- Create: `test/features/onboarding_solar/solar_onboarding_notifier_test.dart`

- [ ] **Step 1: Write failing test for SolarOnboardingNotifier**

Create `test/features/onboarding_solar/solar_onboarding_notifier_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/features/onboarding_solar/data/mock_solar_repository.dart';
import 'package:ancestro/features/onboarding_solar/domain/models/solar_onboarding_state.dart';
import 'package:ancestro/features/onboarding_solar/domain/models/basic_info.dart';
import 'package:ancestro/features/onboarding_solar/domain/models/property_info.dart';
import 'package:ancestro/features/onboarding_solar/presentation/providers/solar_onboarding_notifier.dart';

void main() {
  late MockSolarRepository repo;
  late SolarOnboardingNotifier notifier;

  setUp(() {
    repo = MockSolarRepository();
    notifier = SolarOnboardingNotifier(repo);
  });

  group('SolarOnboardingNotifier', () {
    test('initial state has step 0', () {
      expect(notifier.state.currentStep, 0);
      expect(notifier.state.completed, isFalse);
    });

    test('selectSystemType updates state', () {
      notifier.selectSystemType(SystemType.both);
      expect(notifier.state.systemType, SystemType.both);
    });

    test('setBasicInfo stores info and advances step', () {
      final info = BasicInfo(
        fullName: 'John Doe',
        phone: '+1234567890',
        address: '123 Main St',
      );
      notifier.setBasicInfo(info);
      expect(notifier.state.basicInfo, info);
    });

    test('setPropertyInfo stores info', () {
      final info = PropertyInfo(
        propertyType: PropertyType.singleFamily,
        roofSizeSqFt: 2000,
        monthlyConsumptionKwh: 800,
      );
      notifier.setPropertyInfo(info);
      expect(notifier.state.propertyInfo, info);
    });

    test('generateProposal returns proposal from mock', () async {
      notifier.setBasicInfo(BasicInfo(
        fullName: 'Test',
        phone: '123',
        address: 'Address',
      ));
      notifier.setPropertyInfo(PropertyInfo(
        propertyType: PropertyType.singleFamily,
        roofSizeSqFt: 2000,
        monthlyConsumptionKwh: 800,
      ));

      await notifier.generateProposal();
      expect(notifier.state.proposal, isNotNull);
      expect(notifier.state.proposal!.systemSizeKw, greaterThan(0));
    });

    test('goToStep updates currentStep', () {
      notifier.goToStep(5);
      expect(notifier.state.currentStep, 5);
    });

    test('nextStep increments currentStep', () {
      notifier.nextStep();
      expect(notifier.state.currentStep, 1);
      notifier.nextStep();
      expect(notifier.state.currentStep, 2);
    });

    test('previousStep decrements currentStep but not below 0', () {
      notifier.nextStep();
      notifier.nextStep();
      notifier.previousStep();
      expect(notifier.state.currentStep, 1);
      notifier.previousStep();
      expect(notifier.state.currentStep, 0);
      notifier.previousStep();
      expect(notifier.state.currentStep, 0);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/onboarding_solar/solar_onboarding_notifier_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Implement MockSolarRepository**

Create `lib/features/onboarding_solar/data/mock_solar_repository.dart`:

```dart
import '../../../core/config/constants.dart';
import '../domain/models/basic_info.dart';
import '../domain/models/property_info.dart';
import '../domain/models/solar_proposal.dart';
import '../domain/models/agreement.dart';
import '../domain/models/inspection_schedule.dart';
import '../domain/models/solar_onboarding_state.dart';
import '../domain/solar_repository.dart';

class MockSolarRepository implements SolarRepository {
  @override
  Future<SolarProposal> generateProposal({
    required BasicInfo basicInfo,
    required PropertyInfo propertyInfo,
    required SystemType systemType,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    final sizeKw = propertyInfo.roofSizeSqFt / 200;
    return SolarProposal(
      systemSizeKw: sizeKw,
      numberOfPanels: (sizeKw / 0.4).round(),
      estimatedAnnualProductionKwh: sizeKw * 1400,
      monthlySavings: propertyInfo.monthlyConsumptionKwh * 0.12 * 0.85,
      totalCost: sizeKw * 2800,
      monthlyPayment: (sizeKw * 2800) / 240,
      coverageYears: 20,
    );
  }

  @override
  Future<CreditStatus> checkCredit({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
    return CreditStatus.approved;
  }

  @override
  Future<List<Agreement>> getAgreements() async {
    await Future.delayed(AppConstants.mockDelay);
    return [
      const Agreement(
        id: 'agreement-1',
        title: 'Solar Installation Agreement',
        content: 'This agreement covers the terms and conditions of your solar panel installation...',
      ),
      const Agreement(
        id: 'agreement-2',
        title: 'Service Level Agreement',
        content: 'This SLA covers maintenance, monitoring, and support for your solar system...',
      ),
      const Agreement(
        id: 'agreement-3',
        title: 'Terms of Service',
        content: 'By using Ancestro services, you agree to the following terms and conditions...',
      ),
    ];
  }

  @override
  Future<void> submitDocuments({required List<String> filePaths}) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<void> submitPropertyPhotos({required List<String> filePaths}) async {
    await Future.delayed(AppConstants.mockDelay);
  }

  @override
  Future<Map<String, String>> reviewPropertyPhotos() async {
    await Future.delayed(AppConstants.mockDelay);
    return {
      'roofCondition': 'Good — suitable for installation',
      'electricalPanel': 'Compatible — 200A service',
      'shading': 'Minimal — high solar potential',
    };
  }

  @override
  Future<List<DateTime>> getAvailableInspectionDates() async {
    await Future.delayed(AppConstants.mockDelay);
    final now = DateTime.now();
    return List.generate(14, (i) => now.add(Duration(days: i + 3)));
  }

  @override
  Future<InspectionSchedule> scheduleInspection({
    required DateTime date,
    required String timeSlot,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
    return InspectionSchedule(
      date: date,
      timeSlot: timeSlot,
      inspectorName: 'Carlos Rivera',
      inspectorPhone: '+1 (555) 012-3456',
    );
  }

  @override
  Future<void> completeOnboarding({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
  }
}
```

- [ ] **Step 4: Implement SolarOnboardingNotifier**

Create `lib/features/onboarding_solar/presentation/providers/solar_onboarding_notifier.dart`:

```dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/auth/auth_providers.dart';
import '../../../../core/config/env.dart';
import '../../data/mock_solar_repository.dart';
import '../../domain/models/basic_info.dart';
import '../../domain/models/property_info.dart';
import '../../domain/models/solar_onboarding_state.dart';
import '../../domain/solar_repository.dart';

class SolarOnboardingNotifier extends StateNotifier<SolarOnboardingState> {
  final SolarRepository _repo;

  SolarOnboardingNotifier(this._repo)
      : super(const SolarOnboardingState());

  void selectSystemType(SystemType type) {
    state = state.copyWith(systemType: type);
  }

  void setBasicInfo(BasicInfo info) {
    state = state.copyWith(basicInfo: info);
  }

  void setPropertyInfo(PropertyInfo info) {
    state = state.copyWith(propertyInfo: info);
  }

  Future<void> generateProposal() async {
    if (state.basicInfo == null || state.propertyInfo == null) return;
    final proposal = await _repo.generateProposal(
      basicInfo: state.basicInfo!,
      propertyInfo: state.propertyInfo!,
      systemType: state.systemType,
    );
    state = state.copyWith(proposal: proposal);
  }

  Future<void> checkCredit(String userId) async {
    final status = await _repo.checkCredit(userId: userId);
    state = state.copyWith(creditStatus: status);
  }

  Future<void> loadAgreements() async {
    final agreements = await _repo.getAgreements();
    state = state.copyWith(agreements: agreements);
  }

  void acceptAgreement(String id) {
    final updated = state.agreements.map((a) {
      return a.id == id ? a.copyWith(accepted: true) : a;
    }).toList();
    state = state.copyWith(agreements: updated);
  }

  Future<void> scheduleInspection(DateTime date, String timeSlot) async {
    final schedule = await _repo.scheduleInspection(
      date: date,
      timeSlot: timeSlot,
    );
    state = state.copyWith(inspection: schedule);
  }

  void goToStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
    _persistState();
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void complete() {
    state = state.copyWith(completed: true);
    _persistState();
  }

  Future<void> _persistState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'solar_onboarding',
      jsonEncode(state.toJson()),
    );
  }

  Future<void> restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('solar_onboarding');
    if (json != null) {
      state = SolarOnboardingState.fromJson(jsonDecode(json));
    }
  }
}

final solarRepositoryProvider = Provider<SolarRepository>((ref) {
  if (Env.useMocks) return MockSolarRepository();
  return MockSolarRepository(); // Replace with real impl when ready
});

final solarOnboardingProvider =
    StateNotifierProvider<SolarOnboardingNotifier, SolarOnboardingState>((ref) {
  final repo = ref.watch(solarRepositoryProvider);
  return SolarOnboardingNotifier(repo);
});
```

- [ ] **Step 5: Run test to verify it passes**

```bash
flutter test test/features/onboarding_solar/solar_onboarding_notifier_test.dart
```

Expected: All 7 tests PASS.

- [ ] **Step 6: Commit**

```bash
git add lib/features/onboarding_solar/data/ lib/features/onboarding_solar/presentation/providers/ test/features/onboarding_solar/
git commit -m "feat: add MockSolarRepository, SolarOnboardingNotifier with tests"
```

---

## Task 12: Solar Onboarding — Screens (Steps 1-7)

**Files:**
- Create: 7 screen files in `lib/features/onboarding_solar/presentation/screens/`
- Modify: `lib/core/router/app_router.dart`

Due to the size of this task, I'll provide the first 3 screens with full code. Screens 4-7 follow the same pattern: SafeArea + Column + Expanded content + AncestroButton at bottom calling `notifier.nextStep()` and `context.go(nextRoute)`.

- [ ] **Step 1: Create ChooseFlowScreen**

Create `lib/features/onboarding_solar/presentation/screens/choose_flow_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../../domain/models/solar_onboarding_state.dart';
import '../providers/solar_onboarding_notifier.dart';

class ChooseFlowScreen extends ConsumerWidget {
  const ChooseFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Icon(Icons.energy_savings_leaf, color: AppColors.primary, size: 48),
              const SizedBox(height: 16),
              Text(
                'Choose Your System',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the type of system you are interested in.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  children: [
                    _SystemCard(
                      icon: Icons.solar_power,
                      title: 'Solar',
                      description: 'Solar panels for your home',
                      selected: state.systemType == SystemType.solar,
                      onTap: () => ref
                          .read(solarOnboardingProvider.notifier)
                          .selectSystemType(SystemType.solar),
                    ),
                    const SizedBox(height: 12),
                    _SystemCard(
                      icon: Icons.ev_station,
                      title: 'EV Charging',
                      description: 'Electric vehicle charging station',
                      selected: state.systemType == SystemType.ev,
                      onTap: () => ref
                          .read(solarOnboardingProvider.notifier)
                          .selectSystemType(SystemType.ev),
                    ),
                    const SizedBox(height: 12),
                    _SystemCard(
                      icon: Icons.bolt,
                      title: 'Solar + EV',
                      description: 'Complete energy solution',
                      selected: state.systemType == SystemType.both,
                      onTap: () => ref
                          .read(solarOnboardingProvider.notifier)
                          .selectSystemType(SystemType.both),
                    ),
                  ],
                ),
              ),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  ref.read(solarOnboardingProvider.notifier).nextStep();
                  context.go(RouteNames.solarIntro);
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

class _SystemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const _SystemCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AncestroCard(
      selected: selected,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: selected ? AppColors.primaryTinted : AppColors.inputFill,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  description,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, color: AppColors.primary, size: 24),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Create BasicInfoScreen**

Create `lib/features/onboarding_solar/presentation/screens/basic_info_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../domain/models/basic_info.dart';
import '../providers/solar_onboarding_notifier.dart';

class BasicInfoScreen extends ConsumerStatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  ConsumerState<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends ConsumerState<BasicInfoScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Basic Info', style: AppTypography.bodyMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Tell us about yourself',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AncestroInput(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        controller: _nameController,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      AncestroInput(
                        label: 'Phone Number',
                        hint: '+1 (555) 000-0000',
                        controller: _phoneController,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      AncestroInput(
                        label: 'Address',
                        hint: 'Enter your property address',
                        controller: _addressController,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  final info = BasicInfo(
                    fullName: _nameController.text.trim(),
                    phone: _phoneController.text.trim(),
                    address: _addressController.text.trim(),
                  );
                  ref.read(solarOnboardingProvider.notifier).setBasicInfo(info);
                  ref.read(solarOnboardingProvider.notifier).nextStep();
                  context.go(RouteNames.solarProperty);
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
```

- [ ] **Step 3: Create remaining screens as placeholder wrappers**

For screens 2-3 and 5-7, create minimal implementations that follow the same pattern. Each screen: back button, title, content area, Continue button advancing to the next route.

Create `lib/features/onboarding_solar/presentation/screens/intro_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class IntroScreen extends ConsumerWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Icon(Icons.solar_power, color: AppColors.primary, size: 80),
              const SizedBox(height: 24),
              Text(
                'Your Solar Journey\nStarts Here',
                textAlign: TextAlign.center,
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We\'ll guide you through the process of going solar. It only takes a few minutes.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 3),
              AncestroButton(
                label: 'Get Started',
                onPressed: () {
                  ref.read(solarOnboardingProvider.notifier).nextStep();
                  context.go(RouteNames.solarProposal);
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
```

Create `lib/features/onboarding_solar/presentation/screens/proposal_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../providers/solar_onboarding_notifier.dart';

class ProposalScreen extends ConsumerWidget {
  const ProposalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background placeholder for aerial solar photo
            Container(color: AppColors.surface),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withOpacity(0.9),
                    AppColors.background,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2),
                  Row(
                    children: [
                      Icon(Icons.solar_power, color: AppColors.primary, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'Solar Proposal',
                        style: AppTypography.subheading.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Get an instant solar proposal for your property.',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(flex: 1),
                  AncestroButton(
                    label: 'Continue',
                    onPressed: () {
                      ref.read(solarOnboardingProvider.notifier).nextStep();
                      context.go(RouteNames.solarBasicInfo);
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Create `lib/features/onboarding_solar/presentation/screens/property_info_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_input.dart';
import '../../domain/models/property_info.dart';
import '../providers/solar_onboarding_notifier.dart';

class PropertyInfoScreen extends ConsumerStatefulWidget {
  const PropertyInfoScreen({super.key});

  @override
  ConsumerState<PropertyInfoScreen> createState() => _PropertyInfoScreenState();
}

class _PropertyInfoScreenState extends ConsumerState<PropertyInfoScreen> {
  final _roofSizeController = TextEditingController();
  final _consumptionController = TextEditingController();
  PropertyType _propertyType = PropertyType.singleFamily;

  @override
  void dispose() {
    _roofSizeController.dispose();
    _consumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Property Info', style: AppTypography.bodyMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Tell us about your property',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Property Type',
                        style: AppTypography.label.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<PropertyType>(
                        value: _propertyType,
                        dropdownColor: AppColors.surface,
                        items: PropertyType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name, style: AppTypography.body),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) setState(() => _propertyType = value);
                        },
                      ),
                      const SizedBox(height: 16),
                      AncestroInput(
                        label: 'Roof Size (sq ft)',
                        hint: 'e.g. 2000',
                        controller: _roofSizeController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      AncestroInput(
                        label: 'Monthly Consumption (kWh)',
                        hint: 'e.g. 800',
                        controller: _consumptionController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              AncestroButton(
                label: 'Continue',
                onPressed: () {
                  final info = PropertyInfo(
                    propertyType: _propertyType,
                    roofSizeSqFt: double.tryParse(_roofSizeController.text) ?? 0,
                    monthlyConsumptionKwh:
                        double.tryParse(_consumptionController.text) ?? 0,
                  );
                  ref.read(solarOnboardingProvider.notifier).setPropertyInfo(info);
                  ref.read(solarOnboardingProvider.notifier).nextStep();
                  context.go(RouteNames.solarAlmostDone);
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
```

Create `lib/features/onboarding_solar/presentation/screens/almost_done_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_loading.dart';
import '../providers/solar_onboarding_notifier.dart';

class AlmostDoneScreen extends ConsumerStatefulWidget {
  const AlmostDoneScreen({super.key});

  @override
  ConsumerState<AlmostDoneScreen> createState() => _AlmostDoneScreenState();
}

class _AlmostDoneScreenState extends ConsumerState<AlmostDoneScreen> {
  bool _generating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _generating
              ? const AncestroLoading(message: 'Generating your solar proposal...')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 1),
                    Icon(Icons.check_circle_outline,
                        color: AppColors.primary, size: 64),
                    const SizedBox(height: 24),
                    Text(
                      'Just one more step!',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We have all the information we need to generate your instant solar proposal.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(flex: 2),
                    AncestroButton(
                      label: 'Generate My Proposal',
                      onPressed: () async {
                        setState(() => _generating = true);
                        await ref
                            .read(solarOnboardingProvider.notifier)
                            .generateProposal();
                        ref.read(solarOnboardingProvider.notifier).nextStep();
                        if (mounted) {
                          context.go(RouteNames.solarInstantProposal);
                        }
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
```

Create `lib/features/onboarding_solar/presentation/screens/instant_proposal_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_radii.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/ancestro_button.dart';
import '../../../../core/widgets/ancestro_card.dart';
import '../providers/solar_onboarding_notifier.dart';

class InstantProposalScreen extends ConsumerWidget {
  const InstantProposalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(solarOnboardingProvider);
    final proposal = state.proposal;

    if (proposal == null) {
      return const Scaffold(
        body: Center(child: Text('No proposal available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Your Solar Proposal', style: AppTypography.bodyMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Proposal card
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // System image placeholder
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadii.medium),
                        ),
                        child: const Center(
                          child: Icon(Icons.home, color: AppColors.textTertiary, size: 64),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _ProposalRow('System Size', '${proposal.systemSizeKw.toStringAsFixed(1)} kW'),
                      _ProposalRow('Number of Panels', '${proposal.numberOfPanels}'),
                      _ProposalRow('Annual Production', '${proposal.estimatedAnnualProductionKwh.toStringAsFixed(0)} kWh'),
                      _ProposalRow('Monthly Savings', '\$${proposal.monthlySavings.toStringAsFixed(2)}'),
                      _ProposalRow('Total Cost', '\$${proposal.totalCost.toStringAsFixed(2)}'),
                      _ProposalRow('Monthly Payment', '\$${proposal.monthlyPayment.toStringAsFixed(2)}'),
                      _ProposalRow('Coverage', '${proposal.coverageYears} years'),
                    ],
                  ),
                ),
              ),

              AncestroButton(
                label: 'Continue to Checkout',
                onPressed: () {
                  ref.read(solarOnboardingProvider.notifier).nextStep();
                  context.go(RouteNames.solarConfirm);
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

class _ProposalRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProposalRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Wire screens into router**

Update `lib/core/router/app_router.dart` — add imports and replace placeholders for solar steps 1-7:

```dart
// Add imports:
import '../../features/onboarding_solar/presentation/screens/choose_flow_screen.dart';
import '../../features/onboarding_solar/presentation/screens/intro_screen.dart';
import '../../features/onboarding_solar/presentation/screens/proposal_screen.dart';
import '../../features/onboarding_solar/presentation/screens/basic_info_screen.dart';
import '../../features/onboarding_solar/presentation/screens/property_info_screen.dart';
import '../../features/onboarding_solar/presentation/screens/almost_done_screen.dart';
import '../../features/onboarding_solar/presentation/screens/instant_proposal_screen.dart';

// Replace routes:
GoRoute(path: RouteNames.solarOnboarding, builder: (_, __) => const ChooseFlowScreen()),
GoRoute(path: RouteNames.solarIntro, builder: (_, __) => const IntroScreen()),
GoRoute(path: RouteNames.solarProposal, builder: (_, __) => const ProposalScreen()),
GoRoute(path: RouteNames.solarBasicInfo, builder: (_, __) => const BasicInfoScreen()),
GoRoute(path: RouteNames.solarProperty, builder: (_, __) => const PropertyInfoScreen()),
GoRoute(path: RouteNames.solarAlmostDone, builder: (_, __) => const AlmostDoneScreen()),
GoRoute(path: RouteNames.solarInstantProposal, builder: (_, __) => const InstantProposalScreen()),
```

- [ ] **Step 5: Run app and test flow**

```bash
flutter run -d chrome
```

Expected: After login (mock), user is redirected to Choose Flow → Intro → Proposal → Basic Info → Property → Almost Done → Instant Proposal. All screens use dark theme, gold accents.

- [ ] **Step 6: Commit**

```bash
git add lib/features/onboarding_solar/presentation/screens/ lib/core/router/app_router.dart
git commit -m "feat: add solar onboarding screens steps 1-7 (ChooseFlow through InstantProposal)"
```

---

## Task 13: Solar Onboarding — Screens (Steps 8-21)

**Files:**
- Create: 14 screen files in `lib/features/onboarding_solar/presentation/screens/`
- Modify: `lib/core/router/app_router.dart`

These screens follow the same structural pattern. Each has: AppBar with back, title/content area, action button at bottom. I'll provide the key screens with unique UI elements and leave the simpler ones as pattern-consistent implementations.

- [ ] **Step 1: Create remaining 14 screens**

The following screens need to be created. Each follows the pattern: Scaffold → SafeArea → Column → [content] → AncestroButton → nextStep + context.go(nextRoute).

Create each file in `lib/features/onboarding_solar/presentation/screens/`:

- `confirm_service_screen.dart` — displays service details from proposal, "Confirm & Activate Services" button → credit
- `credit_check_screen.dart` — shows Approved/Denied with ProductionChartCard mockup, Continue button → coverage or alternatives
- `coverage_plan_screen.dart` — 20-year coverage details, "Proceed to Checkout" → reserve
- `reserve_system_screen.dart` — CheckoutView with payment placeholder, Reserve button → reserving
- `reserving_spot_screen.dart` — AncestroLoading + message, auto-advances after delay → finances
- `finances_doc_screen.dart` — document upload buttons (camera/gallery via image_picker), Continue → verify-identity
- `verify_identity_screen.dart` — ID front/back upload, Continue → agreements
- `agreements_screen.dart` — list of Agreement cards with checkboxes, Continue when all accepted → last-step
- `inner_agreement_screen.dart` — scrollable agreement text, "Continue" button
- `last_step_screen.dart` — photo upload grid (4 categories), Continue → property-review
- `property_review_screen.dart` — review results from mock, Continue → schedule
- `schedule_inspection_screen.dart` — date picker + time slots, Continue → confirm-inspection
- `confirm_inspection_screen.dart` — appointment summary, Confirm → inspector
- `meet_inspector_screen.dart` — inspector profile card, "Done" completes onboarding

Each screen follows the exact same code structure as the screens in Task 12. The notifier's `nextStep()` is called before `context.go()`.

For `meet_inspector_screen.dart`, the Done button calls `notifier.complete()` and navigates to `/home`.

- [ ] **Step 2: Wire all remaining screens into router**

Update `lib/core/router/app_router.dart` — add imports and replace all remaining solar placeholder routes.

- [ ] **Step 3: Run app and test complete solar flow**

```bash
flutter run -d chrome
```

Expected: Complete flow from Choose Flow through Meet Inspector, 21 screens, all navigating correctly.

- [ ] **Step 4: Commit**

```bash
git add lib/features/onboarding_solar/presentation/screens/ lib/core/router/app_router.dart
git commit -m "feat: add solar onboarding screens steps 8-21 (ConfirmService through MeetInspector)"
```

---

## Task 14: Partner Onboarding — Domain + Mock + Notifier

**Files:**
- Create: `lib/features/onboarding_partner/domain/models/partner_type.dart`
- Create: `lib/features/onboarding_partner/domain/models/partner_onboarding_state.dart`
- Create: `lib/features/onboarding_partner/domain/models/partner_contact.dart`
- Create: `lib/features/onboarding_partner/domain/models/partner_field_config.dart`
- Create: `lib/features/onboarding_partner/domain/partner_field_definitions.dart`
- Create: `lib/features/onboarding_partner/domain/partner_repository.dart`
- Create: `lib/features/onboarding_partner/data/mock_partner_repository.dart`
- Create: `lib/features/onboarding_partner/presentation/providers/partner_onboarding_notifier.dart`
- Create: `test/features/onboarding_partner/partner_onboarding_notifier_test.dart`
- Create: `test/features/onboarding_partner/partner_field_definitions_test.dart`

- [ ] **Step 1: Write failing tests**

Create `test/features/onboarding_partner/partner_onboarding_notifier_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/core/auth/auth_user.dart';
import 'package:ancestro/features/onboarding_partner/data/mock_partner_repository.dart';
import 'package:ancestro/features/onboarding_partner/domain/models/partner_contact.dart';
import 'package:ancestro/features/onboarding_partner/domain/models/partner_onboarding_state.dart';
import 'package:ancestro/features/onboarding_partner/presentation/providers/partner_onboarding_notifier.dart';

void main() {
  late MockPartnerRepository repo;
  late PartnerOnboardingNotifier notifier;

  setUp(() {
    repo = MockPartnerRepository();
    notifier = PartnerOnboardingNotifier(repo);
  });

  group('PartnerOnboardingNotifier', () {
    test('initial state is step 0', () {
      expect(notifier.state.currentStep, 0);
    });

    test('selectPartnerType updates state', () {
      notifier.selectPartnerType(PartnerType.instaladorCertificado);
      expect(notifier.state.partnerType, PartnerType.instaladorCertificado);
    });

    test('setContact stores contact info', () {
      final contact = PartnerContact(
        fullName: 'Test User',
        email: 'test@example.com',
        phone: '123',
        country: 'Colombia',
        city: 'Bogota',
      );
      notifier.setContact(contact);
      expect(notifier.state.contact, contact);
    });

    test('setDetails stores dynamic fields', () {
      notifier.setDetails({'specialty': 'Solar', 'years': '10'});
      expect(notifier.state.details['specialty'], 'Solar');
    });

    test('nextStep increments', () {
      notifier.nextStep();
      expect(notifier.state.currentStep, 1);
    });

    test('submit calls repository', () async {
      notifier.selectPartnerType(PartnerType.socioInversionista);
      notifier.setContact(PartnerContact(
        fullName: 'Test',
        email: 'test@test.com',
        phone: '123',
        country: 'CO',
        city: 'Bogota',
      ));
      notifier.setDetails({'amount': '100000'});
      await notifier.submit();
      expect(notifier.state.completed, isTrue);
    });
  });
}
```

Create `test/features/onboarding_partner/partner_field_definitions_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/core/auth/auth_user.dart';
import 'package:ancestro/features/onboarding_partner/domain/partner_field_definitions.dart';

void main() {
  group('PartnerFieldDefinitions', () {
    test('all 7 partner types have field definitions', () {
      for (final type in PartnerType.values) {
        final fields = PartnerFieldDefinitions.fieldsFor(type);
        expect(fields, isNotEmpty, reason: '$type should have fields');
      }
    });

    test('socioInversionista has investment-related fields', () {
      final fields = PartnerFieldDefinitions.fieldsFor(
        PartnerType.socioInversionista,
      );
      final keys = fields.map((f) => f.key).toList();
      expect(keys, contains('investmentAmount'));
      expect(keys, contains('investmentHorizon'));
    });

    test('instaladorCertificado has certification fields', () {
      final fields = PartnerFieldDefinitions.fieldsFor(
        PartnerType.instaladorCertificado,
      );
      final keys = fields.map((f) => f.key).toList();
      expect(keys, contains('certifications'));
      expect(keys, contains('yearsExperience'));
    });
  });
}
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
flutter test test/features/onboarding_partner/
```

Expected: FAIL.

- [ ] **Step 3: Create domain models**

Create `lib/features/onboarding_partner/domain/models/partner_contact.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_contact.freezed.dart';
part 'partner_contact.g.dart';

@freezed
class PartnerContact with _$PartnerContact {
  const factory PartnerContact({
    required String fullName,
    required String email,
    required String phone,
    required String country,
    required String city,
    String? company,
  }) = _PartnerContact;

  factory PartnerContact.fromJson(Map<String, dynamic> json) =>
      _$PartnerContactFromJson(json);
}
```

Create `lib/features/onboarding_partner/domain/models/partner_field_config.dart`:

```dart
enum FieldType { text, number, dropdown, multiSelect, textarea, fileUpload }

class PartnerFieldConfig {
  final String key;
  final String label;
  final FieldType type;
  final List<String>? options;
  final bool required;

  const PartnerFieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.options,
    this.required = true,
  });
}
```

Create `lib/features/onboarding_partner/domain/models/partner_onboarding_state.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/auth/auth_user.dart';
import 'partner_contact.dart';

part 'partner_onboarding_state.freezed.dart';
part 'partner_onboarding_state.g.dart';

@freezed
class PartnerOnboardingState with _$PartnerOnboardingState {
  const factory PartnerOnboardingState({
    @Default(0) int currentStep,
    PartnerType? partnerType,
    PartnerContact? contact,
    @Default({}) Map<String, dynamic> details,
    @Default(false) bool completed,
  }) = _PartnerOnboardingState;

  factory PartnerOnboardingState.fromJson(Map<String, dynamic> json) =>
      _$PartnerOnboardingStateFromJson(json);
}
```

- [ ] **Step 4: Create field definitions for all 7 types**

Create `lib/features/onboarding_partner/domain/partner_field_definitions.dart`:

```dart
import '../../../core/auth/auth_user.dart';
import 'models/partner_field_config.dart';

class PartnerFieldDefinitions {
  PartnerFieldDefinitions._();

  static List<PartnerFieldConfig> fieldsFor(PartnerType type) {
    return switch (type) {
      PartnerType.socioInversionista => _socioInversionista,
      PartnerType.socioEstrategico => _socioEstrategico,
      PartnerType.instaladorCertificado => _instaladorCertificado,
      PartnerType.empresaEnergia => _empresaEnergia,
      PartnerType.socioLogistica => _socioLogistica,
      PartnerType.asesorConsultor => _asesorConsultor,
      PartnerType.gobiernoMunicipio => _gobiernoMunicipio,
    };
  }

  static const _socioInversionista = [
    PartnerFieldConfig(
      key: 'investmentAmount',
      label: 'Investment Amount Range',
      type: FieldType.dropdown,
      options: ['\$10K - \$50K', '\$50K - \$100K', '\$100K - \$500K', '\$500K+'],
    ),
    PartnerFieldConfig(
      key: 'investmentHorizon',
      label: 'Investment Horizon',
      type: FieldType.dropdown,
      options: ['1-2 years', '3-5 years', '5-10 years', '10+ years'],
    ),
    PartnerFieldConfig(
      key: 'previousExperience',
      label: 'Previous Investment Experience',
      type: FieldType.text,
      required: false,
    ),
    PartnerFieldConfig(
      key: 'areasOfInterest',
      label: 'Areas of Interest',
      type: FieldType.multiSelect,
      options: ['Solar', 'EV Charging', 'Battery Storage', 'Wind', 'All'],
    ),
  ];

  static const _socioEstrategico = [
    PartnerFieldConfig(key: 'companyName', label: 'Company Name', type: FieldType.text),
    PartnerFieldConfig(
      key: 'sector',
      label: 'Sector',
      type: FieldType.dropdown,
      options: ['Energy', 'Technology', 'Finance', 'Real Estate', 'Construction', 'Other'],
    ),
    PartnerFieldConfig(key: 'allianceProposal', label: 'Alliance Proposal', type: FieldType.textarea),
    PartnerFieldConfig(
      key: 'companySize',
      label: 'Company Size',
      type: FieldType.dropdown,
      options: ['1-10', '11-50', '51-200', '200+'],
    ),
  ];

  static const _instaladorCertificado = [
    PartnerFieldConfig(
      key: 'certifications',
      label: 'Certifications',
      type: FieldType.multiSelect,
      options: ['NABCEP', 'UL Listed', 'OSHA', 'Electrical License', 'Other'],
    ),
    PartnerFieldConfig(key: 'yearsExperience', label: 'Years of Experience', type: FieldType.number),
    PartnerFieldConfig(
      key: 'coverageZones',
      label: 'Coverage Zones',
      type: FieldType.multiSelect,
      options: ['North', 'South', 'East', 'West', 'Central', 'National'],
    ),
    PartnerFieldConfig(key: 'portfolioUrl', label: 'Portfolio URL', type: FieldType.text, required: false),
  ];

  static const _empresaEnergia = [
    PartnerFieldConfig(key: 'companyName', label: 'Company Name', type: FieldType.text),
    PartnerFieldConfig(
      key: 'serviceTypes',
      label: 'Service Types',
      type: FieldType.multiSelect,
      options: ['Solar Installation', 'EV Charging', 'Battery Storage', 'Grid Services', 'Consulting'],
    ),
    PartnerFieldConfig(key: 'installedCapacity', label: 'Installed Capacity (MW)', type: FieldType.text),
    PartnerFieldConfig(key: 'licenses', label: 'Licenses', type: FieldType.fileUpload, required: false),
  ];

  static const _socioLogistica = [
    PartnerFieldConfig(key: 'fleetSize', label: 'Fleet Size', type: FieldType.number),
    PartnerFieldConfig(
      key: 'vehicleTypes',
      label: 'Vehicle Types',
      type: FieldType.multiSelect,
      options: ['Sedans', 'SUVs', 'Trucks', 'Vans', 'Buses'],
    ),
    PartnerFieldConfig(key: 'primaryRoutes', label: 'Primary Routes', type: FieldType.text),
    PartnerFieldConfig(
      key: 'electrificationInterest',
      label: 'Electrification Interest',
      type: FieldType.dropdown,
      options: ['Full Fleet', 'Partial Fleet', 'Pilot Program', 'Exploring Options'],
    ),
  ];

  static const _asesorConsultor = [
    PartnerFieldConfig(
      key: 'specialty',
      label: 'Specialty',
      type: FieldType.dropdown,
      options: ['Energy', 'Finance', 'Technology', 'Policy', 'Business Development'],
    ),
    PartnerFieldConfig(key: 'yearsExperience', label: 'Years of Experience', type: FieldType.number),
    PartnerFieldConfig(key: 'previousClients', label: 'Previous Clients', type: FieldType.textarea, required: false),
    PartnerFieldConfig(key: 'linkedIn', label: 'LinkedIn Profile', type: FieldType.text, required: false),
  ];

  static const _gobiernoMunicipio = [
    PartnerFieldConfig(key: 'entityName', label: 'Entity Name', type: FieldType.text),
    PartnerFieldConfig(key: 'position', label: 'Position / Title', type: FieldType.text),
    PartnerFieldConfig(
      key: 'projectType',
      label: 'Project Type',
      type: FieldType.dropdown,
      options: ['Public Solar', 'EV Infrastructure', 'Grid Modernization', 'Community Energy', 'Other'],
    ),
    PartnerFieldConfig(
      key: 'estimatedBudget',
      label: 'Estimated Budget',
      type: FieldType.dropdown,
      options: ['< \$100K', '\$100K - \$500K', '\$500K - \$1M', '\$1M - \$5M', '\$5M+'],
    ),
    PartnerFieldConfig(
      key: 'timeline',
      label: 'Timeline',
      type: FieldType.dropdown,
      options: ['0-6 months', '6-12 months', '1-2 years', '2+ years'],
    ),
  ];
}
```

- [ ] **Step 5: Create PartnerRepository and MockPartnerRepository**

Create `lib/features/onboarding_partner/domain/partner_repository.dart`:

```dart
import '../../../core/auth/auth_user.dart';
import 'models/partner_contact.dart';

abstract class PartnerRepository {
  Future<void> submitPartnerApplication({
    required PartnerType partnerType,
    required PartnerContact contact,
    required Map<String, dynamic> details,
  });
}
```

Create `lib/features/onboarding_partner/data/mock_partner_repository.dart`:

```dart
import '../../../core/auth/auth_user.dart';
import '../../../core/config/constants.dart';
import '../domain/models/partner_contact.dart';
import '../domain/partner_repository.dart';

class MockPartnerRepository implements PartnerRepository {
  @override
  Future<void> submitPartnerApplication({
    required PartnerType partnerType,
    required PartnerContact contact,
    required Map<String, dynamic> details,
  }) async {
    await Future.delayed(AppConstants.mockDelay);
  }
}
```

- [ ] **Step 6: Create PartnerOnboardingNotifier**

Create `lib/features/onboarding_partner/presentation/providers/partner_onboarding_notifier.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_user.dart';
import '../../../../core/config/env.dart';
import '../../data/mock_partner_repository.dart';
import '../../domain/models/partner_contact.dart';
import '../../domain/models/partner_onboarding_state.dart';
import '../../domain/partner_repository.dart';

class PartnerOnboardingNotifier extends StateNotifier<PartnerOnboardingState> {
  final PartnerRepository _repo;

  PartnerOnboardingNotifier(this._repo) : super(const PartnerOnboardingState());

  void selectPartnerType(PartnerType type) {
    state = state.copyWith(partnerType: type);
  }

  void setContact(PartnerContact contact) {
    state = state.copyWith(contact: contact);
  }

  void setDetails(Map<String, dynamic> details) {
    state = state.copyWith(details: details);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> submit() async {
    if (state.partnerType == null || state.contact == null) return;
    await _repo.submitPartnerApplication(
      partnerType: state.partnerType!,
      contact: state.contact!,
      details: state.details,
    );
    state = state.copyWith(completed: true);
  }
}

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  if (Env.useMocks) return MockPartnerRepository();
  return MockPartnerRepository();
});

final partnerOnboardingProvider =
    StateNotifierProvider<PartnerOnboardingNotifier, PartnerOnboardingState>(
        (ref) {
  final repo = ref.watch(partnerRepositoryProvider);
  return PartnerOnboardingNotifier(repo);
});
```

- [ ] **Step 7: Run code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 8: Run tests**

```bash
flutter test test/features/onboarding_partner/
```

Expected: All tests PASS.

- [ ] **Step 9: Commit**

```bash
git add lib/features/onboarding_partner/ test/features/onboarding_partner/
git commit -m "feat: add partner onboarding domain, mock repository, notifier with tests"
```

---

## Task 15: Partner Onboarding — Screens (4 steps)

**Files:**
- Create: `lib/features/onboarding_partner/presentation/screens/partner_profile_screen.dart`
- Create: `lib/features/onboarding_partner/presentation/screens/partner_contact_screen.dart`
- Create: `lib/features/onboarding_partner/presentation/screens/partner_details_screen.dart`
- Create: `lib/features/onboarding_partner/presentation/screens/partner_confirm_screen.dart`
- Create: `lib/features/onboarding_partner/presentation/widgets/adaptive_form_field.dart`
- Modify: `lib/core/router/app_router.dart`
- Create: `test/features/onboarding_partner/adaptive_form_field_test.dart`

- [ ] **Step 1: Write failing test for AdaptiveFormField**

Create `test/features/onboarding_partner/adaptive_form_field_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/features/onboarding_partner/domain/models/partner_field_config.dart';
import 'package:ancestro/features/onboarding_partner/presentation/widgets/adaptive_form_field.dart';

void main() {
  group('AdaptiveFormField', () {
    testWidgets('renders text field for FieldType.text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaptiveFormField(
              config: const PartnerFieldConfig(
                key: 'name',
                label: 'Company Name',
                type: FieldType.text,
              ),
              value: '',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Company Name'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('renders dropdown for FieldType.dropdown', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaptiveFormField(
              config: const PartnerFieldConfig(
                key: 'sector',
                label: 'Sector',
                type: FieldType.dropdown,
                options: ['Energy', 'Technology', 'Finance'],
              ),
              value: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Sector'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/onboarding_partner/adaptive_form_field_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Implement AdaptiveFormField**

Create `lib/features/onboarding_partner/presentation/widgets/adaptive_form_field.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_radii.dart';
import '../../../../core/design/app_typography.dart';
import '../../domain/models/partner_field_config.dart';

class AdaptiveFormField extends StatelessWidget {
  final PartnerFieldConfig config;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;

  const AdaptiveFormField({
    super.key,
    required this.config,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          config.label,
          style: AppTypography.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        _buildField(),
      ],
    );
  }

  Widget _buildField() {
    return switch (config.type) {
      FieldType.text => TextField(
          controller: TextEditingController(text: value as String? ?? ''),
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter ${config.label.toLowerCase()}',
          ),
        ),
      FieldType.number => TextField(
          controller: TextEditingController(text: value?.toString() ?? ''),
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter ${config.label.toLowerCase()}',
          ),
        ),
      FieldType.dropdown => DropdownButtonFormField<String>(
          value: value as String?,
          dropdownColor: AppColors.surface,
          decoration: const InputDecoration(),
          items: config.options?.map((opt) {
                return DropdownMenuItem(value: opt, child: Text(opt));
              }).toList() ??
              [],
          onChanged: (v) => onChanged(v),
        ),
      FieldType.multiSelect => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: config.options?.map((opt) {
                final selected = (value as List<String>?)?.contains(opt) ?? false;
                return FilterChip(
                  label: Text(opt),
                  selected: selected,
                  selectedColor: AppColors.primaryTinted,
                  checkmarkColor: AppColors.primary,
                  backgroundColor: AppColors.inputFill,
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.inputBorder,
                  ),
                  labelStyle: AppTypography.caption.copyWith(
                    color: selected ? AppColors.primary : AppColors.textSecondary,
                  ),
                  onSelected: (isSelected) {
                    final current = List<String>.from(value as List? ?? []);
                    if (isSelected) {
                      current.add(opt);
                    } else {
                      current.remove(opt);
                    }
                    onChanged(current);
                  },
                );
              }).toList() ??
              [],
        ),
      FieldType.textarea => TextField(
          controller: TextEditingController(text: value as String? ?? ''),
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          maxLines: 4,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter ${config.label.toLowerCase()}',
          ),
        ),
      FieldType.fileUpload => OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file, color: AppColors.primary),
          label: Text(
            'Upload ${config.label}',
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: AppColors.surfaceBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.small),
            ),
          ),
        ),
    };
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/features/onboarding_partner/adaptive_form_field_test.dart
```

Expected: All tests PASS.

- [ ] **Step 5: Create 4 partner screens**

Create the 4 partner onboarding screens following the same structural patterns used in solar onboarding. Each uses `AncestroStepper(totalSteps: 4, currentStep: N)` at the top.

Key UI:
- `partner_profile_screen.dart`: 2-column grid of 7 `AncestroCard` with icon + name + description. "Socio Inversionista" has a gold `Container` badge "Recomendado".
- `partner_contact_screen.dart`: 5 `AncestroInput` fields (name, email pre-filled, phone pre-filled, country, city, company optional).
- `partner_details_screen.dart`: Uses `PartnerFieldDefinitions.fieldsFor(state.partnerType!)` to get field configs, renders each with `AdaptiveFormField`.
- `partner_confirm_screen.dart`: Read-only summary of all entered data grouped in `AncestroCard` sections, Submit button calls `notifier.submit()`.

- [ ] **Step 6: Wire partner screens into router**

Replace the 4 partner placeholder routes in `lib/core/router/app_router.dart` with the real screen imports.

- [ ] **Step 7: Run app and test partner flow**

```bash
flutter run -d chrome
```

Expected: Sign up as partner → redirected to partner profile selection → select type → contact → adaptive details form → confirm → submit. All 7 partner types show different fields on the details step.

- [ ] **Step 8: Commit**

```bash
git add lib/features/onboarding_partner/presentation/ test/features/onboarding_partner/adaptive_form_field_test.dart lib/core/router/app_router.dart
git commit -m "feat: add partner onboarding 4 screens with adaptive form engine"
```

---

## Task 16: Referral System

**Files:**
- Create: `lib/features/referral/domain/models/referral.dart`
- Create: `lib/features/referral/domain/referral_repository.dart`
- Create: `lib/features/referral/data/mock_referral_repository.dart`
- Create: `lib/features/referral/presentation/providers/referral_notifier.dart`
- Create: `lib/features/referral/presentation/screens/referral_screen.dart`
- Create: `test/features/referral/referral_notifier_test.dart`
- Modify: `lib/core/router/app_router.dart`

- [ ] **Step 1: Write failing test**

Create `test/features/referral/referral_notifier_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ancestro/features/referral/data/mock_referral_repository.dart';
import 'package:ancestro/features/referral/domain/models/referral.dart';
import 'package:ancestro/features/referral/presentation/providers/referral_notifier.dart';

void main() {
  late MockReferralRepository repo;
  late ReferralNotifier notifier;

  setUp(() {
    repo = MockReferralRepository();
    notifier = ReferralNotifier(repo);
  });

  group('ReferralNotifier', () {
    test('loadReferrals returns mock referrals', () async {
      await notifier.loadReferrals('user-1');
      expect(notifier.state.referrals.length, 3);
    });

    test('referral code is not empty', () async {
      await notifier.loadReferrals('user-1');
      expect(notifier.state.code, isNotEmpty);
    });

    test('referrals have different statuses', () async {
      await notifier.loadReferrals('user-1');
      final statuses = notifier.state.referrals.map((r) => r.status).toSet();
      expect(statuses.length, greaterThan(1));
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/referral/referral_notifier_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Create domain models**

Create `lib/features/referral/domain/models/referral.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

enum ReferralStatus { pending, registered, completed }

@freezed
class Referral with _$Referral {
  const factory Referral({
    required String code,
    required String referrerId,
    String? referredEmail,
    required ReferralStatus status,
    double? reward,
  }) = _Referral;

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
}

class ReferralState {
  final String code;
  final List<Referral> referrals;
  final bool isLoading;

  const ReferralState({
    this.code = '',
    this.referrals = const [],
    this.isLoading = false,
  });

  ReferralState copyWith({
    String? code,
    List<Referral>? referrals,
    bool? isLoading,
  }) {
    return ReferralState(
      code: code ?? this.code,
      referrals: referrals ?? this.referrals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
```

- [ ] **Step 4: Create repository + mock**

Create `lib/features/referral/domain/referral_repository.dart`:

```dart
import 'models/referral.dart';

abstract class ReferralRepository {
  Future<String> getReferralCode({required String userId});
  Future<List<Referral>> getReferrals({required String userId});
}
```

Create `lib/features/referral/data/mock_referral_repository.dart`:

```dart
import '../../../core/config/constants.dart';
import '../domain/models/referral.dart';
import '../domain/referral_repository.dart';

class MockReferralRepository implements ReferralRepository {
  @override
  Future<String> getReferralCode({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
    return AppConstants.mockReferralCode;
  }

  @override
  Future<List<Referral>> getReferrals({required String userId}) async {
    await Future.delayed(AppConstants.mockDelay);
    return const [
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend1@example.com',
        status: ReferralStatus.completed,
        reward: 100.0,
      ),
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend2@example.com',
        status: ReferralStatus.registered,
      ),
      Referral(
        code: 'MOCK123',
        referrerId: 'user-1',
        referredEmail: 'friend3@example.com',
        status: ReferralStatus.pending,
      ),
    ];
  }
}
```

- [ ] **Step 5: Create ReferralNotifier**

Create `lib/features/referral/presentation/providers/referral_notifier.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/env.dart';
import '../../data/mock_referral_repository.dart';
import '../../domain/models/referral.dart';
import '../../domain/referral_repository.dart';

class ReferralNotifier extends StateNotifier<ReferralState> {
  final ReferralRepository _repo;

  ReferralNotifier(this._repo) : super(const ReferralState());

  Future<void> loadReferrals(String userId) async {
    state = state.copyWith(isLoading: true);
    final code = await _repo.getReferralCode(userId: userId);
    final referrals = await _repo.getReferrals(userId: userId);
    state = state.copyWith(
      code: code,
      referrals: referrals,
      isLoading: false,
    );
  }
}

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  if (Env.useMocks) return MockReferralRepository();
  return MockReferralRepository();
});

final referralProvider =
    StateNotifierProvider<ReferralNotifier, ReferralState>((ref) {
  final repo = ref.watch(referralRepositoryProvider);
  return ReferralNotifier(repo);
});
```

- [ ] **Step 6: Run code generation + tests**

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/referral/
```

Expected: All 3 tests PASS.

- [ ] **Step 7: Create ReferralScreen**

Create `lib/features/referral/presentation/screens/referral_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_radii.dart';
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
    // Load referrals with mock user ID
    ref.read(referralProvider.notifier).loadReferrals('current-user');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(referralProvider);

    if (state.isLoading) {
      return const Scaffold(body: AncestroLoading());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Earn \$100', style: AppTypography.bodyMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Refer a Friend',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your referral code and earn \$100 for each friend who completes their solar setup.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Referral code card
              AncestroCard(
                child: Column(
                  children: [
                    Text(
                      'Your Referral Code',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.code,
                      style: AppTypography.heading.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AncestroButton.ghost(
                            label: 'Copy',
                            icon: Icons.copy,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: state.code));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Code copied!')),
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
                                'Join Ancestro and go solar! Use my referral code: ${state.code}\nhttps://ancestro.ai/join?ref=${state.code}',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Referral list
              Text(
                'Your Referrals',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: state.referrals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final referral = state.referrals[index];
                    return AncestroCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.inputFill,
                            child: Icon(Icons.person, color: AppColors.textTertiary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  referral.referredEmail ?? 'Unknown',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  referral.status.name,
                                  style: AppTypography.caption.copyWith(
                                    color: _statusColor(referral.status),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (referral.reward != null)
                            Text(
                              '+\$${referral.reward!.toStringAsFixed(0)}',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(ReferralStatus status) {
    return switch (status) {
      ReferralStatus.completed => AppColors.success,
      ReferralStatus.registered => AppColors.primary,
      ReferralStatus.pending => AppColors.textTertiary,
    };
  }
}
```

- [ ] **Step 8: Wire referral screen into router**

Replace the referral placeholder in `lib/core/router/app_router.dart`:

```dart
import '../../features/referral/presentation/screens/referral_screen.dart';

GoRoute(path: RouteNames.referral, builder: (_, __) => const ReferralScreen()),
```

- [ ] **Step 9: Run app and test referral flow**

```bash
flutter run -d chrome
```

Expected: Referral screen shows code "MOCK123", copy/share buttons, and 3 referrals with different statuses.

- [ ] **Step 10: Commit**

```bash
git add lib/features/referral/ test/features/referral/ lib/core/router/app_router.dart
git commit -m "feat: add referral system — domain, mock, notifier, screen with share functionality"
```

---

## Task 17: Network Layer + API Client

**Files:**
- Create: `lib/core/network/api_client.dart`
- Create: `lib/core/network/api_endpoints.dart`

- [ ] **Step 1: Create API endpoints**

Create `lib/core/network/api_endpoints.dart`:

```dart
import '../config/env.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrl => Env.apiBaseUrl;

  // Auth
  static String get signIn => '$baseUrl/auth/signin';
  static String get signUp => '$baseUrl/auth/signup';

  // Solar
  static String get solarProposal => '$baseUrl/solar/proposal';
  static String get creditCheck => '$baseUrl/solar/credit';
  static String get agreements => '$baseUrl/solar/agreements';
  static String get inspection => '$baseUrl/solar/inspection';

  // Partner
  static String get partnerApplication => '$baseUrl/partner/apply';

  // Referral
  static String get referralCode => '$baseUrl/referral/code';
  static String get referrals => '$baseUrl/referral/list';
}
```

- [ ] **Step 2: Create API client**

Create `lib/core/network/api_client.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
});
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/network/
git commit -m "feat: add Dio API client and endpoint constants"
```

---

## Task 18: Final Integration — Run All Tests + Visual Verification

**Files:**
- No new files

- [ ] **Step 1: Run all tests**

```bash
flutter test
```

Expected: All tests PASS.

- [ ] **Step 2: Run analyzer**

```bash
flutter analyze
```

Expected: No issues.

- [ ] **Step 3: Run app in Chrome for visual verification**

```bash
flutter run -d chrome
```

Verify:
1. Splash → Login (dark theme, gold accents, DM Sans)
2. Login with any email/password → redirects to solar onboarding (customer role)
3. Navigate through all 21 solar steps (data persists via notifier)
4. Sign up as partner → redirected to partner profile selection
5. Select partner type → contact → adaptive details → confirm
6. Referral screen accessible and functional

- [ ] **Step 4: Final commit**

```bash
git add -A
git commit -m "feat: complete Ancestro MVP — auth, solar onboarding, partner onboarding, referrals"
```
