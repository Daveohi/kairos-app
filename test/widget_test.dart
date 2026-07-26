import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairos_app/app.dart';
import 'package:kairos_app/core/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('app boots to onboarding on first launch', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const KairosApp(),
      ),
    );
    // The onboarding hero image has a perpetual idle "bob" animation, so
    // pumpAndSettle (which waits for all animations to finish) would hang;
    // pump a fixed duration instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Same-day delivery'), findsOneWidget);
  });
}
