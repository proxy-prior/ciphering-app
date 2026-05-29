import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  factory StatusBadge.fromAliasStatus(AliasStatus status) {
    switch (status) {
      case AliasStatus.active:
        return const StatusBadge(label: 'Active', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.activeBadgeText);
      case AliasStatus.expired:
        return const StatusBadge(label: 'Expired', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.expiredBadgeText);
      case AliasStatus.disabled:
        return const StatusBadge(label: 'Disabled', backgroundColor: AppColors.disabledBadgeBg, textColor: AppColors.disabledBadgeText);
    }
  }

  factory StatusBadge.fromCallStatus(CallStatus status) {
    switch (status) {
      case CallStatus.answered:
        return const StatusBadge(label: 'Answered', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.activeBadgeText);
      case CallStatus.missed:
        return const StatusBadge(label: 'Missed', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.expiredBadgeText);
      case CallStatus.blocked:
        return const StatusBadge(label: 'Blocked', backgroundColor: AppColors.blockedBadgeBg, textColor: AppColors.blockedBadgeText);
      case CallStatus.expired:
        return const StatusBadge(label: 'Expired', backgroundColor: AppColors.disabledBadgeBg, textColor: AppColors.disabledBadgeText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Text(
        label,
        style: AppTheme.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
