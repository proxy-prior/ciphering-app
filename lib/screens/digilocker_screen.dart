import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';

class DigilockerScreen extends StatefulWidget {
  const DigilockerScreen({super.key});

  @override
  State<DigilockerScreen> createState() => _DigilockerScreenState();
}

class _DigilockerScreenState extends State<DigilockerScreen> {
  bool _isVerifying = false;

  void _startVerification() {
    setState(() => _isVerifying = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.push('/create-alias/purpose');
        setState(() => _isVerifying = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.inputBg,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: AppColors.profileGradient,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.verified_user,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Verify your identity',
                        style: AppTheme.pageTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We use DigiLocker for secure eKYC verification to keep your alias safe and compliant.',
                        style: AppTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      _buildBulletPoint('Instantly verifies your Aadhaar via DigiLocker'),
                      const SizedBox(height: 10),
                      _buildBulletPoint('No documents to upload — fully digital'),
                      const SizedBox(height: 10),
                      _buildBulletPoint('Your data is encrypted and never stored'),
                    ],
                  ),
                ),
                const Spacer(),
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
                  PrimaryButton(
                    label: 'Verify with DigiLocker',
                    onPressed: _startVerification,
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
