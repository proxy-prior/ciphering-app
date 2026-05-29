import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showFab;
  final VoidCallback? onFabTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showFab = false,
    this.onFabTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.navBg,
                borderRadius: BorderRadius.circular(AppRadius.nav),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NavTab(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavTab(
                    icon: Icons.phone_outlined,
                    label: 'Calls',
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  _SmsLockedTab(),
                ],
              ),
            ),
            if (showFab) ...[
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onFabTap,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, size: 20, color: AppColors.textPrimary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: isActive ? 18 : 12),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.nav),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.4),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(label, style: AppTheme.navLabel),
            ],
          ],
        ),
      ),
    );
  }
}

class _SmsLockedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Icon(
              Icons.chat_bubble_outline,
              size: 20,
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Icon(
              Icons.lock_outline,
              size: 12,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
