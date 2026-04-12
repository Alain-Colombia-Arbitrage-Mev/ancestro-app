# Ancestro MVP — Design Spec

## Overview

Ancestro is a clean energy platform mobile app built with Flutter. The MVP covers authentication (AWS Cognito), solar onboarding for customers, partner onboarding (7 profile types), and a referral system. The app replicates the premium dark UI designed in the `.pen` file.

**Stack:** Flutter 3.x, Riverpod, GoRouter, Clean Architecture, AWS Cognito, Mock services

**Target:** All mobile devices, responsive (iPhone SE to tablets), minimal scroll.

---

## 1. Architecture

### Project Structure

```
lib/
├── core/
│   ├── auth/
│   │   ├── auth_provider.dart              # Riverpod providers for auth state
│   │   ├── auth_repository.dart            # Abstract AuthRepository
│   │   ├── cognito_auth_repository.dart    # Cognito implementation
│   │   └── mock_auth_repository.dart       # Mock implementation
│   ├── config/
│   │   ├── env.dart                        # Environment config (Cognito pool IDs, etc.)
│   │   └── constants.dart                  # App-wide constants
│   ├── design/
│   │   ├── app_theme.dart                  # ThemeData (dark theme)
│   │   ├── app_colors.dart                 # Color palette
│   │   ├── app_typography.dart             # DM Sans text styles
│   │   └── app_radii.dart                  # Corner radius tokens
│   ├── network/
│   │   ├── api_client.dart                 # HTTP client (dio)
│   │   ├── api_interceptors.dart           # Auth token injection
│   │   └── api_endpoints.dart              # Endpoint constants
│   ├── router/
│   │   ├── app_router.dart                 # GoRouter config
│   │   ├── auth_guard.dart                 # Redirect logic based on auth/onboarding state
│   │   └── route_names.dart                # Named route constants
│   └── widgets/
│       ├── ancestro_button.dart            # Primary (gold) + ghost button
│       ├── ancestro_input.dart             # Text input with label
│       ├── ancestro_nav_bar.dart           # Bottom nav with glassmorphism
│       ├── ancestro_app_bar.dart           # Top bar with hamburger + notification
│       ├── ancestro_card.dart              # Dark card with subtle border
│       ├── ancestro_stepper.dart           # Progress dots for onboarding
│       ├── ancestro_modal.dart             # Success/confirmation overlay
│       ├── ancestro_loading.dart           # Loading spinner
│       └── social_login_buttons.dart       # Google, Apple, Phone buttons
│
├── features/
│   ├── auth/
│   │   ├── domain/
│   │   │   ├── auth_user.dart              # AuthUser model
│   │   │   └── auth_exceptions.dart        # Typed exceptions
│   │   ├── data/
│   │   │   └── auth_repository_impl.dart   # Delegates to core/auth
│   │   └── presentation/
│   │       ├── splash_screen.dart
│   │       ├── login_screen.dart
│   │       ├── signup_screen.dart
│   │       ├── forgot_password_screen.dart
│   │       ├── otp_screen.dart
│   │       ├── reset_password_screen.dart
│   │       ├── success_screen.dart
│   │       └── providers/
│   │           ├── auth_notifier.dart
│   │           └── auth_providers.dart
│   │
│   ├── onboarding_solar/
│   │   ├── domain/
│   │   │   ├── solar_onboarding_state.dart
│   │   │   ├── models/
│   │   │   │   ├── basic_info.dart
│   │   │   │   ├── property_info.dart
│   │   │   │   ├── solar_proposal.dart
│   │   │   │   ├── credit_status.dart
│   │   │   │   ├── document.dart
│   │   │   │   ├── agreement.dart
│   │   │   │   └── inspection_schedule.dart
│   │   │   └── solar_repository.dart       # Abstract
│   │   ├── data/
│   │   │   ├── solar_repository_impl.dart
│   │   │   └── mock_solar_repository.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── choose_flow_screen.dart
│   │       │   ├── intro_screen.dart
│   │       │   ├── proposal_screen.dart
│   │       │   ├── basic_info_screen.dart
│   │       │   ├── property_info_screen.dart
│   │       │   ├── almost_done_screen.dart
│   │       │   ├── instant_proposal_screen.dart
│   │       │   ├── confirm_service_screen.dart
│   │       │   ├── credit_check_screen.dart
│   │       │   ├── coverage_plan_screen.dart
│   │       │   ├── reserve_system_screen.dart
│   │       │   ├── reserving_spot_screen.dart
│   │       │   ├── finances_doc_screen.dart
│   │       │   ├── verify_identity_screen.dart
│   │       │   ├── agreements_screen.dart
│   │       │   ├── inner_agreement_screen.dart
│   │       │   ├── last_step_screen.dart
│   │       │   ├── property_review_screen.dart
│   │       │   ├── schedule_inspection_screen.dart
│   │       │   ├── confirm_inspection_screen.dart
│   │       │   └── meet_inspector_screen.dart
│   │       └── providers/
│   │           ├── solar_onboarding_notifier.dart
│   │           └── solar_providers.dart
│   │
│   ├── onboarding_partner/
│   │   ├── domain/
│   │   │   ├── partner_type.dart            # Enum: 7 partner types
│   │   │   ├── partner_onboarding_state.dart
│   │   │   ├── partner_contact.dart
│   │   │   ├── partner_field_config.dart    # Adaptive field definitions per type
│   │   │   └── partner_repository.dart      # Abstract
│   │   ├── data/
│   │   │   ├── partner_repository_impl.dart
│   │   │   ├── mock_partner_repository.dart
│   │   │   └── partner_field_definitions.dart # Static field configs per partner type
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── partner_profile_screen.dart    # Step 1: select type
│   │       │   ├── partner_contact_screen.dart    # Step 2: contact info
│   │       │   ├── partner_details_screen.dart    # Step 3: adaptive form
│   │       │   └── partner_confirm_screen.dart    # Step 4: review + submit
│   │       └── providers/
│   │           ├── partner_onboarding_notifier.dart
│   │           └── partner_providers.dart
│   │
│   └── referral/
│       ├── domain/
│       │   ├── referral.dart
│       │   └── referral_repository.dart
│       ├── data/
│       │   ├── referral_repository_impl.dart
│       │   └── mock_referral_repository.dart
│       └── presentation/
│           ├── referral_screen.dart
│           └── providers/
│               └── referral_providers.dart
│
└── main.dart
```

