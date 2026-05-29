import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/quick_stats_ribbon.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/settings_row.dart';
import '../widgets/confirmation_dialog.dart';
import '../providers/alias_provider.dart';
import '../providers/call_log_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/user_profile_provider.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _enterEditMode() {
    final profile = ref.read(userProfileProvider);
    _nameController.text = profile.name;
    _emailController.text = profile.email;
    setState(() => _isEditing = true);
  }

  void _saveProfile() {
    ref.read(userProfileProvider.notifier).updateName(_nameController.text);
    ref.read(userProfileProvider.notifier).updateEmail(_emailController.text);
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  void _cancelEdit() {
    final profile = ref.read(userProfileProvider);
    _nameController.text = profile.name;
    _emailController.text = profile.email;
    setState(() => _isEditing = false);
  }

  void _showCallSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => _CallSettingsDialog(),
    );
  }

  void _showPrivacySecurityDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Privacy & Security',
          style: GoogleFonts.dmSans(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your data is encrypted and stored securely. Ciphering never shares your personal information.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                ref.read(callLogProvider.notifier).clearAll();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Call history cleared')),
                );
              },
              child: Text(
                'Clear Call History',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.redText,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Close',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignOut() async {
    final confirmed = await ConfirmationDialog.show(
      context,
      title: 'Sign Out?',
      message: "You'll need to verify your number again to sign back in.",
      confirmLabel: 'Sign Out',
      isDestructive: true,
    );
    if (confirmed && mounted) {
      ref.read(aliasProvider.notifier).reset();
      ref.read(callLogProvider.notifier).reset();
      ref.read(notificationProvider.notifier).reset();
      ref.read(userProfileProvider.notifier).reset();
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);
    final aliasCount = ref.watch(aliasProvider).length;

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
                    if (_isEditing) ...[
                      IconButtonCircle(
                        icon: Icons.close,
                        onTap: _cancelEdit,
                      ),
                      const SizedBox(width: 8),
                      IconButtonCircle(
                        icon: Icons.check,
                        onTap: _saveProfile,
                      ),
                    ] else
                      IconButtonCircle(
                        icon: Icons.edit_outlined,
                        onTap: _enterEditMode,
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
                          profile.name.isNotEmpty
                              ? profile.name.substring(0, 1)
                              : '?',
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
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Camera not available in demo mode')),
                          );
                        },
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.camera_alt_outlined,
                              size: 12, color: Color(0xFF475569)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (_isEditing) ...[
                  _buildEditTextField(
                    controller: _nameController,
                    hint: 'Full name',
                    style: AppTheme.profileName,
                  ),
                  const SizedBox(height: 8),
                ] else ...[
                  Text(profile.name, style: AppTheme.profileName),
                ],

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

                if (_isEditing) ...[
                  const SizedBox(height: 4),
                  _buildEditTextField(
                    controller: _emailController,
                    hint: 'Email',
                    style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: 4),
                ] else ...[
                  Text(
                    profile.email,
                    style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textTertiary),
                  ),
                ],
                const SizedBox(height: 28),

                QuickStatsRibbon(
                  items: [
                    StatItem(value: '$aliasCount', label: 'Aliases'),
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
                                    Text(item.value,
                                        style: AppTheme.statValueDetail),
                                    const SizedBox(height: 4),
                                    Text(item.label, style: AppTheme.statLabel),
                                  ],
                                ),
                              ),
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(Icons.lock_outline,
                                    size: 12,
                                    color: AppColors.textQuaternary),
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
                        onTap: _enterEditMode,
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
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Identity verified via DigiLocker')),
                          );
                        },
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
                        toggleValue: profile.notificationsEnabled,
                        onToggleChanged: (v) {
                          ref
                              .read(userProfileProvider.notifier)
                              .setNotificationsEnabled(v);
                        },
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
                        onTap: _showCallSettingsDialog,
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
                        onTap: _showPrivacySecurityDialog,
                      ),
                      SettingsRow(
                        icon: Icons.info_outline,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: AppColors.textTertiary,
                        label: 'About',
                        subtitle: 'Terms, privacy, licenses',
                        showDivider: false,
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'Ciphering',
                            applicationVersion: '1.0.0',
                            applicationLegalese:
                                'Privacy-first virtual phone numbers for India.',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: _handleSignOut,
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

  Widget _buildEditTextField({
    required TextEditingController controller,
    required String hint,
    required TextStyle style,
  }) {
    return SizedBox(
      width: 220,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: style,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: style.copyWith(color: AppColors.textTertiary),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.accent),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Call Settings dialog — owns its own local toggle state
// ---------------------------------------------------------------------------
class _CallSettingsDialog extends StatefulWidget {
  @override
  State<_CallSettingsDialog> createState() => _CallSettingsDialogState();
}

class _CallSettingsDialogState extends State<_CallSettingsDialog> {
  bool _callForwarding = false;
  bool _voicemail = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Call Settings',
        style: GoogleFonts.dmSans(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Call Forwarding',
              style: GoogleFonts.dmSans(
                  fontSize: 14, color: AppColors.textPrimary),
            ),
            value: _callForwarding,
            onChanged: (v) => setState(() => _callForwarding = v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Voicemail',
              style: GoogleFonts.dmSans(
                  fontSize: 14, color: AppColors.textPrimary),
            ),
            value: _voicemail,
            onChanged: (v) => setState(() => _voicemail = v),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
