import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'status_badge.dart';
import 'stat_pill.dart';

class AliasCard extends StatelessWidget {
  final AliasModel alias;
  final VoidCallback? onMenuTap;

  const AliasCard({super.key, required this.alias, this.onMenuTap});

  Color get _cardTint {
    switch (alias.status) {
      case AliasStatus.active: return Colors.white;
      case AliasStatus.expired: return AppColors.expiredCardTint;
      case AliasStatus.disabled: return AppColors.disabledCardTint;
    }
  }

  Color get _borderColor {
    switch (alias.status) {
      case AliasStatus.active: return AppColors.activeColor;
      case AliasStatus.expired: return AppColors.expiredColor;
      case AliasStatus.disabled: return AppColors.disabledColor;
    }
  }

  bool get _showAllStats => alias.status == AliasStatus.active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardTint,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border(left: BorderSide(color: _borderColor, width: AppRadius.statusBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alias.label, style: AppTheme.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(alias.number, style: AppTheme.bodySmall),
                  ],
                ),
              ),
              Row(
                children: [
                  StatusBadge.fromAliasStatus(alias.status),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onMenuTap,
                    child: const Text('...', style: TextStyle(fontSize: 18, color: AppColors.textTertiary, letterSpacing: 1)),
                  ),
                ],
              ),
            ],
          ),
          if (alias.status == AliasStatus.active && alias.expiryDate != null) ...[
            const SizedBox(height: 4),
            Text(
              'Expires on ${alias.expiryDate!.day} ${_monthName(alias.expiryDate!.month)} ${alias.expiryDate!.year}',
              style: AppTheme.caption,
            ),
          ],
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              StatPill(value: '${alias.incomingCalls}', label: 'calls in'),
              StatPill(value: '${alias.incomingMins}', label: 'min in'),
              if (_showAllStats) ...[
                StatPill(value: '${alias.outgoingCalls}', label: 'calls out'),
                StatPill(value: '${alias.outgoingMins}', label: 'min out'),
                StatPill(value: '${alias.newCallers}', label: 'new callers', isSpecial: true),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
