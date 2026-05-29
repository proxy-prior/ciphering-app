import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeShell extends StatelessWidget {
  final Widget child;

  const HomeShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home/calls')) return 1;
    if (location.startsWith('/home/messages')) return 2;
    if (location.startsWith('/home/settings')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/home/alias');
      case 1: context.go('/home/calls');
      case 2: context.go('/home/messages');
      case 3: context.go('/home/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex(context),
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
