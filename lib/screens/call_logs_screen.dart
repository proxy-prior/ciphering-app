import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/call_log_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/call_log_row.dart';
import '../widgets/filter_pill.dart';
import '../widgets/section_header.dart';
import '../widgets/icon_button_circle.dart';

class CallLogsScreen extends ConsumerWidget {
  const CallLogsScreen({super.key});

  static const _filters = ['All', 'Missed', 'Spam', 'Saved'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(callFilterProvider);
    final filteredLogs = ref.watch(filteredCallLogProvider);
    final allLogs = ref.watch(callLogProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final profile = ref.watch(userProfileProvider);

    final groups = <String, List<CallLogModel>>{};
    for (final log in filteredLogs) {
      groups.putIfAbsent(log.timeGroup, () => []).add(log);
    }

    return GradientBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Text('Call Logs', style: AppTheme.pageTitle),
                  const Spacer(),
                  IconButtonCircle(
                    icon: Icons.notifications_outlined,
                    onTap: () => context.push('/notifications'),
                    badge: unreadCount > 0
                        ? Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.notifBadgeBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.screenBg, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                '$unreadCount',
                                style: GoogleFonts.dmSans(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => context.push('/profile'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.profileGradient,
                      ),
                      child: Center(
                        child: Text(
                          profile.name[0],
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Filter pills
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: _filters
                    .map((filter) => Padding(
                          padding: EdgeInsets.only(right: filter != _filters.last ? 6 : 0),
                          child: FilterPill(
                            label: filter,
                            isActive: selectedFilter == filter,
                            onTap: () =>
                                ref.read(callFilterProvider.notifier).state = filter,
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Grouped call rows
            Expanded(
              child: groups.isEmpty
                  ? Center(child: Text('No call logs found', style: AppTheme.body))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      itemCount: groups.length,
                      itemBuilder: (context, groupIndex) {
                        final timeGroup = groups.keys.elementAt(groupIndex);
                        final logs = groups[timeGroup]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (groupIndex > 0) const SizedBox(height: 8),
                            SectionHeader(title: timeGroup),
                            ...logs.asMap().entries.map(
                              (entry) {
                                final globalIndex = allLogs.indexOf(entry.value);
                                return CallLogRow(
                                  call: entry.value,
                                  onTap: () => context.push('/call-detail/$globalIndex'),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
            ),

            // Bottom spacer for floating nav
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}
