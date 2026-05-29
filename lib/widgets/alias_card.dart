import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import 'glass_card.dart';
import 'status_badge.dart';
import 'stat_pill.dart';

class AliasCard extends StatelessWidget {
  final AliasModel alias;
  final VoidCallback? onTap;

  const AliasCard({super.key, required this.alias, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: MockData.categoryTint(alias.category),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(alias.emoji, style: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alias.label, style: AppTheme.cardName),
                    const SizedBox(height: 2),
                    Text(alias.number, style: AppTheme.cardNumber),
                  ],
                ),
              ),
              StatusBadge.fromAliasStatus(alias.status),
            ],
          ),
          if (alias.totalCalls > 0 || alias.totalMessages > 0 || alias.lastActivity != null) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  if (alias.totalCalls > 0) StatPill(text: '${alias.totalCalls} calls'),
                  if (alias.totalMessages > 0) StatPill(text: '${alias.totalMessages} msgs'),
                  if (alias.lastActivity != null) StatPill(text: alias.lastActivity!),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
