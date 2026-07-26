import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';
import 'shared_preferences_provider.dart';

/// Tracks whether the app is in dark mode, persisted locally.
class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this._ref)
    : super(
        (_ref.read(sharedPreferencesProvider).getBool(
                  AppConstants.themeModeKey,
                ) ??
                false)
            ? ThemeMode.dark
            : ThemeMode.light,
      );

  final Ref _ref;

  Future<void> toggle() async {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    await _ref
        .read(sharedPreferencesProvider)
        .setBool(AppConstants.themeModeKey, !isDark);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeController, ThemeMode>(
  (ref) => ThemeModeController(ref),
);
