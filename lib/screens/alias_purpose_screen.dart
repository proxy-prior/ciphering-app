import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/app_text_field.dart';

class AliasPurposeScreen extends StatefulWidget {
  const AliasPurposeScreen({super.key});

  @override
  State<AliasPurposeScreen> createState() => _AliasPurposeScreenState();
}

class _AliasPurposeScreenState extends State<AliasPurposeScreen> {
  String? _selectedPurpose;
  final TextEditingController _customController = TextEditingController();

  static const List<String> _purposes = [
    'Insurance',
    'E-commerce',
    'Food Delivery',
    'Banking',
    'Other',
  ];

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  bool get _canContinue {
    if (_selectedPurpose == null) return false;
    if (_selectedPurpose == 'Other' && _customController.text.trim().isEmpty) {
      return false;
    }
    return true;
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
                const SizedBox(height: 32),
                Text(
                  "What's this alias for?",
                  style: AppTheme.pageTitle,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _purposes.map((purpose) {
                    final isSelected = _selectedPurpose == purpose;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPurpose = purpose),
                      child: _buildChip(purpose, isSelected),
                    );
                  }).toList(),
                ),
                if (_selectedPurpose == 'Other') ...[
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Custom purpose',
                    hint: 'Enter your purpose',
                    controller: _customController,
                  ),
                ],
                const Spacer(),
                PrimaryButton(
                  label: 'Continue',
                  onPressed: _canContinue
                      ? () => context.push('/create-alias/plan')
                      : null,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    if (isSelected) {
      return Container(
        decoration: BoxDecoration(
          gradient: AppColors.profileGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(1.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.screenBg,
            borderRadius: BorderRadius.circular(10.5),
          ),
          child: Text(
            label,
            style: AppTheme.body.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.screenBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTheme.body.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
