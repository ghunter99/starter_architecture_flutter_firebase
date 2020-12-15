// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppThemeDataExtension on String {
  // returns null if key is not found
  ThemeMode toThemeMode() => {
        'system': ThemeMode.system,
        'light': ThemeMode.light,
        'dark': ThemeMode.dark,
      }[this];
}

class AppThemeData {
  static const _lightFillColor = const Color.fromRGBO(51, 51, 51, 1.0);
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: colorScheme.brightness,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(color: colorScheme.onPrimary),
        ),
      ),

      /// The `displayColor` is applied to
      /// [headline4], [headline3], [headline2], [headline1], and [caption].
      /// The `bodyColor` is applied to the remaining text styles.
      textTheme: _textTheme.apply(
        displayColor: colorScheme.primary,
        bodyColor: colorScheme.onPrimary,
      ),
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.primary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.background,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
      ),
      dividerTheme: DividerThemeData(
          color: colorScheme.onSecondary.withOpacity(0.5), thickness: 1),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      cardColor: colorScheme.secondary,
      bottomAppBarColor: const Color.fromRGBO(
          58, 51, 69, 1), //const Color.fromRGBO(48, 41, 59, 1),
      textSelectionColor: colorScheme.primary,
      cursorColor: colorScheme.primary,
      textSelectionHandleColor: colorScheme.primary,
      toggleableActiveColor: colorScheme.primary,
      buttonColor: colorScheme.primary,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromRGBO(255, 131, 131, 1),
    primaryVariant: Color.fromRGBO(28, 222, 201, 1),
    secondary: Color.fromRGBO(239, 243, 243, 1),
    secondaryVariant: Color.fromRGBO(250, 251, 251, 1),
    background: Color.fromRGBO(230, 235, 235, 1),
    surface: Color.fromRGBO(250, 251, 251, 1),
    onBackground: Color.fromRGBO(74, 73, 78, 1), //Colors.white,
    error: _lightFillColor,
    onError: Colors.red,
    onPrimary: _lightFillColor,
    onSecondary: Colors.grey, //Color(0xFFEEEEEE)
    onSurface: Color.fromRGBO(36, 30, 48, 1),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromRGBO(255, 131, 131, 1),
    primaryVariant: Color.fromRGBO(28, 222, 201, 1),
    secondary: Color.fromRGBO(74, 73, 78, 1), //Color.fromRGBO(76, 31, 124, 1),
    secondaryVariant:
        Color.fromRGBO(43, 48, 52, 1), // Color.fromRGBO(69, 27, 111, 1),
    background:
        Color.fromRGBO(43, 48, 52, 1), // Color.fromRGBO(69, 27, 111, 1),
    surface: Color.fromRGBO(31, 25, 41, 1),
    onBackground: Color.fromRGBO(
        250, 251, 251, 1), //Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: Colors.yellow,
    onPrimary: _darkFillColor,
    onSecondary: Colors.grey, //Color(0xFFEEEEEE)
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static const _extraBold = FontWeight.w800;

  static final TextTheme _textTheme = TextTheme(
    //
    // displayColor is applied to these text themes
    //
    headline1: GoogleFonts.lato(fontWeight: _bold, fontSize: 48.0),
    headline2: GoogleFonts.balooTamma(fontWeight: _bold, fontSize: 36.0),
    headline3: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 21.0),
    headline4: GoogleFonts.lato(fontWeight: _regular, fontSize: 21.0),
    caption: GoogleFonts.lato(fontWeight: _medium, fontSize: 19.0),
    //
    // bodyColor is applied to these text themes
    //
    headline5: GoogleFonts.lato(fontWeight: _medium, fontSize: 19.0),
    // used by appBar title, dialog title
    headline6: GoogleFonts.balooTamma(fontWeight: _extraBold, fontSize: 19.0),
    // used by card title, dialog content, text form, chip label
    subtitle1: GoogleFonts.lato(fontWeight: _regular, fontSize: 17.0),
    subtitle2: GoogleFonts.lato(fontWeight: _medium, fontSize: 16.0),
    bodyText1: GoogleFonts.lato(fontWeight: _regular, fontSize: 17.0),
    // used by card subtitle
    bodyText2: GoogleFonts.lato(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 14.0),
    // used by button
    button: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 16.0),
  );
}