### Dependency Injection

Riverpod providers at `core/auth/auth_provider.dart` expose the auth repository. A top-level `useMocks` flag in `env.dart` toggles between real and mock implementations for all repositories.

```dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (Env.useMocks) return MockAuthRepository();
  return CognitoAuthRepository();
});
```

Same pattern for `SolarRepository`, `PartnerRepository`, `ReferralRepository`.

---

## 2. Authentication

### Screens (7)

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/` | Full-screen background image (casa solar), gradient overlay, "Welcome to Ancestro" text, auto-navigate after 2s |
| Login | `/login` | Logo + tagline "Welcome to the Barefoot Tribe", email/password fields, Log In button (gold), "Forgot Password?" link, OR divider, social login (Google, Apple, Phone), "Don't have an account? Sign up" |
| Signup | `/signup` | Logo, role selector (Customer/Partner), email/password, referral code field (optional, pre-filled from deep link), Sign Up button, social login, "Already have an account? Log in" |
| Forgot Password | `/forgot-password` | Email input, "Make sure you enter the email linked to your account.", Send Code button, keyboard visible |
| OTP Code | `/verify-code` | 6-digit code input (individual boxes), timer "Didn't get the code yet? Resend (0:35)", Verify button |
| Reset Password | `/reset-password` | New password + confirm password fields, keyboard visible, Reset button |
| Success | `/success` | Semi-transparent overlay (#00000073), centered card with checkmark icon, success message, Continue button |

### AuthRepository Interface

```dart
abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  Future<AuthUser> signIn({required String email, required String password});
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
  Future<void> confirmSignUp({required String email, required String code});
  Future<void> forgotPassword({required String email});
  Future<void> confirmForgotPassword({
    required String email,
    required String code,
    required String newPassword,
  });
  Future<void> signOut();
}
```

### AuthUser Model

```dart
class AuthUser {
  final String id;
  final String email;
  final String? phone;
  final UserRole role;           // customer, partner
  final PartnerType? partnerType; // null for customers
  final String? referredBy;       // referral code of referrer
  final bool onboardingComplete;
}
```

### Router Guards

```dart
redirect: (context, state) {
  final user = ref.read(authProvider);
  final isAuthRoute = state.matchedLocation.startsWith('/login') || 
                       state.matchedLocation.startsWith('/signup') ||
                       state.matchedLocation == '/';
  
  if (user == null && !isAuthRoute) return '/login';
  if (user == null) return null;
  
  if (isAuthRoute) {
    if (!user.onboardingComplete) {
      return user.role == UserRole.customer 
        ? '/onboarding/solar' 
        : '/onboarding/partner/profile';
    }
    return '/home';
  }
  
  if (!user.onboardingComplete) {
    final isOnboardingRoute = state.matchedLocation.startsWith('/onboarding');
    if (!isOnboardingRoute) {
      return user.role == UserRole.customer 
        ? '/onboarding/solar' 
        : '/onboarding/partner/profile';
    }
  }
  
  return null;
}
```

---

## 3. Onboarding Solar (Customer)

### Screens (21)

Linear stepper flow. User cannot skip steps. Progress persisted locally (SharedPreferences) so they can resume if they close the app.

| # | Screen | Route | Key UI |
|---|--------|-------|--------|
| 1 | Choose Flow | `/onboarding/solar` | SystemSelectionView: cards for Solar / EV / Both |
| 2 | Intro | `/onboarding/solar/intro` | Logo animation, welcome text |
| 3 | Proposal | `/onboarding/solar/proposal` | SolarLogoIcon, aerial drone photo background |
| 4 | Basic Info | `/onboarding/solar/basic-info` | Name, phone, address fields |
| 5 | Property Info | `/onboarding/solar/property` | Property type, roof size, monthly consumption |
| 6 | Almost Done | `/onboarding/solar/almost-done` | Summary before proposal generation |
| 7 | Instant Proposal | `/onboarding/solar/instant-proposal` | Property image + proposal data + "Continue to Checkout" |
| 8 | Confirm Service | `/onboarding/solar/confirm` | Service details + "Confirm & Activate Services" |
| 9 | Credit Check | `/onboarding/solar/credit` | Approved: ProductionChartCard + continue. Denied: alternative options |
| 10 | Coverage Plan | `/onboarding/solar/coverage` | 20 year coverage details + "Proceed to Checkout" |
| 11 | Reserve System | `/onboarding/solar/reserve` | CheckoutView: payment method + reserve |
| 12 | Reserving Spot | `/onboarding/solar/reserving` | Loading animation + "we need to review documents" message |
| 13 | Finances Doc | `/onboarding/solar/finances` | Document upload (camera/gallery) + "securely and efficiently" |
| 14 | Verify Identity | `/onboarding/solar/verify-identity` | DocumentVerificationView: ID upload front/back |
| 15 | Agreements | `/onboarding/solar/agreements` | List of legal agreements with checkboxes |
| 16 | Inner Agreement | `/onboarding/solar/agreements/:id` | Full agreement text + "Continue" button |
| 17 | Last Step | `/onboarding/solar/last-step` | Photo upload instructions + camera/gallery picker |
| 18 | Property Review | `/onboarding/solar/property-review` | "Here's what we found from your submitted photos" + results |
| 19 | Schedule Inspection | `/onboarding/solar/schedule` | Calendar picker + time slots |
| 20 | Confirm Inspection | `/onboarding/solar/confirm-inspection` | Appointment summary |
| 21 | Meet Inspector | `/onboarding/solar/inspector` | Inspector profile: photo, name, rating, contact |

### Domain Model

```dart
class SolarOnboardingState {
  final int currentStep;             // 1-21
  final SystemType systemType;       // solar, ev, both
  final BasicInfo? basicInfo;
  final PropertyInfo? propertyInfo;
  final SolarProposal? proposal;     // generated by backend/mock
  final CreditStatus creditStatus;   // pending, approved, denied
  final List<UploadedDocument> documents;
  final List<Agreement> agreements;
  final List<PropertyPhoto> propertyPhotos;
  final InspectionSchedule? inspection;
  final bool completed;
}

