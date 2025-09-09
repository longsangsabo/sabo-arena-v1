import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App state class để quản lý trạng thái toàn app
class AppState {
  final bool isDarkMode;
  final Locale locale;
  final bool isFirstLaunch;
  final String? userToken;

  const AppState({
    this.isDarkMode = false,
    this.locale = const Locale('vi', 'VN'),
    this.isFirstLaunch = true,
    this.userToken,
  });

  AppState copyWith({
    bool? isDarkMode,
    Locale? locale,
    bool? isFirstLaunch,
    String? userToken,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      userToken: userToken ?? this.userToken,
    );
  }
}

/// App State Notifier
class AppNotifier extends StateNotifier<AppState> {
  late SharedPreferences _prefs;

  AppNotifier() : super(const AppState()) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  void _loadSettings() {
    final isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    final languageCode = _prefs.getString('languageCode') ?? 'vi';
    final countryCode = _prefs.getString('countryCode') ?? 'VN';
    final isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? true;
    final userToken = _prefs.getString('userToken');

    state = state.copyWith(
      isDarkMode: isDarkMode,
      locale: Locale(languageCode, countryCode),
      isFirstLaunch: isFirstLaunch,
      userToken: userToken,
    );
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode() async {
    final newValue = !state.isDarkMode;
    await _prefs.setBool('isDarkMode', newValue);
    state = state.copyWith(isDarkMode: newValue);
  }

  /// Change language
  Future<void> changeLanguage(Locale locale) async {
    await _prefs.setString('languageCode', locale.languageCode);
    await _prefs.setString('countryCode', locale.countryCode ?? '');
    state = state.copyWith(locale: locale);
  }

  /// Set first launch completed
  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool('isFirstLaunch', false);
    state = state.copyWith(isFirstLaunch: false);
  }

  /// Set user token (login)
  Future<void> setUserToken(String token) async {
    await _prefs.setString('userToken', token);
    state = state.copyWith(userToken: token);
  }

  /// Clear user token (logout)
  Future<void> clearUserToken() async {
    await _prefs.remove('userToken');
    state = state.copyWith(userToken: null);
  }
}

/// App Provider
final appProvider = StateNotifierProvider<AppNotifier, AppState>((ref) {
  return AppNotifier();
});

/// Individual providers for common use cases
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).isDarkMode;
});

final currentLocaleProvider = Provider<Locale>((ref) {
  return ref.watch(appProvider).locale;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).userToken != null;
});

final isFirstLaunchProvider = Provider<bool>((ref) {
  return ref.watch(appProvider).isFirstLaunch;
});
