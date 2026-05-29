import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -40,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.purplePrimary.withValues(alpha: 0.22),
                  AppColors.purplePrimary.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 0.7],
              ),
            ),
          ),
        ),
        Positioned(
          top: -40,
          right: -50,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.bluePrimary.withValues(alpha: 0.20),
                  AppColors.bluePrimary.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 0.7],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
