import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        return const StatusBadge(label: 'ACTIVE', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.green);
      case AliasStatus.paused:
        return const StatusBadge(label: 'PAUSED', backgroundColor: AppColors.pausedBadgeBg, textColor: AppColors.yellow);
      case AliasStatus.expired:
        return const StatusBadge(label: 'EXPIRED', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.redText);
      case AliasStatus.blocked:
        return const StatusBadge(label: 'BLOCKED', backgroundColor: AppColors.blockedBadgeBg, textColor: AppColors.purple);
    }
  }

  factory StatusBadge.fromCallStatus(CallStatus status) {
    switch (status) {
      case CallStatus.answered:
        return const StatusBadge(label: 'ANSWERED', backgroundColor: AppColors.activeBadgeBg, textColor: AppColors.green);
      case CallStatus.missed:
        return const StatusBadge(label: 'MISSED', backgroundColor: AppColors.expiredBadgeBg, textColor: AppColors.redText);
      case CallStatus.blocked:
        return const StatusBadge(label: 'BLOCKED', backgroundColor: AppColors.blockedBadgeBg, textColor: AppColors.purple);
      case CallStatus.outgoing:
        return const StatusBadge(label: 'OUTGOING', backgroundColor: AppColors.outgoingIconBg, textColor: AppColors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