enum SystemType { solar, ev, both }
enum CreditStatus { pending, approved, denied }
```

### Persistence

```dart
// SolarOnboardingNotifier saves state to SharedPreferences on every step change
Future<void> _persistState() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('solar_onboarding', jsonEncode(state.toJson()));
}
```

---

## 4. Onboarding Partner (7 Profiles)

### Screens (4)

Stepper with 4 progress dots. Same pattern as solar but shorter.

| Step | Screen | Route | Description |
|------|--------|-------|-------------|
| 1 | Profile Selection | `/onboarding/partner/profile` | 2-column grid of 7 cards. Each: icon + name + 1-line description. "Socio Inversionista" has gold "Recomendado" badge |
| 2 | Contact Info | `/onboarding/partner/contact` | Common fields: name, email (pre-filled), phone (pre-filled), country/city, company (optional for some) |
| 3 | Details | `/onboarding/partner/details` | Adaptive form — fields change based on selected profile type |
| 4 | Confirmation | `/onboarding/partner/confirm` | Review all entered data in read-only cards, edit buttons per section, Submit button |

### Partner Types & Adaptive Fields (Step 3)

```dart
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

| Type | Fields |
|------|--------|
| Socio Inversionista | Investment amount range (dropdown), investment horizon (dropdown), previous experience (text), areas of interest (multi-select) |
| Socio Estrategico | Company name, sector (dropdown), alliance proposal (textarea), company size (dropdown) |
| Instalador Certificado | Certifications (multi-select), years experience (number), coverage zones (multi-select), portfolio URL (text) |
| Empresa de Energia | Company name, service types (multi-select), installed capacity (text), licenses (file upload) |
| Socio de Logistica | Fleet size (number), vehicle types (multi-select), primary routes (text), electrification interest (dropdown) |
| Asesor/Consultor | Specialty (dropdown), years experience (number), previous clients (textarea), LinkedIn (text) |
| Gobierno/Municipio | Entity name, position/title (text), project type (dropdown), estimated budget (dropdown), timeline (dropdown) |

