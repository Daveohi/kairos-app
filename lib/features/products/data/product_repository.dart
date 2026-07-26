import 'dart:math';

import '../../../shared/models/product.dart';
import 'mock_products.dart';

/// Abstraction over the product data source so a real backend can be
/// swapped in later without touching providers or UI.
abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

/// Simulates a real network call: adds latency and a small chance of
/// failure so the UI's loading/error/retry states are exercised.
class MockProductRepository implements ProductRepository {
  MockProductRepository({this.failureRate = 0.1, Random? random})
    : _random = random ?? Random();

  final double failureRate;
  final Random _random;

  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (_random.nextDouble() < failureRate) {
      throw const ProductFetchException(
        'Could not reach the store. Please try again.',
      );
    }

    return List.unmodifiable(mockProducts);
  }
}

class ProductFetchException implements Exception {
  const ProductFetchException(this.message);

  final String message;

  @override
  String toString() => message;
}
