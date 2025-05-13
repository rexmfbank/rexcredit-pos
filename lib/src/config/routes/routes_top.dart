import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/routes/routes_dashboard.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/screens/dashboard_business_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/dashboard_personal_screen.dart';
import 'package:rex_app/src/modules/shared/chat/chat_screen.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/notifications/notifications.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/reset_password_screen.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/initiate_reset_password_screen.dart';
import 'package:rex_app/src/modules/shared/login/ui/login_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_cooperative/ui/cooperative_doc_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/llc_director_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_doc_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_bio_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_partnership/ui/partnership_doc_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/ui/proprietor_doc_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/ui/account_type_selection_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/screens/complete_setup_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/register_screen2.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/register_terms_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/ui/confirm_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/ui/set_transaction_pin_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/otp_verify_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/register_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/ui/select_country_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/splash/ui/splash_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/splash/ui/update_available_app.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/ui/welcome_screen.dart';
import 'package:rex_app/src/modules/shared/verify_device/ui/verify_device_screen.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _personalShellNavKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _businessShellNavkey =
    GlobalKey<NavigatorState>();

/// use parentNavKey when a child route is a Shell Route
// final GlobalKey<NavigatorState> _parentNavKey = GlobalKey<NavigatorState>();

final GoRouter rexGoRouter = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: RouteName.splash,
  routes: topRoutes,
  debugLogDiagnostics: true,
);

List<RouteBase> topRoutes = [
  GoRoute(
    path: RouteName.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: RouteName.updateAvailable,
    builder: (context, state) => const UpdateAvailableApp(),
  ),
  GoRoute(
    path: RouteName.welcome,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: RouteName.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: RouteName.selectCountry,
    builder: (context, state) => const SelectCountryScreen(),
  ),
  GoRoute(
    path: RouteName.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: RouteName.register2,
    builder: (context, state) => const RegisterScreen2(),
  ),
  GoRoute(
    path: RouteName.registerTerms,
    builder: (context, state) => const RegisterTermsScreen(),
  ),
  GoRoute(
    path: RouteName.otpVerify,
    builder: (context, state) => const OtpVerifyScreen(),
  ),
  GoRoute(
    path: RouteName.accountType,
    builder: (context, state) => const AccountTypeSelectionScreen(),
  ),
  GoRoute(
    path: RouteName.completeSetup,
    builder: (context, state) => const CompleteSetupScreen(),
  ),
  GoRoute(
    path: RouteName.setTransactionPin,
    builder: (context, state) => const SetTransactionPinScreen(),
  ),
  GoRoute(
    path: RouteName.confirmTransactionPin,
    builder: (context, state) => const ConfirmTransactionPinScreen(),
  ),
  GoRoute(
    path: RouteName.resetPassword,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  GoRoute(
    path: RouteName.initiateResetPassword,
    builder: (context, state) => const InitiateResetPasswordScreen(),
  ),
  GoRoute(
    path: RouteName.businessBio,
    builder: (context, state) => const BusinessBioScreen(),
  ),
  GoRoute(
    path: RouteName.bizllcDocs,
    builder: (context, state) => const LLC_DocScreen(),
  ),
  GoRoute(
    path: RouteName.bizllcDirector,
    builder: (context, state) => const LLC_DirectorScreen(),
  ),
  GoRoute(
    path: RouteName.bizPartnershipDocs,
    builder: (context, state) => const PartnershipDocScreen(),
  ),
  GoRoute(
    path: RouteName.bizCooperativeDocs,
    builder: (context, state) => const CooperativeDocScreen(),
  ),
  GoRoute(
    path: RouteName.bizProprietorDocs,
    builder: (context, state) => const ProprietorDocScreen(),
  ),
  GoRoute(
    path: RouteName.verifyDevice,
    builder: (context, state) => const VerifyDeviceScreen(),
  ),
  GoRoute(
    path: RouteName.chatScreen,
    builder: (context, state) => const ChatScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: RouteName.notificationPage,
    builder: (context, state) => const NotificationsPage(),
  ),
  dashboardShellRoute,
  dashboardBusinessShellRoute,
];

final dashboardShellRoute = ShellRoute(
  navigatorKey: _personalShellNavKey,
  builder: (context, state, child) => DashboardPersonalScreen(child: child),
  routes: <RouteBase>[
    dashboardHomeRoutes,
    dashboardSpendRoutes,
    dashboardSaveRoutes,
    dashboardBorrowRoutes,
    dashboardMoreRoutes,
  ],
);

final dashboardBusinessShellRoute = ShellRoute(
  navigatorKey: _businessShellNavkey,
  builder: (context, state, child) => DashboardBusinessScreen(child: child),
  routes: <RouteBase>[
    dashboardHomeBusinessRoutes,
    dashboardSpendBusinessRoutes,
    dashboardSaveBusinessRoutes,
    dashboardBorrowBusinessRoutes,
    dashboardMoreBusinessRoutes,
  ],
);