### Adaptive Form Engine

```dart
class PartnerFieldConfig {
  final String key;
  final String label;
  final FieldType type;        // text, number, dropdown, multiSelect, textarea, fileUpload
  final List<String>? options; // for dropdown/multiSelect
  final bool required;
}

// partner_field_definitions.dart has a Map<PartnerType, List<PartnerFieldConfig>>
// The details screen reads this config and renders fields dynamically
```

---

## 5. Referral System

### Screen (1)

| Screen | Route | Description |
|--------|-------|-------------|
| Earn $100 | `/referral` | Accessible from profile/home post-onboarding. Shows unique referral code, share button (native share sheet), list of referred users with status |

### Domain Model

```dart
class Referral {
  final String code;
  final String referrerId;
  final String? referredEmail;
  final ReferralStatus status;   // pending, registered, completed
  final double? reward;
}

enum ReferralStatus { pending, registered, completed }
```

### Deep Link Flow

- Referrer shares link: `https://ancestro.ai/join?ref=ABC123`
- App intercepts deep link via GoRouter
- Signup screen pre-fills referral code
- Referral is tracked as `pending` → `registered` (on signup) → `completed` (on onboarding complete)

---

## 6. Design System

### Colors

```dart
class AppColors {
  static const background = Color(0xFF0D0D0D);
  static const surface = Color(0xFF141414);
  static const surfaceVariant = Color(0xFF1F1F1F);
  static const surfaceBorder = Color(0x1AFFFFFF);      // 10% white
  static const inputFill = Color(0x14FFFFFF);           // 8% white
  static const inputBorder = Color(0x0DFFFFFF);         // 5% white
  static const primary = Color(0xFFF8B03B);             // amber/gold
  static const primaryTinted = Color(0x1AF0B535);       // amber at 10%
  static const primaryBorder = Color(0x4DF0B535);       // amber at 30%
  static const onPrimary = Color(0xFF0D0D0D);           // dark text on gold
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB5B5B5);
  static const textTertiary = Color(0xFF9A9A9A);
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const overlay = Color(0x73000000);
  static const navFill = Color(0x33141414);
}
```

### Typography

```dart
class AppTypography {
  static const fontFamily = 'DM Sans';
  
  static const heading = TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
  static const subheading = TextStyle(fontSize: 21, fontWeight: FontWeight.w600);
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const button = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  static const label = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
}
```

