import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomSheetAction {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  const BottomSheetAction({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
  });
}

class BottomSheetMenu {
  static void show(BuildContext context, List<BottomSheetAction> actions) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.pillBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            ...actions.map((action) => _ActionRow(
                  action: action,
                  onTap: () {
                    Navigator.pop(context);
                    action.onTap?.call();
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final BottomSheetAction action;
  final VoidCallback? onTap;

  const _ActionRow({required this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = action.isDestructive ? AppColors.redText : AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(action.icon, size: 20, color: color),
            const SizedBox(width: 16),
            Text(
              action.label,
              style: AppTheme.body.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
