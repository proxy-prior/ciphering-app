import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/app_text_field.dart';

class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  String _selectedUsage = 'Personal';

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
                const SizedBox(height: 40),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _StepDot(isDone: true),
                      const SizedBox(width: 6),
                      _StepDot(isActive: true),
                      const SizedBox(width: 6),
                      _StepDot(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Text('Set up your profile', style: AppTheme.otpTitle),
                const SizedBox(height: 6),
                Text('Tell us a bit about yourself', style: AppTheme.body),
                const SizedBox(height: 24),

                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.textQuaternary,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.camera_alt_outlined, size: 24, color: AppColors.textTertiary),
                        Text(
                          'Add photo',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const AppTextField(label: 'Full Name', hint: 'Enter your full name', keyboardType: TextInputType.name),
                const SizedBox(height: 18),
                const AppTextField(label: 'Email', hint: 'you@example.com', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 24),

                Text(
                  'How will you use Ciphering?',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: ['Personal', 'Business', 'Both'].map((option) {
                    final isSelected = _selectedUsage == option;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedUsage = option),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.btnPrimary : Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.filterPill),
                          border: Border.all(
                            color: isSelected ? AppColors.btnPrimary : AppColors.border,
                          ),
                        ),
                        child: Text(
                          option,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () => context.go('/home/alias'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.btnPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Text(
                      'Get Started',
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
