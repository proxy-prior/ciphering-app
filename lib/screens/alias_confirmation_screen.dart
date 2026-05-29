import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/primary_button.dart';
import '../providers/alias_provider.dart';
import '../data/mock_data.dart';

class AliasConfirmationScreen extends ConsumerStatefulWidget {
  const AliasConfirmationScreen({super.key});

  @override
  ConsumerState<AliasConfirmationScreen> createState() =>
      _AliasConfirmationScreenState();
}

class _AliasConfirmationScreenState
    extends ConsumerState<AliasConfirmationScreen> {
  late final String _generatedNumber;

  @override
  void initState() {
    super.initState();
    _generatedNumber = AliasNotifier.generateAliasNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.profileGradient,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your new alias is ready!',
                    style: AppTheme.pageTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.screenBg,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _generatedNumber,
                          style: AppTheme.heading.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Purpose', style: AppTheme.bodySmall),
                            Text('Custom', style: AppTheme.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Plan', style: AppTheme.bodySmall),
                            Text(
                              'Free',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Go to Alias Manager',
                    onPressed: () {
                      final newAlias = AliasModel(
                        label: 'New Alias',
                        number: _generatedNumber,
                        status: AliasStatus.active,
                        category: AliasCategory.personal,
                        emoji: '\u{1F4F1}',
                        createdDate: DateTime.now(),
                        expiryDate:
                            DateTime.now().add(const Duration(days: 30)),
                        purpose: 'Custom',
                        plan: 'Free',
                        totalCalls: 0,
                        totalMessages: 0,
                        lastActivity: 'Just now',
                      );
                      ref.read(aliasProvider.notifier).addAlias(newAlias);
                      context.go('/home/alias');
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
