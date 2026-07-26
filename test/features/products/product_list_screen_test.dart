import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairos_app/core/providers/shared_preferences_provider.dart';
import 'package:kairos_app/features/products/presentation/screens/product_list_screen.dart';
import 'package:kairos_app/features/products/providers/product_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/fake_product_repository.dart';

Widget _wrap(Widget child, {required ProviderContainer container}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(home: child),
  );
}

void main() {
  testWidgets('searching filters the visible products', (tester) async {
    // The redesigned home screen has a taller header (greeting, search,
    // promo carousel, categories) above the product grid, so a larger
    // surface is needed for enough grid rows to be built/visible.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        productRepositoryProvider.overrideWithValue(FakeProductRepository()),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      _wrap(const ProductListScreen(), container: container),
    );
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);
    expect(find.text('Mido Multifort Automatic'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'mido');
    await tester.pumpAndSettle();

    expect(find.text('Mido Multifort Automatic'), findsOneWidget);
    expect(find.text('Apple Watch Series 2'), findsNothing);
  });

  testWidgets('shows an error state with retry on fetch failure', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        productRepositoryProvider.overrideWithValue(
          FakeProductRepository(shouldFail: true),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      _wrap(const ProductListScreen(), container: container),
    );
    await tester.pumpAndSettle();

    expect(find.text('Could not reach the store.'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Retry'), findsOneWidget);
  });
}
