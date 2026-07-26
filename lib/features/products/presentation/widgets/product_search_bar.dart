import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_providers.dart';

class ProductSearchBar extends ConsumerWidget {
  const ProductSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
      decoration: const InputDecoration(
        hintText: 'Search products',
        prefixIcon: Icon(Icons.search),
        isDense: true,
      ),
    );
  }
}
