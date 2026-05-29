import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/app_text_field.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // Title
                Text(
                  'Complete Your Profile',
                  style: AppTheme.pageTitle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Just a few details to get you started',
                  style: AppTheme.bodySmall,
                ),
                const SizedBox(height: 36),

                // Full Name field
                const AppTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),

                // Email Address field
                const AppTextField(
                  label: 'Email Address',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Date of Birth field
                AppTextField(
                  label: 'Date of Birth',
                  hint: 'DD / MM / YYYY',
                  keyboardType: TextInputType.datetime,
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.activeColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.activeColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Step 2 of 3',
                    style: AppTheme.caption,
                  ),
                ),
                const SizedBox(height: 24),

                // Continue button
                PrimaryButton(
                  label: 'Continue',
                  onPressed: () => context.go('/home/alias'),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
