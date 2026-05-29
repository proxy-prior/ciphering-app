import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'status_badge.dart';

class CallLogRow extends StatelessWidget {
  final CallLogModel call;
  final VoidCallback? onCallBack;

  const CallLogRow({super.key, required this.call, this.onCallBack});

  Color get _iconBg {
    switch (call.status) {
      case CallStatus.answered: return AppColors.activeBadgeBg;
      case CallStatus.missed: return AppColors.expiredBadgeBg;
      case CallStatus.blocked: return AppColors.blockedBadgeBg;
      case CallStatus.expired: return AppColors.disabledBadgeBg;
    }
  }

  Color get _iconColor {
    switch (call.status) {
      case CallStatus.answered: return AppColors.activeColor;
      case CallStatus.missed: return AppColors.missedColor;
      case CallStatus.blocked: return AppColors.blockedColor;
      case CallStatus.expired: return AppColors.disabledColor;
    }
  }

  IconData get _icon {
    switch (call.status) {
      case CallStatus.answered: return Icons.call_received;
      case CallStatus.missed: return Icons.call_missed;
      case CallStatus.blocked: return Icons.block;
      case CallStatus.expired: return Icons.access_time;
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
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: _iconBg, borderRadius: BorderRadius.circular(AppRadius.rowIcon)),
            child: Icon(_icon, size: 18, color: _iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(call.callerName, style: AppTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(call.callerNumber, style: AppTheme.bodySmall.copyWith(fontSize: 12)),
                Text('To: ${call.aliasNumber}', style: AppTheme.caption),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_timeStr, style: AppTheme.bodySmall.copyWith(fontSize: 12)),
              const SizedBox(height: 3),
              StatusBadge.fromCallStatus(call.status),
              if (call.status == CallStatus.missed) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onCallBack,
                  child: const Icon(Icons.call, size: 16, color: AppColors.purplePrimary),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
