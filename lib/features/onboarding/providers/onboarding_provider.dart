import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks whether the user has completed onboarding for this app session.
/// Intentionally not persisted — onboarding is shown every time the app is
/// launched or resumed, not just for first-time users.
class OnboardingController extends StateNotifier<bool> {
  OnboardingController() : super(false);

  void complete() => state = true;
}

final onboardingCompleteProvider =
    StateNotifierProvider<OnboardingController, bool>(
      (ref) => OnboardingController(),
    );
