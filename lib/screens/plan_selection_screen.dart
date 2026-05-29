import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';

class PlanSelectionScreen extends StatefulWidget {
  const PlanSelectionScreen({super.key});

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  String? _selectedPlan;

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
                  'Choose Your Plan',
                  style: AppTheme.pageTitle,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFreePlanCard(),
                        const SizedBox(height: 16),
                        _buildPremiumPlanCard(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Continue',
                  onPressed: _selectedPlan != null
                      ? () => context.push('/create-alias/confirmation')
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

  Widget _buildFreePlanCard() {
    final isSelected = _selectedPlan == 'free';
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = 'free'),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.screenBg,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Free', style: AppTheme.heading),
            const SizedBox(height: 16),
            _buildFeatureRow('1 alias number'),
            const SizedBox(height: 10),
            _buildFeatureRow('Basic call forwarding'),
            const SizedBox(height: 10),
            _buildFeatureRow('SMS viewing'),
            const SizedBox(height: 10),
            _buildFeatureRow('30-day validity'),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumPlanCard() {
    final isSelected = _selectedPlan == 'premium';
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = 'premium'),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.profileGradient,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.screenBg,
            borderRadius: BorderRadius.circular(AppRadius.card - 2),
          ),
          padding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Premium', style: AppTheme.heading),
                  const SizedBox(height: 4),
                  Text(
                    'INR 99/month',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow('Unlimited aliases'),
                  const SizedBox(height: 10),
                  _buildFeatureRow('Call recording'),
                  const SizedBox(height: 10),
                  _buildFeatureRow('Priority support'),
                  const SizedBox(height: 10),
                  _buildFeatureRow('Auto-renewal'),
                  const SizedBox(height: 10),
                  _buildFeatureRow('Extended validity'),
                ],
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.profileGradient,
                    borderRadius: BorderRadius.circular(AppRadius.badge),
                  ),
                  child: Text(
                    'Recommended',
                    style: AppTheme.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 18,
          color: AppColors.green,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: AppTheme.bodySmall),
        ),
      ],
    );
  }
}
