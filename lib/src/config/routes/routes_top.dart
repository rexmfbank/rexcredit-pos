import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/routes/routes_dashboard.dart';
import 'package:rex_app/src/modules/business/dashboard/ui/screens/dashboard_business_screen.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/dashboard_personal_screen.dart';
import 'package:rex_app/src/modules/revamp/home/home_screen.dart';
import 'package:rex_app/src/modules/revamp/login/ui/login_screen.dart';
import 'package:rex_app/src/modules/shared/chat/chat_screen.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/notifications/notifications.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/reset_password_screen.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/initiate_reset_password_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/otp_verify_screen.dart';
import 'package:rex_app/src/modules/revamp/splash/ui/splash_screen.dart';
import 'package:rex_app/src/modules/revamp/splash/ui/update_available_app.dart';
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
  initialLocation: Routes.splash,
  routes: topRoutes,
  debugLogDiagnostics: true,
);

List<RouteBase> topRoutes = [
  GoRoute(
    path: Routes.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: Routes.updateAvailable,
    builder: (context, state) => const UpdateAvailableApp(),
  ),
  GoRoute(
    path: Routes.welcome,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: Routes.login,
    builder: (context, state) => const LoginScreen(),
  ),

  GoRoute(
    path: Routes.otpVerify,
    builder: (context, state) => const OtpVerifyScreen(),
  ),

  GoRoute(
    path: Routes.resetPassword,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  GoRoute(
    path: Routes.initiateResetPassword,
    builder: (context, state) => const InitiateResetPasswordScreen(),
  ),
  GoRoute(
    path: Routes.verifyDevice,
    builder: (context, state) => const VerifyDeviceScreen(),
  ),
  GoRoute(
    path: Routes.chatScreen,
    builder: (context, state) => const ChatScreen(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavKey,
    path: Routes.notificationPage,
    builder: (context, state) => const NotificationsPage(),
  ),
  // NEW ROUTES
  GoRoute(
    path: Routes.homeScreen,
    builder: (context, state) => const HomeScreen(),
  ),
  //
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
    dashboardMoreBusinessRoutes,
  ],
);
