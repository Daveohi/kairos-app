import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../providers/product_providers.dart';

const _categoryIcons = <String, IconData>{
  'Smartwatch': Icons.watch_rounded,
  'Analog': Icons.watch_outlined,
  'Digital': Icons.fitness_center_rounded,
};

const _fallbackIcon = Icons.shopping_bag_rounded;

/// Horizontal row of circular category icon buttons, standing in for the
/// text chip filter in a look closer to the reference design. Still backed
/// by [selectedCategoryProvider].
class CategoryIconRow extends ConsumerWidget {
  const CategoryIconRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          _CategoryIcon(
            label: 'All',
            icon: Icons.apps_rounded,
            selected: selected == null,
            onTap: () => ref.read(selectedCategoryProvider.notifier).state = null,
          ),
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.sm),
              child: _CategoryIcon(
                label: category,
                icon: _categoryIcons[category] ?? _fallbackIcon,
                selected: selected == category,
                onTap: () =>
                    ref.read(selectedCategoryProvider.notifier).state = category,
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : scheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: selected
                    ? null
                    : Border.all(color: scheme.outlineVariant),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
