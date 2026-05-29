import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeShell extends StatelessWidget {
  final Widget child;

  const HomeShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home/calls')) return 1;
    return 0;
  }

  bool _showFab(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location.startsWith('/home/alias');
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/home/alias');
      case 1: context.go('/home/calls');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          BottomNavBar(
            currentIndex: _currentIndex(context),
            onTap: (i) => _onTap(context, i),
            showFab: _showFab(context),
            onFabTap: () => context.push('/create-alias/verify'),
          ),
        ],
      ),
    );
  }
}
