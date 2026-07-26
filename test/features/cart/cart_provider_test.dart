import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairos_app/core/constants/app_constants.dart';
import 'package:kairos_app/features/cart/providers/cart_provider.dart';
import 'package:kairos_app/features/products/data/mock_products.dart';

void main() {
  late ProviderContainer container;
  final product = mockProducts.first;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('adding the same product twice increments its quantity', () {
    final cart = container.read(cartProvider.notifier);
    cart.add(product);
    cart.add(product);

    final items = container.read(cartItemsProvider);
    expect(items.length, 1);
    expect(items.first.quantity, 2);
    expect(container.read(cartItemCountProvider), 2);
  });

  test('decrementing to zero removes the item', () {
    final cart = container.read(cartProvider.notifier);
    cart.add(product);
    cart.decrement(product.id);

    expect(container.read(cartItemsProvider), isEmpty);
  });

  test('delivery fee is waived above the free-delivery threshold', () {
    final cart = container.read(cartProvider.notifier);
    final expensiveProduct = product;
    final quantityNeeded =
        (AppConstants.freeDeliveryThreshold / expensiveProduct.price).ceil();

    for (var i = 0; i < quantityNeeded; i++) {
      cart.add(expensiveProduct);
    }

    expect(container.read(cartSubtotalProvider), greaterThanOrEqualTo(AppConstants.freeDeliveryThreshold));
    expect(container.read(cartDeliveryFeeProvider), 0);
    expect(container.read(cartTotalProvider), container.read(cartSubtotalProvider));
  });

  test('delivery fee applies below the free-delivery threshold', () {
    final cart = container.read(cartProvider.notifier);
    cart.add(product);

    expect(container.read(cartSubtotalProvider), lessThan(AppConstants.freeDeliveryThreshold));
    expect(container.read(cartDeliveryFeeProvider), AppConstants.deliveryFee);
  });
}
