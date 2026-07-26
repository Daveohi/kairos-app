import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/currency.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryRow(label: 'Subtotal', value: subtotal),
        _SummaryRow(
          label: 'Delivery fee',
          value: deliveryFee,
          isFree: deliveryFee == 0,
        ),
        const Divider(height: AppSpacing.lg),
        _SummaryRow(label: 'Total', value: total, emphasize: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.isFree = false,
  });

  final String label;
  final double value;
  final bool emphasize;
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: emphasize ? FontWeight.bold : FontWeight.normal,
      fontSize: emphasize ? 18 : 14,
      color: emphasize ? AppColors.textPrimary : AppColors.textSecondary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(isFree ? 'Free' : formatNaira(value), style: style),
        ],
      ),
    );
  }
}
