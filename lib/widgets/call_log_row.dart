import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'glass_card.dart';
import 'status_badge.dart';

class CallLogRow extends StatelessWidget {
  final CallLogModel call;
  final VoidCallback? onTap;

  const CallLogRow({super.key, required this.call, this.onTap});

  Color get _iconBg {
    switch (call.status) {
      case CallStatus.answered: return AppColors.answeredIconBg;
      case CallStatus.missed: return AppColors.missedIconBg;
      case CallStatus.blocked: return AppColors.blockedIconBg;
      case CallStatus.outgoing: return AppColors.outgoingIconBg;
    }
  }

  Color get _iconColor {
    switch (call.status) {
      case CallStatus.answered: return AppColors.green;
      case CallStatus.missed: return AppColors.redText;
      case CallStatus.blocked: return AppColors.purple;
      case CallStatus.outgoing: return AppColors.blue;
    }
  }

  IconData get _icon {
    switch (call.status) {
      case CallStatus.answered: return Icons.call_received;
      case CallStatus.missed: return Icons.call_missed;
      case CallStatus.blocked: return Icons.block;
      case CallStatus.outgoing: return Icons.call_made;
    }
  }

  String get _timeStr {
    final h = call.timestamp.hour;
    final m = call.timestamp.minute.toString().padLeft(2, '0');
    final ampm = h >= 12 ? 'PM' : 'AM';
    final hour = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$hour:$m $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, size: 18, color: _iconColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(call.callerName, style: AppTheme.callerName),
                  const SizedBox(height: 1),
                  Text(
                    call.callerNumber,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'via ${call.aliasLabel}',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusBadge.fromCallStatus(call.status),
                const SizedBox(height: 4),
                Text(
                  _timeStr,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
