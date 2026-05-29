import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/gradient_background.dart';
import '../widgets/message_row.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final threads = MockData.messageThreads;

    return GradientBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Text('Ciphering...', style: AppTheme.wordmark),
                  const Spacer(),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.notifBtnBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      size: 18,
                      color: AppColors.purplePrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.profileGradient,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Page header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Messages', style: AppTheme.pageTitle),
                  const SizedBox(height: 4),
                  Text(
                    'SMS received on your aliases',
                    style: AppTheme.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.inputBg,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  border: Border.all(color: AppColors.inputBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search messages',
                      style: AppTheme.bodySmall
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Message threads list
            Expanded(
              child: Column(
                children: [
                  // Thread list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: threads
                          .map(
                            (thread) => MessageRow(
                              thread: thread,
                              onTap: () => context
                                  .go('/home/messages/${thread.id}'),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  // Read-only notice in remaining space
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.message_outlined,
                            size: 32,
                            color: Color(0xFFCBD5E1),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Messages are read-only.\nOutbound SMS is not supported.',
                            style: AppTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
