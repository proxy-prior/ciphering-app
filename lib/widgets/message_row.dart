import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class MessageRow extends StatelessWidget {
  final MessageThreadModel thread;
  final VoidCallback? onTap;

  const MessageRow({super.key, required this.thread, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.activeBadgeBg,
                borderRadius: BorderRadius.circular(AppRadius.rowIcon),
              ),
              child: const Icon(Icons.message_outlined, size: 18, color: AppColors.activeColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(thread.senderName, style: AppTheme.body.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 1),
                  Text(
                    thread.lastMessage,
                    style: AppTheme.bodySmall.copyWith(fontSize: 12, color: AppColors.textTertiary),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_formatTime(thread.timestamp), style: AppTheme.bodySmall.copyWith(fontSize: 12)),
                if (thread.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 18, height: 18,
                    decoration: const BoxDecoration(color: AppColors.activeColor, shape: BoxShape.circle),
                    child: Center(
                      child: Text('${thread.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      return '$h:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${dt.day}/${dt.month}';
    }
  }
}
