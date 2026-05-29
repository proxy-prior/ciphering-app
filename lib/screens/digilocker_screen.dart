import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';

class DigilockerScreen extends StatefulWidget {
  final bool isOnboarding;

  const DigilockerScreen({super.key, this.isOnboarding = false});

  @override
  State<DigilockerScreen> createState() => _DigilockerScreenState();
}

class _DigilockerScreenState extends State<DigilockerScreen> {
  bool _isVerifying = false;

  void _startVerification() {
    setState(() => _isVerifying = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isVerifying = false);
        if (widget.isOnboarding) {
          context.go('/home/alias');
        } else {
          context.push('/create-alias/purpose');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        useAurora: widget.isOnboarding,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Back button (only when not onboarding, or allow going back)
                if (!widget.isOnboarding)
                  IconButtonCircle(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).pop(),
                  ),

                if (widget.isOnboarding) ...[
                  const SizedBox(height: 28),
                  // Step indicator: step 3 of 3
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _StepDot(isDone: true),
                        const SizedBox(width: 6),
                        _StepDot(isDone: true),
                        const SizedBox(width: 6),
                        _StepDot(isActive: true),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Centered content
                Center(
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: AppColors.profileGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.verified_user,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Verify your identity',
                        style: AppTheme.otpTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'We use DigiLocker for secure eKYC verification to keep your alias safe and compliant.',
                          style: AppTheme.body.copyWith(height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Bullet points
                      _BulletPoint(text: 'Instantly verifies your Aadhaar via DigiLocker'),
                      const SizedBox(height: 12),
                      _BulletPoint(text: 'No documents to upload \u2014 fully digital'),
                      const SizedBox(height: 12),
                      _BulletPoint(text: 'Your data is encrypted and never stored'),
                    ],
                  ),
                ),

                const Spacer(),

                // CTA button
                if (_isVerifying)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(
                        color: AppColors.accent,
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _startVerification,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.btnPrimary,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                      ),
                      child: Text(
                        'Verify with DigiLocker',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTheme.bodySmall.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool isDone;
  final bool isActive;

  const _StepDot({this.isDone = false, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
        width: 24,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.btnPrimary,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isDone ? AppColors.green : AppColors.pillBorder,
        shape: BoxShape.circle,
      ),
    );
  }
}
