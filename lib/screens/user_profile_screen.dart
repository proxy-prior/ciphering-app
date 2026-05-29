import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/settings_row.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final profile = MockData.userProfile;

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

                Row(
                  children: [
                    IconButtonCircle(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text('Profile', style: AppTheme.pageTitle)),
                    IconButtonCircle(
                      icon: Icons.edit_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.profileGradient,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          profile.name.substring(0, 1),
                          style: GoogleFonts.dmSans(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.camera_alt_outlined, size: 12, color: Color(0xFF475569)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(profile.name, style: AppTheme.profileName),
                const SizedBox(height: 4),
                Text(
                  profile.phone,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  profile.email,
                  style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 28),

                QuickStatsRibbon(
                  items: [
                    StatItem(value: '${profile.aliasCount}', label: 'Aliases'),
                    const StatItem(value: 'Pro', label: 'Plan'),
                    StatItem(value: '${profile.memberDays}', label: 'Member'),
                  ],
                  itemBuilder: (index, item) {
                    if (index == 1) {
                      return GlassCard(
                        borderRadius: 14,
                        padding: const EdgeInsets.all(12),
                        child: Opacity(
                          opacity: 0.45,
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(item.value, style: AppTheme.statValueDetail),
                                    const SizedBox(height: 4),
                                    Text(item.label, style: AppTheme.statLabel),
                                  ],
                                ),
                              ),
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(Icons.lock_outline, size: 12, color: AppColors.textQuaternary),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return GlassCard(
                      borderRadius: 14,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(item.value, style: AppTheme.statValueDetail),
                          const SizedBox(height: 4),
                          Text(item.label, style: AppTheme.statLabel),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(title: 'Account'),
                ),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SettingsRow(
                        icon: Icons.person_outline,
                        iconBg: AppColors.outgoingIconBg,
                        iconColor: AppColors.blue,
                        label: 'Personal Info',
                        subtitle: 'Name, email, phone',
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.card_membership,
                        iconBg: AppColors.blockedBadgeBg,
                        iconColor: AppColors.purple,
                        label: 'Subscription',
                        subtitle: 'Coming soon',
                        trailing: SettingsRowTrailing.lock,
                        isLocked: true,
                      ),
                      SettingsRow(
                        icon: Icons.verified_user_outlined,
                        iconBg: AppColors.answeredIconBg,
                        iconColor: AppColors.green,
                        label: 'KYC Verification',
                        subtitle: 'DigiLocker verified',
                        showDivider: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(title: 'Preferences'),
                ),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SettingsRow(
                        icon: Icons.notifications_outlined,
                        iconBg: AppColors.pausedBadgeBg,
                        iconColor: AppColors.yellow,
                        label: 'Notifications',
                        subtitle: 'Push notifications',
                        trailing: SettingsRowTrailing.toggle,
                        toggleValue: _notificationsEnabled,
                        onToggleChanged: (v) => setState(() => _notificationsEnabled = v),
                      ),
                      SettingsRow(
                        icon: Icons.wb_sunny_outlined,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: AppColors.textTertiary,
                        label: 'Dark Mode',
                        subtitle: 'Coming soon',
                        trailing: SettingsRowTrailing.lock,
                        isLocked: true,
                      ),
                      SettingsRow(
                        icon: Icons.settings_outlined,
                        iconBg: AppColors.outgoingIconBg,
                        iconColor: AppColors.blue,
                        label: 'Call Settings',
                        subtitle: 'Forwarding, voicemail, DND',
                        showDivider: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: SectionHeader(title: 'Security'),
                ),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SettingsRow(
                        icon: Icons.shield_outlined,
                        iconBg: AppColors.answeredIconBg,
                        iconColor: AppColors.green,
                        label: 'Privacy & Security',
                        subtitle: '2FA, biometrics, data',
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.info_outline,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: AppColors.textTertiary,
                        label: 'About',
                        subtitle: 'Terms, privacy, licenses',
                        showDivider: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Text(
                      'Sign Out',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.redText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text('Ciphering v1.0.0', style: AppTheme.version),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
