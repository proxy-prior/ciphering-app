import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Your number,\n', style: AppTheme.loginHeadline),
                      TextSpan(text: 'your ', style: AppTheme.loginHeadline),
                      TextSpan(text: 'identity.', style: AppTheme.loginHeadlineGray),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Sign in to manage your virtual aliases',
                  style: AppTheme.body,
                ),
                const SizedBox(height: 36),

                Text(
                  'Mobile Number',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                      ),
                      child: Text(
                        '+91',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.border),
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'Enter 10-digit number',
                            hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textTertiary),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () => context.go('/otp'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.btnPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTheme.terms.copyWith(height: 1.6),
                      children: [
                        const TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms',
                          style: AppTheme.terms.copyWith(color: AppColors.accent),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTheme.terms.copyWith(color: AppColors.accent),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
