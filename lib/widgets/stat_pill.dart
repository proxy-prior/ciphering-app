import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatPill extends StatelessWidget {
  final String value;
  final String label;
  final bool isSpecial;

  const StatPill({
    super.key,
    required this.value,
    required this.label,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: isSpecial ? AppColors.statSpecialBg : AppColors.statPillBg,
        borderRadius: BorderRadius.circular(AppRadius.statPill),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: value,
              style: AppTheme.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: isSpecial ? AppColors.statSpecialText : AppColors.textPrimary,
              ),
            ),
            TextSpan(
              text: ' $label',
              style: AppTheme.caption.copyWith(
                color: isSpecial ? AppColors.statSpecialText : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
