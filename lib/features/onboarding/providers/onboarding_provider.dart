import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/shared_preferences_provider.dart';

/// Tracks whether the user has completed onboarding, persisted locally.
class OnboardingController extends StateNotifier<bool> {
  OnboardingController(this._ref)
    : super(
        _ref
            .read(sharedPreferencesProvider)
            .getBool(AppConstants.onboardingCompleteKey) ??
            false,
      );

  final Ref _ref;

  Future<void> complete() async {
    state = true;
    await _ref
        .read(sharedPreferencesProvider)
        .setBool(AppConstants.onboardingCompleteKey, true);
  }
}

final onboardingCompleteProvider =
    StateNotifierProvider<OnboardingController, bool>(
      (ref) => OnboardingController(ref),
    );
