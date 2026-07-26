import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairos_app/app.dart';
import 'package:kairos_app/core/providers/shared_preferences_provider.dart';
import 'package:kairos_app/features/products/providers/product_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/fake_product_repository.dart';

void main() {
  testWidgets('completing onboarding navigates to the product list', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          productRepositoryProvider.overrideWithValue(FakeProductRepository()),
        ],
        child: const KairosApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Advance through all onboarding pages.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);

    // Onboarding completion should now be persisted.
    expect(prefs.getBool('onboarding_complete'), isTrue);
  });

  testWidgets('skip immediately navigates to the product list', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          productRepositoryProvider.overrideWithValue(FakeProductRepository()),
        ],
        child: const KairosApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);
  });
}
