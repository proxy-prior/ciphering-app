import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/section_header.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = MockData.userProfile;
    final activities = MockData.activityLog;

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: AppBar(
        backgroundColor: AppColors.screenBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Profile', style: AppTheme.heading),
        centerTitle: false,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity Log section
              const SectionHeader(title: 'Activity Log'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return _ActivityLogTile(entry: activities[index]);
                },
              ),

              // Premium Upsell section
              if (!profile.isPremium) ...[
                const SizedBox(height: 20),
                _PremiumUpsellCard(),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityLogTile extends StatelessWidget {
  final ActivityLogEntry entry;

  const _ActivityLogTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final formattedTime =
        DateFormat('dd MMM yyyy, hh:mm a').format(entry.timestamp);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.screenBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: entry.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(entry.icon, color: entry.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Text column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.description,
                  style: AppTheme.body.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.aliasNumber,
                  style: AppTheme.caption,
                ),
                const SizedBox(height: 2),
                Text(
                  formattedTime,
                  style: AppTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumUpsellCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const benefits = [
      'Unlimited aliases',
      'Call recording',
      'Priority support',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.profileGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade to Premium',
            style: AppTheme.heading.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ...benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    benefit,
                    style: AppTheme.body.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Upgrade Now',
                textAlign: TextAlign.center,
                style: AppTheme.body.copyWith(
                  color: AppColors.purplePrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
