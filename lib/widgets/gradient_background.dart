import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool useAurora;

  const GradientBackground({
    super.key,
    required this.child,
    this.useAurora = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.screenBg,
      child: Stack(
        children: [
          if (useAurora)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _AuroraPainter(),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 80, sigmaY: 80),
    );

    final peachPaint = Paint()
      ..color = const Color(0xFFFF8243).withValues(alpha: 0.7);
    canvas.drawOval(
      Rect.fromLTWH(62, 26, 126, 126),
      peachPaint,
    );

    final bluePaint = Paint()
      ..color = const Color(0xFF43A7FF).withValues(alpha: 0.7);
    canvas.drawOval(
      Rect.fromLTWH(173, -16, 166, 174),
      bluePaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
