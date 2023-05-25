import 'package:flutter/material.dart';

class Styles {
  // 'const' specifies compile-time immutability, whereas 'final' specifies run-time immutability.
  // We need 'final' in the second line because `.shade700` apparently calls a method under the hood.
  static const double _textSizeDefault = 16.0;
  static const double _textSizeLarge = 25.0;
  static const double ListItemHeight = 350.0;
  static const double LocationTileHeight = 110;
  static const String _fontNameDefualt = 'Oswald';
  static const double HorizontalPaddingDefault = 12.0;
  static const Color _textColorBright = Colors.white;
  static const Color _textColorStrong = Colors.black;
  static final Color _accentColor = Colors.red.shade500;

  static const headerLarge = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeLarge,
      color: Colors.black);
  static final textDefault = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeDefault,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: _hexColor('555555'));
  static const locationTileTitleLight = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeLarge,
      color: _textColorStrong);
  static const locationTileTitleDark = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeLarge,
      color: _textColorBright);
  static final locationTileSubtitle = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeLarge,
      color: _accentColor);
  static const locationTileLocation = TextStyle(
      fontFamily: _fontNameDefualt,
      fontSize: _textSizeDefault,
      color: _textColorBright);

  static final navBarStyle =
      TextStyle(fontFamily: _fontNameDefualt, fontSize: _textSizeLarge);

  static Color _hexColor(String hexCode) {
    return Color(int.parse(hexCode.substring(0, 6), radix: 16) * 0xFF000000);
  }
}
