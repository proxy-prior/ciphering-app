import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../providers/notification_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/glass_card.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  int _selectedTab = 0;

  List<NotificationModel> _filterByTab(List<NotificationModel> all) {
    switch (_selectedTab) {
      case 1:
        return all
            .where((n) =>
                n.type == NotificationType.call ||
                n.type == NotificationType.missedCall ||
                n.type == NotificationType.block)
            .toList();
      case 2:
        return all
            .where((n) =>
                n.type == NotificationType.alias ||
                n.type == NotificationType.security ||
                n.type == NotificationType.system)
            .toList();
      default:
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allNotifications = ref.watch(notificationProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final allReadAlready = unreadCount == 0;

    final filtered = _filterByTab(allNotifications);
    final newItems = filtered.where((n) => !n.isRead).toList();
    final earlierItems = filtered.where((n) => n.isRead).toList();

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        useAurora: false,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    IconButtonCircle(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Inbox', style: AppTheme.pageTitle),
                    ),
                    Opacity(
                      opacity: allReadAlready ? 0.4 : 1.0,
                      child: GestureDetector(
                        onTap: allReadAlready
                            ? null
                            : () => ref.read(notificationProvider.notifier).markAllRead(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.accentBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Mark all read',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Segmented tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(AppRadius.tabOuter),
                  ),
                  child: Row(
                    children: [
                      _Tab(
                        label: 'All',
                        badge: unreadCount > 0 ? unreadCount : null,
                        isActive: _selectedTab == 0,
                        onTap: () => setState(() => _selectedTab = 0),
                      ),
                      _Tab(
                        label: 'Activity',
                        isActive: _selectedTab == 1,
                        onTap: () => setState(() => _selectedTab = 1),
                      ),
                      _Tab(
                        label: 'Alerts',
                        isActive: _selectedTab == 2,
                        onTap: () => setState(() => _selectedTab = 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Notification list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  children: [
                    if (newItems.isNotEmpty) ...[
                      Text('NEW', style: AppTheme.sectionLabel),
                      const SizedBox(height: 10),
                      ...newItems.map((n) {
                        final globalIndex = allNotifications.indexOf(n);
                        return _NotificationItem(
                          notification: n,
                          onTap: () => ref
                              .read(notificationProvider.notifier)
                              .markRead(globalIndex),
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                    if (earlierItems.isNotEmpty) ...[
                      Text('EARLIER', style: AppTheme.sectionLabel),
                      const SizedBox(height: 10),
                      ...earlierItems.map((n) {
                        final globalIndex = allNotifications.indexOf(n);
                        return _NotificationItem(
                          notification: n,
                          onTap: () => ref
                              .read(notificationProvider.notifier)
                              .markRead(globalIndex),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final int? badge;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    this.badge,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.tabInner),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 3, offset: const Offset(0, 1))]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 4),
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  Color get _iconBg {
    switch (notification.type) {
      case NotificationType.call: return AppColors.answeredIconBg;
      case NotificationType.missedCall: return AppColors.missedIconBg;
      case NotificationType.alias: return AppColors.outgoingIconBg;
      case NotificationType.security: return AppColors.pausedBadgeBg;
      case NotificationType.system: return AppColors.blockedBadgeBg;
      case NotificationType.block: return AppColors.blockedBadgeBg;
    }
  }

  Color get _iconColor {
    switch (notification.type) {
      case NotificationType.call: return AppColors.green;
      case NotificationType.missedCall: return AppColors.redText;
      case NotificationType.alias: return AppColors.blue;
      case NotificationType.security: return AppColors.yellow;
      case NotificationType.system: return AppColors.purple;
      case NotificationType.block: return AppColors.purple;
    }
  }

  IconData get _icon {
    switch (notification.type) {
      case NotificationType.call: return Icons.call;
      case NotificationType.missedCall: return Icons.call_missed;
      case NotificationType.alias: return Icons.phone_android;
      case NotificationType.security: return Icons.shield_outlined;
      case NotificationType.system: return Icons.info_outline;
      case NotificationType.block: return Icons.block;
    }
  }

  String get _timeAgo {
    final diff = DateTime.now().difference(notification.timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${diff.inDays ~/ 7}w ago';
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _iconBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_icon, size: 18, color: _iconColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          notification.description,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _timeAgo,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textQuaternary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isUnread)
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
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
