import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../shared/models/cart_item.dart';
import '../../../shared/models/product.dart';

class CartController extends StateNotifier<Map<String, CartItem>> {
  CartController() : super(const {});

  void add(Product product) {
    final existing = state[product.id];
    state = {
      ...state,
      product.id: existing == null
          ? CartItem(product: product, quantity: 1)
          : existing.copyWith(quantity: existing.quantity + 1),
    };
  }

  void increment(String productId) {
    final existing = state[productId];
    if (existing == null) return;
    state = {
      ...state,
      productId: existing.copyWith(quantity: existing.quantity + 1),
    };
  }

  void decrement(String productId) {
    final existing = state[productId];
    if (existing == null) return;
    if (existing.quantity <= 1) {
      remove(productId);
      return;
    }
    state = {
      ...state,
      productId: existing.copyWith(quantity: existing.quantity - 1),
    };
  }

  void remove(String productId) {
    final next = {...state}..remove(productId);
    state = next;
  }

  void clear() => state = const {};
}

final cartProvider =
    StateNotifierProvider<CartController, Map<String, CartItem>>(
      (ref) => CartController(),
    );

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  return ref.watch(cartProvider).values.toList();
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartItemsProvider).fold(0, (sum, item) => sum + item.quantity);
});

final cartSubtotalProvider = Provider<double>((ref) {
  return ref
      .watch(cartItemsProvider)
      .fold(0.0, (sum, item) => sum + item.subtotal);
});

final cartDeliveryFeeProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  if (subtotal == 0 || subtotal >= AppConstants.freeDeliveryThreshold) {
    return 0;
  }
  return AppConstants.deliveryFee;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartSubtotalProvider) + ref.watch(cartDeliveryFeeProvider);
});
