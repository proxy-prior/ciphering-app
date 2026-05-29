import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/alias_card.dart';

class AliasManagerScreen extends StatelessWidget {
  const AliasManagerScreen({super.key});

  void _showAliasMenu(BuildContext context, AliasModel alias) {
    final isActive = alias.status == AliasStatus.active;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.textTertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (isActive)
                ListTile(
                  leading: const Icon(Icons.pause_circle_outline,
                      color: AppColors.disabledColor),
                  title: Text('Disable',
                      style: AppTheme.body
                          .copyWith(color: AppColors.textPrimary)),
                  onTap: () => Navigator.pop(context),
                )
              else
                ListTile(
                  leading: const Icon(Icons.play_circle_outline,
                      color: AppColors.activeColor),
                  title: Text('Reactivate',
                      style: AppTheme.body
                          .copyWith(color: AppColors.textPrimary)),
                  onTap: () => Navigator.pop(context),
                ),
              ListTile(
                leading:
                    const Icon(Icons.delete_outline, color: AppColors.destructiveText),
                title: Text('Delete',
                    style:
                        AppTheme.body.copyWith(color: AppColors.destructiveText)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aliases = MockData.aliases;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Top bar
                Row(
                  children: [
                    Text('Ciphering...', style: AppTheme.wordmark),
                    const Spacer(),
                    // Notification button
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.notifBtnBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.notifications_outlined,
                          size: 18, color: AppColors.purplePrimary),
                    ),
                    const SizedBox(width: 10),
                    // Avatar circle
                    GestureDetector(
                      onTap: () => context.go('/profile'),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.profileGradient,
                        ),
                        child: const Center(
                          child: Icon(Icons.person,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Page header
                Text('Alias Manager', style: AppTheme.pageTitle),
                const SizedBox(height: 4),
                Text('Manage your virtual numbers',
                    style: AppTheme.bodySmall),

                const SizedBox(height: 18),

                // Search row
                Row(
                  children: [
                    // Search bar
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.inputBg,
                          borderRadius:
                              BorderRadius.circular(AppRadius.input),
                          border:
                              Border.all(color: AppColors.inputBorder),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search,
                                size: 18,
                                color: AppColors.textTertiary),
                            const SizedBox(width: 8),
                            Text('Search by name',
                                style: AppTheme.bodySmall.copyWith(
                                    color: AppColors.textTertiary)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Filter button
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.inputBg,
                        borderRadius:
                            BorderRadius.circular(AppRadius.input),
                        border:
                            Border.all(color: AppColors.inputBorder),
                      ),
                      child: const Icon(Icons.filter_list,
                          size: 20, color: AppColors.purplePrimary),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Alias list
                Expanded(
                  child: ListView.builder(
                    itemCount: aliases.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AliasCard(
                          alias: aliases[index],
                          onMenuTap: () =>
                              _showAliasMenu(context, aliases[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // FAB
      floatingActionButton: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.gradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.purplePrimary.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => context.go('/create-alias/verify'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
