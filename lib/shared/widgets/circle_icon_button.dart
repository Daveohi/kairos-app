import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// A circular icon button with a light bordered background, used for
/// back arrows, header actions (menu, search, theme toggle), and the
/// favorite/heart affordance on product cards.
///
/// [size] is the tappable hit area and defaults to 48 — the minimum
/// recommended touch target — while [visualSize] (defaults to [size])
/// controls how large the painted circle/icon actually looks, so a
/// compact visual footprint (e.g. a small corner badge) can still keep
/// a full-size tap target.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.visualSize,
    this.filled = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double? visualSize;
  final bool filled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final circleSize = visualSize ?? size;

    final button = Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                color: filled ? AppColors.primary : scheme.surface,
                shape: BoxShape.circle,
                border: filled
                    ? null
                    : Border.all(color: scheme.outlineVariant),
              ),
              child: Icon(
                icon,
                size: circleSize * 0.5,
                color: filled ? Colors.white : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
