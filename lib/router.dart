import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/alias_manager_screen.dart';
import 'screens/call_logs_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/message_thread_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/digilocker_screen.dart';
import 'screens/alias_purpose_screen.dart';
import 'screens/plan_selection_screen.dart';
import 'screens/alias_confirmation_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/home_shell.dart';

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
        GoRoute(path: '/home/messages', builder: (_, __) => const MessagesScreen()),
        GoRoute(
          path: '/home/messages/:threadId',
          builder: (_, state) => MessageThreadScreen(threadId: state.pathParameters['threadId']!),
        ),
        GoRoute(path: '/home/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
    GoRoute(path: '/create-alias/verify', builder: (_, __) => const DigilockerScreen()),
    GoRoute(path: '/create-alias/purpose', builder: (_, __) => const AliasPurposeScreen()),
    GoRoute(path: '/create-alias/plan', builder: (_, __) => const PlanSelectionScreen()),
    GoRoute(path: '/create-alias/confirmation', builder: (_, __) => const AliasConfirmationScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const UserProfileScreen()),
  ],
);
