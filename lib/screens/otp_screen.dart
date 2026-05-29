import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/otp_input_row.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _secondsRemaining = 24;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 24;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                Text('Verify your number', style: AppTheme.otpTitle),
                const SizedBox(height: 6),

                Text.rich(
                  TextSpan(
                    style: AppTheme.body.copyWith(height: 1.4),
                    children: [
                      const TextSpan(text: 'We sent a 4-digit code to\n'),
                      TextSpan(
                        text: '+91 87783 41153',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                const Center(child: OTPInputRow(length: 4)),
                const SizedBox(height: 28),

                Center(
                  child: _secondsRemaining > 0
                      ? Text.rich(
                          TextSpan(
                            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
                            children: [
                              const TextSpan(text: 'Resend code in '),
                              TextSpan(
                                text: '0:${_secondsRemaining.toString().padLeft(2, '0')}',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: _startTimer,
                          child: Text(
                            'Resend code',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () => context.go('/basic-details'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.btnPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Text(
                      'Verify',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Center(
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Text(
                      'Change number',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
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
