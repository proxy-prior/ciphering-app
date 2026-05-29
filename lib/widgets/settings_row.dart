import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum SettingsRowTrailing { chevron, toggle, lock }

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String subtitle;
  final SettingsRowTrailing trailing;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;
  final bool isLocked;
  final bool showDivider;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    this.trailing = SettingsRowTrailing.chevron,
    this.toggleValue = false,
    this.onToggleChanged,
    this.onTap,
    this.isLocked = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isLocked ? 0.45 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: showDivider
              ? const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                )
              : null,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTheme.settingTitle),
                    const SizedBox(height: 1),
                    Text(subtitle, style: AppTheme.settingDesc),
                  ],
                ),
              ),
              _buildTrailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    switch (trailing) {
      case SettingsRowTrailing.chevron:
        return const Icon(Icons.chevron_right, size: 16, color: AppColors.textQuaternary);
      case SettingsRowTrailing.lock:
        return const Icon(Icons.lock_outline, size: 16, color: AppColors.textQuaternary);
      case SettingsRowTrailing.toggle:
        return _Toggle(value: toggleValue, onChanged: onToggleChanged);
    }
  }
}

class _Toggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _Toggle({required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: Container(
        width: 44,
        height: 26,
        decoration: BoxDecoration(
          color: value ? AppColors.green : AppColors.pillBorder,
          borderRadius: BorderRadius.circular(13),
        ),
        child: AnimatedAlign(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
