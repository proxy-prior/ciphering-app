import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/call_log_provider.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/bottom_sheet_menu.dart';

class CallDetailScreen extends ConsumerWidget {
  final int callIndex;

  const CallDetailScreen({super.key, required this.callIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(callLogProvider);

    if (callIndex < 0 || callIndex >= logs.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return const SizedBox.shrink();
    }

    final call = logs[callIndex];
    final alias = MockData.aliases.firstWhere(
      (a) => a.number == call.aliasNumber,
      orElse: () => MockData.aliases.first,
    );

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
                      child: Text('Contact Details', style: AppTheme.pageTitle),
                    ),
                    IconButtonCircle(
                      icon: Icons.more_vert,
                      onTap: () => _showMenu(context, ref, call),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Contact header
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: MockData.categoryTint(alias.category),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(alias.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(call.callerName, style: AppTheme.contactName),
                const SizedBox(height: 4),
                Text(
                  call.callerNumber,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Calls via ${call.aliasLabel}',
                  style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 24),

                // Call back button
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Calling ${call.callerName}...')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.phone, size: 20, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Call Back',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Stats row
                QuickStatsRibbon(
                  items: const [
                    StatItem(value: '8', label: 'Total Calls'),
                    StatItem(value: '6', label: 'Answered'),
                    StatItem(value: '24m', label: 'Total Time'),
                  ],
                ),
                const SizedBox(height: 24),

                // Call history section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(title: 'Call History'),
                ),

                _HistoryRow(
                  type: 'Incoming Call',
                  date: 'Today',
                  time: '2:34 PM',
                  duration: '4m 12s',
                  iconBg: AppColors.answeredIconBg,
                  iconColor: AppColors.green,
                  icon: Icons.call_received,
                ),
                _HistoryRow(
                  type: 'Outgoing Call',
                  date: 'Yesterday',
                  time: '10:15 AM',
                  duration: '1m 30s',
                  iconBg: AppColors.outgoingIconBg,
                  iconColor: AppColors.blue,
                  icon: Icons.call_made,
                ),
                _HistoryRow(
                  type: 'Missed Call',
                  date: 'May 27',
                  time: '4:22 PM',
                  duration: '--',
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

  void _showMenu(BuildContext context, WidgetRef ref, CallLogModel call) {
    BottomSheetMenu.show(context, [
      BottomSheetAction(
        icon: Icons.block,
        label: 'Block number',
        onTap: () async {
          final confirmed = await ConfirmationDialog.show(
            context,
            title: 'Block this number?',
            message: "You won't receive calls from this number on any alias.",
            confirmLabel: 'Block',
            isDestructive: true,
          );
          if (confirmed) {
            ref.read(callLogProvider.notifier).blockNumber(call.callerNumber);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Number blocked')),
              );
            }
          }
        },
      ),
      BottomSheetAction(
        icon: Icons.save_alt,
        label: 'Save contact',
        onTap: () => _showSaveContactDialog(context, ref, call),
      ),
      BottomSheetAction(
        icon: Icons.copy,
        label: 'Copy number',
        onTap: () {
          Clipboard.setData(ClipboardData(text: call.callerNumber));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Number copied')),
          );
        },
      ),
      BottomSheetAction(
        icon: Icons.report_outlined,
        label: 'Report spam',
        isDestructive: true,
        onTap: () async {
          final confirmed = await ConfirmationDialog.show(
            context,
            title: 'Report as spam?',
            message: 'This number will be flagged and blocked.',
            confirmLabel: 'Report',
            isDestructive: true,
          );
          if (confirmed) {
            ref.read(callLogProvider.notifier).reportSpam(call.callerNumber);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Number reported as spam')),
              );
            }
          }
        },
      ),
    ]);
  }

  void _showSaveContactDialog(BuildContext context, WidgetRef ref, CallLogModel call) {
    final controller = TextEditingController(text: call.callerName);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Save Contact',
          style: GoogleFonts.dmSans(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Contact name',
            hintStyle: GoogleFonts.dmSans(color: AppColors.textTertiary),
          ),
          style: GoogleFonts.dmSans(color: AppColors.textPrimary),
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
          TextButton(
            onPressed: () {
              final nameValue = controller.text.trim();
              Navigator.pop(dialogContext);
              if (nameValue.isNotEmpty) {
                ref.read(callLogProvider.notifier).saveContact(call.callerNumber, nameValue);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact saved')),
                );
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final String type;
  final String date;
  final String time;
  final String duration;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;

  const _HistoryRow({
    required this.type,
    required this.date,
    required this.time,
    required this.duration,
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
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    date,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  duration,
                  style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.textTertiary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
