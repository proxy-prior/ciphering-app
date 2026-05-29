import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/alias_card.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/section_header.dart';

class AliasManagerScreen extends StatelessWidget {
  const AliasManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aliases = MockData.aliases;
    final profile = MockData.userProfile;
    final activeCount = aliases.where((a) => a.status == AliasStatus.active).length;
    final totalCalls = aliases.fold<int>(0, (sum, a) => sum + a.totalCalls);

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
                  StatItem(value: '${aliases.length}', label: 'Aliases'),
                  StatItem(value: '$activeCount', label: 'Active'),
                  StatItem(value: '$totalCalls', label: 'Total Calls'),
                ],
              ),
              const SizedBox(height: 20),

              // Search row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 16, color: AppColors.textTertiary.withValues(alpha: 0.4)),
                          const SizedBox(width: 10),
                          Text(
                            'Search aliases...',
                            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.filter_list, size: 18, color: AppColors.textSecondary),
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
              ...aliases.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AliasCard(
                      alias: entry.value,
                      onTap: () => context.push('/alias-detail/${entry.key}'),
                    ),
                  )),

              // Bottom spacer for floating nav
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}
