import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title16 => TextStyle(
        fontSize: 16.fSize,
        color: appTheme.greyCustom,
      );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label10Regular => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );

  TextStyle get label10RegularRambla => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Rambla',
      );

  TextStyle get label8RegularABeeZee => TextStyle(
        fontSize: 8.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.blackCustom,
      );
}
