import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_helper.dart';

/// Theme Provider để manage theme switching
class ThemeNotifier extends StateNotifier<String> {
  ThemeNotifier() : super('light');

  /// Toggle between light and dark theme
  void toggleTheme() {
    final newTheme = state == 'light' ? 'dark' : 'light';
    state = newTheme;
    ThemeHelper.instance.changeTheme(newTheme);
  }

  /// Set specific theme
  void setTheme(String theme) {
    if (theme == 'light' || theme == 'dark') {
      state = theme;
      ThemeHelper.instance.changeTheme(theme);
    }
  }

  /// Get current theme colors
  AppColors get currentColors => ThemeHelper.instance.themeColors;
}

/// Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, String>((ref) {
  return ThemeNotifier();
});

/// Is dark mode provider (shortcut)
final isDarkModeThemeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider) == 'dark';
});

/// Current theme colors provider
final themeColorsProvider = Provider<AppColors>((ref) {
  ref.watch(themeProvider); // Listen to theme changes
  return ThemeHelper.instance.themeColors;
});
