import 'package:kairos_app/features/products/data/mock_products.dart';
import 'package:kairos_app/features/products/data/product_repository.dart';
import 'package:kairos_app/shared/models/product.dart';

/// Deterministic stand-in for [MockProductRepository] so widget tests are
/// not flaky and don't depend on real network-like delays.
class FakeProductRepository implements ProductRepository {
  FakeProductRepository({this.shouldFail = false});

  final bool shouldFail;

  @override
  Future<List<Product>> fetchProducts() async {
    if (shouldFail) {
      throw const ProductFetchException('Could not reach the store.');
    }
    return mockProducts;
  }
}
