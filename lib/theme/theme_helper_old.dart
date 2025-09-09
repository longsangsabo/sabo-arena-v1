import 'package:flutter/material.dart';

AppColors get appTheme => ThemeHelper().themeColor();
ThemeData get lightTheme => ThemeHelper().lightThemeData();
ThemeData get darkTheme => ThemeHelper().darkThemeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = "light";

  /// Change the app theme
  void changeTheme(String newTheme) {
    if (_supportedCustomColor.containsKey(newTheme)) {
      _appTheme = newTheme;
    }
  }

  /// Get current theme name
  String get currentTheme => _appTheme;

  // A map of custom color themes supported by the app
  Map<String, AppColors> _supportedCustomColor = {
    'light': LightColors(),
    'dark': DarkColors(),
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'light': ColorSchemes.lightColorScheme,
    'dark': ColorSchemes.darkColorScheme,
  };

  /// Returns the colors for the current theme.
  AppColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightColors();
  }

  /// Returns the light theme data.
  ThemeData _getLightThemeData() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      colorScheme: ColorSchemes.lightColorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarTheme(
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: Color(0xFF161722),
        unselectedItemColor: Color(0xFF8A8B8F),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF161722),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  /// Returns the dark theme data.
  ThemeData _getDarkThemeData() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      colorScheme: ColorSchemes.darkColorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 8,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF8A8B8F),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  /// Returns the colors for the current theme.
  AppColors themeColor() => _getThemeColors();

  /// Returns the light theme data.
  ThemeData lightThemeData() => _getLightThemeData();

  /// Returns the dark theme data.
  ThemeData darkThemeData() => _getDarkThemeData();
}

class ColorSchemes {
  static final lightColorScheme = ColorScheme.light(
    primary: const Color(0xFF161722),
    secondary: const Color(0xFF6987DE),
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  );

  static final darkColorScheme = ColorScheme.dark(
    primary: Colors.white,
    secondary: const Color(0xFFE220FD),
    surface: const Color(0xFF1E1E1E),
    background: const Color(0xFF121212),
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
  );
}

/// Base class for app colors
abstract class AppColors {
  // Core colors
  Color get primary;
  Color get secondary;
  Color get surface;
  Color get background;
  Color get onPrimary;
  Color get onSecondary;
  Color get onSurface;
  Color get onBackground;
  
  // Navigation colors
  Color get navSelected;
  Color get navUnselected;
  Color get navBackground;
  
  // Text colors
  Color get textPrimary;
  Color get textSecondary;
  Color get textMuted;
  
  // Legacy colors for backward compatibility
  Color get blue_gray_400 => const Color(0xFF8A8B8F);
  Color get white_A700 => const Color(0xFFFFFFFF);
  Color get blue_gray_100 => const Color(0xFFD0D1D3);
  Color get gray_800 => const Color(0xFF45454E);
  Color get gray_900 => const Color(0xFF161722);
  Color get blue_gray_900 => const Color(0xFF3C0B43);
  Color get purple_A200 => const Color(0xFFE220FD);
  Color get indigo_300 => const Color(0xFF6987DE);
  Color get indigo_900 => const Color(0xFF081E5F);
  Color get black_900 => const Color(0xFF000000);
  Color get gray_900_01 => const Color(0xFF1A1919);
  Color get gray_500 => const Color(0xFFA1A2A5);
  Color get transparentCustom => Colors.transparent;
  Color get whiteCustom => Colors.white;
  Color get greyCustom => Colors.grey;
  Color get blackCustom => Colors.black;
  Color get color990000 => const Color(0x99000000);
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}

/// Light theme colors
class LightColors extends AppColors {
  @override
  Color get primary => const Color(0xFF161722);
  
  @override
  Color get secondary => const Color(0xFF6987DE);
  
  @override
  Color get surface => Colors.white;
  
  @override
  Color get background => Colors.white;
  
  @override
  Color get onPrimary => Colors.white;
  
  @override
  Color get onSecondary => Colors.white;
  
  @override
  Color get onSurface => Colors.black;
  
  @override
  Color get onBackground => Colors.black;
  
  @override
  Color get navSelected => const Color(0xFF161722);
  
  @override
  Color get navUnselected => const Color(0xFF8A8B8F);
  
  @override
  Color get navBackground => Colors.white;
  
  @override
  Color get textPrimary => Colors.black;
  
  @override
  Color get textSecondary => const Color(0xFF161722);
  
  @override
  Color get textMuted => const Color(0xFFA1A2A5);
}

/// Dark theme colors
class DarkColors extends AppColors {
  @override
  Color get primary => Colors.white;
  
  @override
  Color get secondary => const Color(0xFFE220FD);
  
  @override
  Color get surface => const Color(0xFF1E1E1E);
  
  @override
  Color get background => const Color(0xFF121212);
  
  @override
  Color get onPrimary => Colors.black;
  
  @override
  Color get onSecondary => Colors.black;
  
  @override
  Color get onSurface => Colors.white;
  
  @override
  Color get onBackground => Colors.white;
  
  @override
  Color get navSelected => Colors.white;
  
  @override
  Color get navUnselected => const Color(0xFF8A8B8F);
  
  @override
  Color get navBackground => const Color(0xFF1E1E1E);
  
  @override
  Color get textPrimary => Colors.white;
  
  @override
  Color get textSecondary => Colors.white;
  
  @override
  Color get textMuted => const Color(0xFF8A8B8F);
}
