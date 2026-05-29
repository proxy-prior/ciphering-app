import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/alias_manager_screen.dart';
import 'screens/call_logs_screen.dart';
import 'screens/call_detail_screen.dart';
import 'screens/alias_detail_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/digilocker_screen.dart';
import 'screens/alias_purpose_screen.dart';
import 'screens/plan_selection_screen.dart';
import 'screens/alias_confirmation_screen.dart';
import 'screens/home_shell.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_conditions_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/otp', builder: (_, __) => const OtpScreen()),
    GoRoute(path: '/basic-details', builder: (_, __) => const BasicDetailsScreen()),
    ShellRoute(
      builder: (_, __, child) => HomeShell(child: child),
      routes: [
        GoRoute(path: '/home/alias', builder: (_, __) => const AliasManagerScreen()),
        GoRoute(path: '/home/calls', builder: (_, __) => const CallLogsScreen()),
      ],
    ),
    GoRoute(
      path: '/call-detail/:callIndex',
      builder: (_, state) => CallDetailScreen(
        callIndex: int.parse(state.pathParameters['callIndex']!),
      ),
    ),
    GoRoute(
      path: '/alias-detail/:aliasIndex',
      builder: (_, state) => AliasDetailScreen(
        aliasIndex: int.parse(state.pathParameters['aliasIndex']!),
      ),
    ),
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const UserProfileScreen()),
    GoRoute(path: '/onboarding/verify', builder: (_, __) => const DigilockerScreen(isOnboarding: true)),
    GoRoute(path: '/create-alias/verify', builder: (_, __) => const DigilockerScreen()),
    GoRoute(path: '/create-alias/purpose', builder: (_, __) => const AliasPurposeScreen()),
    GoRoute(path: '/create-alias/plan', builder: (_, __) => const PlanSelectionScreen()),
    GoRoute(path: '/create-alias/confirmation', builder: (_, __) => const AliasConfirmationScreen()),
    GoRoute(path: '/privacy-policy', builder: (_, __) => const PrivacyPolicyScreen()),
    GoRoute(path: '/terms', builder: (_, __) => const TermsConditionsScreen()),
  ],
);
