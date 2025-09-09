import 'package:flutter/material.dart';

LightCodeColors get appTheme => ThemeHelper.instance.themeColor();
ThemeData get theme => ThemeHelper.instance.themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // Singleton instance
  static final ThemeHelper _instance = ThemeHelper._internal();
  static ThemeHelper get instance => _instance;
  ThemeHelper._internal();
  
  // The current app theme
  var _appTheme = "lightCode";

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
  
  /// Change theme
  void changeTheme(String theme) {
    _appTheme = theme;
  }
  
  /// Get current theme colors
  LightCodeColors get themeColors => _getThemeColors();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

/// AppColors interface
abstract class AppColors {
  Color get primary;
  Color get secondary;
  Color get background;
  Color get surface;
  Color get error;
}

class LightCodeColors implements AppColors {
  // App Colors
  Color get blue_gray_400 => Color(0xFF8A8B8F);
  Color get white_A700 => Color(0xFFFFFFFF);
  Color get blue_gray_100 => Color(0xFFD0D1D3);
  Color get gray_800 => Color(0xFF45454E);
  Color get gray_900 => Color(0xFF161722);
  Color get blue_gray_900 => Color(0xFF3C0B43);
  Color get purple_A200 => Color(0xFFE220FD);
  Color get indigo_300 => Color(0xFF6987DE);
  Color get indigo_900 => Color(0xFF081E5F);
  Color get black_900 => Color(0xFF000000);
  Color get gray_900_01 => Color(0xFF1A1919);
  Color get gray_500 => Color(0xFFA1A2A5);

  // Additional Colors
  Color get transparentCustom => Colors.transparent;
  Color get whiteCustom => Colors.white;
  Color get greyCustom => Colors.grey;
  Color get blackCustom => Colors.black;
  Color get color990000 => Color(0x99000000);
  
  // AppColors interface implementation
  @override
  Color get primary => blue_gray_900;
  @override
  Color get secondary => purple_A200;
  @override
  Color get background => white_A700;
  @override
  Color get surface => white_A700;
  @override
  Color get error => Colors.red;

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
