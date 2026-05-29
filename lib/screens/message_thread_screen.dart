import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class MessageThreadScreen extends StatelessWidget {
  final String threadId;
  const MessageThreadScreen({super.key, required this.threadId});

  MessageThreadModel? get _thread {
    try {
      return MockData.messageThreads.firstWhere((t) => t.id == threadId);
    } catch (_) {
      return null;
    }
  }

  String _formatTimestamp(DateTime dt) {
    final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final suffix = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:${dt.minute.toString().padLeft(2, '0')} $suffix';
  }

  @override
  Widget build(BuildContext context) {
    final thread = _thread;

    if (thread == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text('Not Found', style: AppTheme.heading),
        ),
        body: Center(
          child: Text('Thread not found', style: AppTheme.bodySmall),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(thread.senderName, style: AppTheme.heading),
        backgroundColor: AppColors.screenBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Read-only banner
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'This conversation is read-only. Outbound SMS is not supported.',
                style: AppTheme.bodySmall,
              ),
            ),
          ),

          // Message bubbles
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: thread.messages.length,
              itemBuilder: (context, index) {
                final message = thread.messages[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.statPillBg,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message.text, style: AppTheme.body),
                            const SizedBox(height: 4),
                            Text(
                              _formatTimestamp(message.timestamp),
                              style: AppTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
