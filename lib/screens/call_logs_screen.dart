import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/call_log_row.dart';
import '../widgets/filter_pill.dart';
import '../widgets/section_header.dart';

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

    return GradientBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text('Ciphering...', style: AppTheme.wordmark),
                  const Spacer(),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.notifBtnBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'D',
                        style: AppTheme.body.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Call Logs', style: AppTheme.pageTitle),
                  const SizedBox(height: 4),
                  Text('Your call history', style: AppTheme.bodySmall),
                ],
              ),
            ),

            // Filter pills row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                children: _filters
                    .map(
                      (filter) => Padding(
                        padding: EdgeInsets.only(
                          right: filter != _filters.last ? 8 : 0,
                        ),
                        child: FilterPill(
                          label: filter,
                          isActive: _selectedFilter == filter,
                          onTap: () => setState(() => _selectedFilter = filter),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // Scrollable content
            Expanded(
              child: groups.isEmpty
                  ? Center(
                      child: Text(
                        'No call logs found',
                        style: AppTheme.bodySmall,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: groups.length,
                      itemBuilder: (context, groupIndex) {
                        final timeGroup = groups.keys.elementAt(groupIndex);
                        final logs = groups[timeGroup]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(title: timeGroup),
                            ...logs.map(
                              (log) => CallLogRow(
                                call: log,
                                onCallBack: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Calling back...'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
