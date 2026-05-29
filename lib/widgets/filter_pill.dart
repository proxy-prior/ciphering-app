import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const FilterPill({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.filterActiveBg : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? null : Border.all(color: AppColors.inputBorder),
        ),
        child: Text(
          label,
          style: AppTheme.caption.copyWith(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
