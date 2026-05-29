import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

class QuickStatsRibbon extends StatelessWidget {
  final List<StatItem> items;
  final bool isQuickStat;
  final Widget Function(int index, StatItem item)? itemBuilder;

  const QuickStatsRibbon({
    super.key,
    required this.items,
    this.isQuickStat = false,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(items.length * 2 - 1, (i) {
        if (i.isOdd) return const SizedBox(width: 8);
        final index = i ~/ 2;
        final item = items[index];

        if (itemBuilder != null) {
          return Expanded(child: itemBuilder!(index, item));
        }

        return Expanded(
          child: GlassCard(
            isQuickStat: isQuickStat,
            borderRadius: 14,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  item.value,
                  style: isQuickStat
                      ? AppTheme.statValue
                      : AppTheme.statValueDetail,
                ),
                const SizedBox(height: 4),
                Text(item.label, style: AppTheme.statLabel),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class StatItem {
  final String value;
  final String label;

  const StatItem({required this.value, required this.label});
}