### Corner Radii

```dart
class AppRadii {
  static const small = 14.0;   // buttons, inputs
  static const medium = 16.0;  // cards
  static const large = 24.0;   // containers
  static const pill = 500.0;   // nav bar
}
```

### Shared Widgets

| Widget | Description |
|--------|-------------|
| `AncestroButton` | Primary (gold fill, dark text) and ghost (transparent, white border) variants. Height 52px, radius 14. |
| `AncestroInput` | Label above, input with fill `#ffffff14`, border `#ffffff0d`, radius 14, password toggle eye icon. |
| `AncestroNavBar` | Bottom nav, pill shape, glassmorphism (BackdropFilter blur 74), semi-transparent fill, 5 tabs (Stats, Station/EV, Store, Support, Profile). Only shown post-onboarding. |
| `AncestroAppBar` | Greeting "Good Morning, John", hamburger menu left, notification bell right with badge. |
| `AncestroCard` | Dark surface `#141414`, border `#ffffff1a`, radius 16, padding 16. |
| `AncestroStepper` | Row of dots, active dot = gold filled, inactive = `#ffffff1a`. Used in partner onboarding (4 dots). |
| `AncestroModal` | Overlay `#00000073`, centered card with icon + message + button. |
| `AncestroLoading` | Centered circular progress in amber. |
| `SocialLoginButtons` | Google, Apple, Phone buttons as ghost style with provider icon. |

---

## 7. Responsive Strategy

### Approach

- **Base design:** 430px width (from .pen)
- **Method:** `MediaQuery` + `LayoutBuilder` for adaptive sizing
- **No scroll policy:** Each screen fills viewport height. Content area uses `Expanded` inside a `Column`. Only forms with >4 fields get `SingleChildScrollView`.
- **Font scaling:** Clamp with `MediaQuery.textScaleFactor` to prevent overflow
- **Safe areas:** All screens wrapped in `SafeArea`

### Breakpoints

| Name | Width | Adjustments |
|------|-------|-------------|
| Small | <375px | Reduce padding to 16px, font scale 0.9, 1-column partner cards |
| Medium | 375-428px | Standard layout (matches .pen) |
| Large | >428px | Increase padding to 32px, wider inputs, 2-column partner cards |

### Testing

- Playwright MCP in Chrome DevTools with device presets
- Target devices: iPhone SE (375x667), iPhone 14 (390x844), iPhone 14 Pro Max (430x932), Pixel 7 (412x915), iPad Mini (768x1024)
- Validate: no horizontal overflow, no unnecessary scroll, touch targets >= 44px, text readable at all sizes

---

## 8. Packages

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `go_router` | Routing + guards |
| `amazon_cognito_identity_dart_2` | Cognito auth |
| `google_sign_in` | Google social login |
| `sign_in_with_apple` | Apple social login |
| `dio` | HTTP client |
| `shared_preferences` | Local persistence for onboarding state |
| `image_picker` | Camera/gallery for document + photo upload |
| `share_plus` | Native share sheet for referrals |
| `flutter_svg` | SVG icon rendering |
| `cached_network_image` | Image caching |
| `freezed` + `json_serializable` | Immutable models + JSON serialization |
| `google_fonts` | DM Sans font |
| `intl` | i18n (Spanish + English) |

---

## 9. Mock Strategy

All repositories have a mock implementation that returns realistic data with simulated delays (300-800ms). Mocks are toggled via `Env.useMocks = true` in `env.dart`.

### Mock Behaviors

| Repository | Mock Behavior |
|------------|---------------|
| AuthRepository | Any email/password works. Social login returns test user. OTP always "123456". |
| SolarRepository | Returns pre-built proposal for any property. Credit always approved. Inspection available next week. |
| PartnerRepository | Accepts any form data. Returns confirmation immediately. |
| ReferralRepository | Returns 3 sample referrals at different statuses. Code is "MOCK123". |

---

## 10. Localization

- Default language: Spanish (es)
- Secondary: English (en)
- Method: `flutter_localizations` + ARB files
- All user-facing strings externalized from day one
- Language toggle in profile settings (post-MVP, but string architecture ready)
