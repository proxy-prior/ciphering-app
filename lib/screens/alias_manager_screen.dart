import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/alias_card.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/section_header.dart';
import '../providers/alias_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/user_profile_provider.dart';

class AliasManagerScreen extends ConsumerStatefulWidget {
  const AliasManagerScreen({super.key});

  @override
  ConsumerState<AliasManagerScreen> createState() => _AliasManagerScreenState();
}

class _AliasManagerScreenState extends ConsumerState<AliasManagerScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet() {
    final currentFilter = ref.read(statusFilterProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterBottomSheet(currentFilter: currentFilter),
    ).then((selected) {
      // selected is passed back via Navigator.pop in the sheet
    });
  }

  @override
  Widget build(BuildContext context) {
    final aliases = ref.watch(filteredAliasProvider);
    final allAliases = ref.watch(aliasProvider);
    final stats = ref.watch(aliasStatsProvider);
    final profile = ref.watch(userProfileProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final activeFilter = ref.watch(statusFilterProvider);

    return GradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Top bar
              Row(
                children: [
                  Text(
                    'Hello, ${profile.name.split(' ').first} \u{1F44B}',
                    style: AppTheme.welcomeName,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB923C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'BETA',
                      style: GoogleFonts.dmSans(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
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
              const SizedBox(height: 24),

              // Statement headline
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'How can I help\n', style: AppTheme.statementHeadline),
                    TextSpan(text: 'you ', style: AppTheme.statementHeadline),
                    TextSpan(text: 'today?', style: AppTheme.statementAccent),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats ribbon
              QuickStatsRibbon(
                isQuickStat: true,
                items: [
                  StatItem(value: '${stats.total}', label: 'Aliases'),
                  StatItem(value: '${stats.active}', label: 'Active'),
                  StatItem(value: '${stats.totalCalls}', label: 'Total Calls'),
                ],
              ),
              const SizedBox(height: 20),

              // Search row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 16, color: AppColors.textTertiary.withValues(alpha: 0.4)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                ref.read(searchQueryProvider.notifier).state = value;
                              },
                              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                hintText: 'Search aliases...',
                                hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 7),
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                ref.read(searchQueryProvider.notifier).state = '';
                              },
                              child: Icon(Icons.close, size: 16, color: AppColors.textTertiary.withValues(alpha: 0.6)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _openFilterSheet,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: activeFilter != null ? AppColors.accent : Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                        border: Border.all(
                          color: activeFilter != null ? AppColors.accent : AppColors.border,
                        ),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        size: 18,
                        color: activeFilter != null ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Section header
              SectionHeader(
                title: 'Your Aliases',
                count: '${aliases.length}',
              ),

              // Alias cards
              ...aliases.map((alias) {
                final index = allAliases.indexOf(alias);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AliasCard(
                    alias: alias,
                    onTap: () => context.push('/alias-detail/$index'),
                  ),
                );
              }),

              // Bottom spacer for floating nav
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterBottomSheet extends ConsumerWidget {
  final AliasStatus? currentFilter;

  const _FilterBottomSheet({required this.currentFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = <(String, AliasStatus?)>[
      ('All', null),
      ('Active', AliasStatus.active),
      ('Paused', AliasStatus.paused),
      ('Expired', AliasStatus.expired),
    ];

    final selectedFilter = ref.watch(statusFilterProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Filter by Status',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (selectedFilter != null)
                  GestureDetector(
                    onTap: () {
                      ref.read(statusFilterProvider.notifier).state = null;
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Clear',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((option) {
            final (label, status) = option;
            final isSelected = selectedFilter == status;
            return InkWell(
              onTap: () {
                ref.read(statusFilterProvider.notifier).state = status;
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? AppColors.accent : AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    if (isSelected)
                      Icon(Icons.check, size: 18, color: AppColors.accent),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
