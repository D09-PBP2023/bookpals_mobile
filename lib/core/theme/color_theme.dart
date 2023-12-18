import 'package:flutter/material.dart';

class ColorTheme {
  static const int _primaryValue = 0xFFBBAEA8;

  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFF54B7FF),
      100: Color(0xFF51B0F5),
      200: Color(0xFF4FACF0),
      300: Color(0xFF4EA8EB),
      400: Color(0xFF4CA5E6),
      500: Color(_primaryValue),
      600: Color(0xFF479AD6),
      700: Color(0xFF4391C9),
      800: Color(0xFF3E87BD),
      900: Color(0xFF3A7EB0),
    },
  );

  static const _accentValue = 0xFFf6e27f;

  static const MaterialColor accentSwatch = MaterialColor(
    _accentValue,
    <int, Color>{
      // create color shade with 50 the lightiest and 900 the darkest

      500: Color(_accentValue),
    },
  );

  static const Color morningDew = Color(0xFFF0EFE6);
  static const Color overcast = Color(0xFFEAEAEA);
  static const Color earlyDusk = Color(0xFFC6C9D2);
  static const Color tanParchment = Color(0xFFDCCFC1);
  static const Color almondDust = Color(0xFFB8AEA8);
  static const Color coffeeGrounds = Color(0xFF393831);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color red = Color(0xFFed6a5a);
}
