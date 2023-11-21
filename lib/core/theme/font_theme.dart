import 'package:flutter/material.dart';

import 'color_theme.dart';

class FontTheme {
  static const fontFamily = 'Poppins';

  static const white = TextStyle(color: ColorTheme.white);

  static const black = TextStyle(color: ColorTheme.black);

  static const greySecondary = TextStyle(color: ColorTheme.grey);

  static TextStyle whiteTitle() {
    return const TextStyle(
      color: ColorTheme.white,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle whiteSubtitle() {
    return const TextStyle(
      color: ColorTheme.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle whiteCaption() {
    return const TextStyle(
      color: ColorTheme.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle whiteCaptionBold() {
    return const TextStyle(
      color: ColorTheme.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  // Black
  static TextStyle blackTitle() {
    return const TextStyle(
      color: ColorTheme.black,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle blackSubtitle() {
    return const TextStyle(
      color: ColorTheme.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle blackCaption() {
    return const TextStyle(
      color: ColorTheme.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle blackCaptionBold() {
    return const TextStyle(
      color: ColorTheme.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  // static TextStyle whiteCaptionLink() {
  //   return const TextStyle(
  //     color: ColorTheme.purple,
  //     fontSize: 14,
  //     fontWeight: FontWeight.w600,
  //   );
  // }

  // Red
  static TextStyle redSubtitle() {
    return const TextStyle(
      color: ColorTheme.red,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle redCaptionBold() {
    return const TextStyle(
      color: ColorTheme.red,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }
}
