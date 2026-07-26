import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_providers.dart';

extension on ProductSort {
  String get label => switch (this) {
    ProductSort.relevance => 'Relevance',
    ProductSort.priceLowToHigh => 'Price: low to high',
    ProductSort.priceHighToLow => 'Price: high to low',
    ProductSort.name => 'Name',
  };
}

class SortMenu extends ConsumerWidget {
  const SortMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(productSortProvider);

    return PopupMenuButton<ProductSort>(
      initialValue: current,
      tooltip: 'Sort',
      onSelected: (value) => ref.read(productSortProvider.notifier).state = value,
      itemBuilder: (context) => ProductSort.values
          .map((sort) => PopupMenuItem(value: sort, child: Text(sort.label)))
          .toList(),
      icon: const Icon(Icons.sort),
    );
  }
}
