import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IconButtonCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Widget? badge;

  const IconButtonCircle({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 40,
    this.iconSize = 18,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, size: iconSize, color: const Color(0xFF475569)),
            ),
            if (badge != null)
              Positioned(
                top: -1,
                right: -1,
                child: badge!,
              ),
          ],
        ),
      ),
    );
  }
}
