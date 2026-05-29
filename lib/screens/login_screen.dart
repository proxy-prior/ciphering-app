import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Logo icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppColors.gradient,
                    borderRadius: BorderRadius.circular(AppRadius.logo),
                  ),
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Wordmark
                Text('Ciphering...', style: AppTheme.wordmarkLarge),
                const SizedBox(height: 48),

                // Title
                Text(
                  'Your Mobile Number',
                  style: AppTheme.pageTitle.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your mobile number to continue',
                  style: AppTheme.bodySmall,
                ),
                const SizedBox(height: 32),

                // Phone input
                AppTextField(
                  label: 'Mobile Number',
                  hint: 'Enter 10-digit number',
                  keyboardType: TextInputType.phone,
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+91',
                        style: AppTheme.body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 1,
                        height: 24,
                        color: AppColors.inputBorder,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Send OTP button
                PrimaryButton(
                  label: 'Send OTP',
                  onPressed: () => context.go('/otp'),
                ),
                const SizedBox(height: 24),

                // Footer
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTheme.caption,
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: AppTheme.caption.copyWith(
                          color: AppColors.purplePrimary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTheme.caption.copyWith(
                          color: AppColors.purplePrimary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
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
}
