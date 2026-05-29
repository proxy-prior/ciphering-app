import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/call_log_row.dart';
import '../widgets/filter_pill.dart';
import '../widgets/section_header.dart';
import '../widgets/icon_button_circle.dart';

class CallLogsScreen extends StatefulWidget {
  const CallLogsScreen({super.key});

  @override
  State<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends State<CallLogsScreen> {
  String _selectedFilter = 'All';

  static const _filters = ['All', 'Missed', 'Spam', 'Saved'];

  List<CallLogModel> get _filteredLogs {
    final logs = MockData.callLogs;
    switch (_selectedFilter) {
      case 'Missed':
        return logs.where((c) => c.status == CallStatus.missed).toList();
      case 'Spam':
        return logs.where((c) => c.status == CallStatus.blocked).toList();
      case 'Saved':
        return logs.where((c) => c.status == CallStatus.answered).toList();
      default:
        return logs;
    }
  }

  Map<String, List<CallLogModel>> get _groupedLogs {
    final filtered = _filteredLogs;
    final grouped = <String, List<CallLogModel>>{};
    for (final log in filtered) {
      grouped.putIfAbsent(log.timeGroup, () => []).add(log);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groups = _groupedLogs;
    final profile = MockData.userProfile;

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
                    badge: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.notifBadgeBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.screenBg, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: GoogleFonts.dmSans(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                            isActive: _selectedFilter == filter,
                            onTap: () => setState(() => _selectedFilter = filter),
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
                                final globalIndex = MockData.callLogs.indexOf(entry.value);
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
