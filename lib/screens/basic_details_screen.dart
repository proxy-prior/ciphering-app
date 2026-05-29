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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _nameError;
  String? _emailError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    String? nameError;
    String? emailError;

    if (name.isEmpty) {
      nameError = 'Name is required';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError = 'Enter a valid email';
    }

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
    });

    if (nameError == null && emailError == null) {
      context.go('/onboarding/verify');
    }
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
                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFED7AA)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'BETA',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'The service is provided on a testing basis, features may change without notice, and availability is not guaranteed. By participating, you agree to use the service only for lawful purposes and acknowledge that functionality may be modified, suspended, or discontinued during the beta period.',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: const Color(0xFF9A3412),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Camera not available in demo mode'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
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
                          const Icon(Icons.camera_alt_outlined,
                              size: 24, color: AppColors.textTertiary),
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
                ),
                const SizedBox(height: 24),

                AppTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                ),
                if (_nameError != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _nameError!,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                if (_emailError != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _emailError!,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.btnPrimary
                              : Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppRadius.filterPill),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.btnPrimary
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          option,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: _onContinue,
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
