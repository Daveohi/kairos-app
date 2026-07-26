import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/product.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../../../../shared/widgets/currency.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/rating_stars.dart';
import '../../../cart/providers/cart_provider.dart';

/// Product detail screen. The color-swatch and size selectors are
/// decorative — the catalog has no real color/size variant data — while
/// rating, price, About, and Add to cart are fully functional.
class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _selectedSwatch = 0;
  int _selectedSize = 2;

  static const _sizes = ['35', '36', '37', '38', '39', '40'];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final swatches = [product.color, AppColors.textPrimary, Colors.white];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleIconButton(
                          icon: Icons.arrow_back_rounded,
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            height: 260,
                            width: double.infinity,
                            color: product.color.withValues(alpha: 0.18),
                            child: Image.asset(product.imagePath, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          right: AppSpacing.sm,
                          top: AppSpacing.sm,
                          child: Column(
                            children: [
                              for (var i = 0; i < swatches.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                                  child: _SwatchDot(
                                    color: swatches[i],
                                    selected: _selectedSwatch == i,
                                    onTap: () => setState(() => _selectedSwatch = i),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: AppSpacing.sm,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var i = 0; i < 3; i++)
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: i == 1
                                        ? AppColors.primary
                                        : AppColors.textSecondary.withValues(
                                            alpha: 0.4,
                                          ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      product.name,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    RatingStars(rating: product.rating),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Text(
                          formatNaira(product.price),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.originalPrice != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            formatNaira(product.originalPrice!),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                        const Spacer(),
                        const Text(
                          'Available in stock',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'About',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      product.description.isEmpty
                          ? '${product.name} — ${product.unit}, ${product.category}.'
                          : product.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        for (var i = 0; i < _sizes.length; i++)
                          _SizeChip(
                            label: _sizes[i],
                            selected: _selectedSize == i,
                            onTap: () => setState(() => _selectedSize = i),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: PrimaryButton(
                label: 'Add to cart',
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwatchDot extends StatelessWidget {
  const _SwatchDot({required this.color, required this.selected, required this.onTap});

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primary : Colors.white,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: selected
            ? Icon(
                Icons.check,
                size: 14,
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              )
            : null,
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.12) : scheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : scheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
