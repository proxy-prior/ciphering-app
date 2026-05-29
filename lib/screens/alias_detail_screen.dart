import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/alias_provider.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';
import '../widgets/bottom_sheet_menu.dart';

class AliasDetailScreen extends ConsumerWidget {
  final int aliasIndex;

  const AliasDetailScreen({super.key, required this.aliasIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aliases = ref.watch(aliasProvider);

    if (aliasIndex >= aliases.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home/alias');
      });
      return const Scaffold(
        backgroundColor: AppColors.screenBg,
        body: SizedBox.shrink(),
      );
    }

    final alias = aliases[aliasIndex];

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        useAurora: false,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // Top bar
                Row(
                  children: [
                    IconButtonCircle(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Alias Details', style: AppTheme.pageTitle),
                    ),
                    IconButtonCircle(
                      icon: Icons.more_vert,
                      onTap: () => _showMenu(context, ref, alias),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Alias header
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: MockData.categoryTint(alias.category),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(alias.emoji, style: const TextStyle(fontSize: 32)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(alias.label, style: AppTheme.aliasDetailName),
                const SizedBox(height: 4),
                Text(
                  alias.number,
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 8),
                StatusBadge.fromAliasStatus(alias.status),
                const SizedBox(height: 20),

                // Stats row
                QuickStatsRibbon(
                  items: [
                    StatItem(value: '${alias.totalCalls}', label: 'Calls'),
                    StatItem(value: '${alias.totalMessages}', label: 'Messages'),
                    const StatItem(value: '45m', label: 'Talk Time'),
                  ],
                ),
                const SizedBox(height: 24),

                // Details card
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(title: 'Details'),
                ),
                GlassCard(
                  child: Column(
                    children: [
                      _DetailRow(label: 'Purpose', value: alias.purpose ?? 'N/A'),
                      _DetailRow(
                        label: 'Created',
                        value: alias.createdDate != null
                            ? DateFormat('MMM d, yyyy').format(alias.createdDate!)
                            : 'N/A',
                      ),
                      _DetailRow(
                        label: 'Expires',
                        value: alias.expiryDate != null
                            ? DateFormat('MMM d, yyyy').format(alias.expiryDate!)
                            : 'No expiry',
                        valueColor: alias.expiryDate != null &&
                                alias.expiryDate!.isAfter(DateTime.now())
                            ? AppColors.green
                            : null,
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recent activity
                Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(
                    title: 'Recent Activity',
                    actionLabel: 'See all',
                    onActionTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Full activity log coming soon')),
                      );
                    },
                  ),
                ),

                _ActivityRow(
                  type: 'Incoming call',
                  name: 'Insurance HDFC',
                  time: 'Today, 2:34 PM',
                  duration: '4m 12s',
                  iconBg: AppColors.answeredIconBg,
                  iconColor: AppColors.green,
                  icon: Icons.call_received,
                ),
                _ActivityRow(
                  type: 'SMS received',
                  name: 'HDFC Bank',
                  time: 'Today, 10:15 AM',
                  iconBg: AppColors.blockedBadgeBg,
                  iconColor: AppColors.purple,
                  icon: Icons.chat_bubble_outline,
                ),
                _ActivityRow(
                  type: 'Missed call',
                  name: 'Unknown Number',
                  time: 'Yesterday, 4:22 PM',
                  iconBg: AppColors.missedIconBg,
                  iconColor: AppColors.redText,
                  icon: Icons.call_missed,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, WidgetRef ref, AliasModel alias) {
    final isPaused = alias.status == AliasStatus.paused;
    BottomSheetMenu.show(context, [
      BottomSheetAction(
        icon: isPaused ? Icons.play_arrow : Icons.pause,
        label: isPaused ? 'Resume alias' : 'Pause alias',
        onTap: () {
          final newStatus = isPaused ? AliasStatus.active : AliasStatus.paused;
          ref.read(aliasProvider.notifier).updateStatus(aliasIndex, newStatus);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isPaused ? 'Alias resumed' : 'Alias paused'),
            ),
          );
        },
      ),
      BottomSheetAction(
        icon: Icons.schedule,
        label: 'Extend alias',
        onTap: () => _showExtendDialog(context, ref),
      ),
      BottomSheetAction(
        icon: Icons.share,
        label: 'Share number',
        onTap: () {
          Clipboard.setData(ClipboardData(text: alias.number));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Number copied to clipboard')),
          );
        },
      ),
      BottomSheetAction(
        icon: Icons.delete_outline,
        label: 'Delete alias',
        isDestructive: true,
        onTap: () => _confirmDelete(context, ref),
      ),
    ]);
  }

  void _showExtendDialog(BuildContext context, WidgetRef ref) {
    showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Extend Alias',
          style: GoogleFonts.dmSans(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final days in [7, 30, 90])
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '$days days',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () => Navigator.pop(dialogContext, days),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ).then((days) {
      if (days != null && context.mounted) {
        ref.read(aliasProvider.notifier).extendExpiry(aliasIndex, days);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alias extended by $days days')),
        );
      }
    });
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    ConfirmationDialog.show(
      context,
      title: 'Delete Alias?',
      message:
          'This alias and all its data will be permanently deleted. This cannot be undone.',
      confirmLabel: 'Delete',
      isDestructive: true,
    ).then((confirmed) {
      if (confirmed && context.mounted) {
        ref.read(aliasProvider.notifier).removeAlias(aliasIndex);
        context.go('/home/alias');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alias deleted')),
        );
      }
    });
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool showDivider;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String type;
  final String name;
  final String time;
  final String? duration;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;

  const _ActivityRow({
    required this.type,
    required this.name,
    required this.time,
    this.duration,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        borderRadius: 14,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    type,
                    style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                if (duration != null)
                  Text(
                    duration!,
                    style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textQuaternary),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
