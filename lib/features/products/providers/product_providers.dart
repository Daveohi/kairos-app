import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/product.dart';
import '../data/mock_products.dart';
import '../data/product_repository.dart';

enum ProductSort { relevance, priceLowToHigh, priceHighToLow, name }

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return MockProductRepository();
});

/// Holds the fetched product catalog. A plain [AsyncNotifier] (rather than
/// a bare [FutureProvider]) so the UI can trigger an explicit retry/refresh.
class ProductListNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    return ref.read(productRepositoryProvider).fetchProducts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Product>>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () => ref.read(productRepositoryProvider).fetchProducts(),
    );
  }
}

final productListProvider =
    AsyncNotifierProvider<ProductListNotifier, List<Product>>(
      ProductListNotifier.new,
    );

final searchQueryProvider = StateProvider<String>((ref) => '');
final productSortProvider = StateProvider<ProductSort>(
  (ref) => ProductSort.relevance,
);

final categoriesProvider = Provider<List<String>>((ref) {
  final categories = mockProducts.map((p) => p.category).toSet().toList()
    ..sort();
  return categories;
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Applies the current search, category and sort selections to the fetched
/// product list.
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final products = ref.watch(productListProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final category = ref.watch(selectedCategoryProvider);
  final sort = ref.watch(productSortProvider);

  return products.whenData((items) {
    var result = items.where((product) {
      final matchesQuery =
          query.isEmpty || product.name.toLowerCase().contains(query);
      final matchesCategory = category == null || product.category == category;
      return matchesQuery && matchesCategory;
    }).toList();

    switch (sort) {
      case ProductSort.relevance:
        break;
      case ProductSort.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.name:
        result.sort((a, b) => a.name.compareTo(b.name));
    }

    return result;
  });
});
