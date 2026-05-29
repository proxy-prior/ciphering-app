import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/otp_input_row.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                  'Verify OTP',
                  style: AppTheme.pageTitle.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  'We\'ve sent a 6-digit code to\n+91 xxxxx xxxxx',
                  textAlign: TextAlign.center,
                  style: AppTheme.bodySmall,
                ),
                const SizedBox(height: 32),

                // OTP Input
                const OTPInputRow(),
                const SizedBox(height: 24),

                // Resend countdown
                if (_secondsRemaining > 0)
                  RichText(
                    text: TextSpan(
                      style: AppTheme.bodySmall,
                      children: [
                        const TextSpan(text: 'Resend OTP in '),
                        TextSpan(
                          text: '${_secondsRemaining}s',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppColors.purplePrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _startTimer,
                    child: Text(
                      'Resend OTP',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppColors.purplePrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),

                // Verify OTP button
                PrimaryButton(
                  label: 'Verify OTP',
                  onPressed: () => context.go('/basic-details'),
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
