import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/section_header.dart';
import '../widgets/settings_row.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _callRecording = false;

  @override
  Widget build(BuildContext context) {
    final user = MockData.userProfile;

    return GradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar: wordmark + avatar (no notification button)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Text('Ciphering...', style: AppTheme.wordmark),
                      const Spacer(),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty ? user.name[0] : '',
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
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Settings', style: AppTheme.pageTitle),
                      const SizedBox(height: 4),
                      Text('Manage your account', style: AppTheme.bodySmall),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Profile card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.profileGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // Avatar circle
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.25),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty ? user.name[0] : '',
                            style: AppTheme.body.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name, phone, badge
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: AppTheme.body.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user.phone,
                              style: AppTheme.body.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                            if (user.isPremium) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Premium User',
                                  style: AppTheme.body.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Edit text
                      Text(
                        'Edit',
                        style: AppTheme.body.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // APP PREFERENCES section
                const SectionHeader(title: 'App Preferences'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      // Push Notifications toggle
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Push Notifications',
                                    style: AppTheme.body.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Get alerts for calls & messages',
                                    style: AppTheme.caption.copyWith(
                                      fontSize: 12,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _GradientSwitch(
                              value: _pushNotifications,
                              onChanged: (val) =>
                                  setState(() => _pushNotifications = val),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.navDivider,
                      ),
                      // Call Recording toggle
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Call Recording',
                                    style: AppTheme.body.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Record incoming calls',
                                    style: AppTheme.caption.copyWith(
                                      fontSize: 12,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _GradientSwitch(
                              value: _callRecording,
                              onChanged: (val) =>
                                  setState(() => _callRecording = val),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ACCOUNT section
                const SectionHeader(title: 'Account'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      SettingsRow(
                        icon: Icons.person,
                        label: 'Profile Settings',
                        subtitle: 'Edit name, email, DOB',
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.navDivider,
                      ),
                      SettingsRow(
                        icon: Icons.lock,
                        label: 'Privacy & Security',
                        subtitle: 'Manage your data',
                      ),
                    ],
                  ),
                ),

                // APP SETTINGS section
                const SectionHeader(title: 'App Settings'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      SettingsRow(
                        icon: Icons.language,
                        label: 'Language',
                        subtitle: 'English',
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.navDivider,
                      ),
                      SettingsRow(
                        icon: Icons.info_outline,
                        label: 'About',
                        subtitle: 'Version 1.0.0',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sign Out button
                GestureDetector(
                  onTap: () => _showSignOutConfirmation(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.destructiveBg,
                      border: Border.all(
                        color: AppColors.destructiveBorder,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 18,
                          color: AppColors.destructiveText,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sign Out',
                          style: AppTheme.body.copyWith(
                            color: AppColors.destructiveText,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure?',
              style: AppTheme.heading,
            ),
            const SizedBox(height: 8),
            Text(
              'You will be signed out of your account.',
              style: AppTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            // Destructive Sign Out button
            GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.destructiveBg,
                  border: Border.all(
                    color: AppColors.destructiveBorder,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: AppTheme.body.copyWith(
                      color: AppColors.destructiveText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Cancel text button
            GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Cancel',
                  style: AppTheme.body.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom gradient toggle switch widget.
class _GradientSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _GradientSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          gradient: value ? AppColors.gradient : null,
          color: value ? null : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
