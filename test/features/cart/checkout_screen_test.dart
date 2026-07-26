import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairos_app/features/cart/presentation/screens/checkout_screen.dart';
import 'package:kairos_app/features/cart/providers/cart_provider.dart';
import 'package:kairos_app/features/products/data/mock_products.dart';

/// Pushes [CheckoutScreen] on top of a placeholder home route so that
/// popping back to the caller (as the real app does) is exercised too.
Widget _appWithCheckoutPushed() {
  return MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            ),
            child: const Text('Go to checkout'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('shows validation errors when submitting an empty form', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(cartProvider.notifier).add(mockProducts.first);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: CheckoutScreen()),
      ),
    );

    await tester.tap(find.text('Place order'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter a delivery address'), findsOneWidget);
    expect(find.text('Please enter a phone number'), findsOneWidget);
  });

  testWidgets('placing a valid order clears the cart', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(cartProvider.notifier).add(mockProducts.first);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _appWithCheckoutPushed(),
      ),
    );
    await tester.tap(find.text('Go to checkout'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Full name'), 'Ada Lovelace');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Delivery address'),
      '1 Analytical Engine Way',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone number'), '555-123-4567');

    await tester.tap(find.text('Place order'));
    await tester.pumpAndSettle();

    expect(find.text('Order placed!'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(container.read(cartItemsProvider), isEmpty);
    expect(find.text('Go to checkout'), findsOneWidget);
  });
}
