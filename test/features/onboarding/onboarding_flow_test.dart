import 'package:flutter/material.dart';
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
    // The onboarding hero image has a perpetual idle "bob" animation, so
    // pumpAndSettle (which waits for all animations to finish) would hang;
    // pump fixed durations instead while onboarding is on screen.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    // Advance through all onboarding pages.
    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    // Let the Next/Get Started button's crossfade finish settling too.
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Get Started'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);
  });

  testWidgets('onboarding shows again after restarting the app', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    Widget buildApp() => ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        productRepositoryProvider.overrideWithValue(FakeProductRepository()),
      ],
      child: const KairosApp(),
    );

    await tester.pumpWidget(buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);

    // Simulate an app restart with a brand new provider/widget tree —
    // onboarding is session-only, so it should show again, not be skipped
    // because a previous session completed it.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Same-day delivery'), findsOneWidget);
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
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Apple Watch Series 2'), findsOneWidget);
  });
}
