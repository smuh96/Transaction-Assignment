import 'package:flutter/material.dart';

class Style{
  static const Color pPrimaryColor = Color(0xff602277);
  static const Color pMedColor = Color(0xffbe59e3);
  static const Color pSecondaryColor = Color(0xffe094fc);
  static const Color pContentColorLightTheme = Color(0xFF1D1D35);
  static const Color pContentColorDarkTheme = Color(0xFFF1E3F6);
  static const Color pWarningColor = Color(0xFFF3BB1C);
  static const Color pSuccessColor = Color(0xFF388E3C);
  static const Color pErrorColor = Color(0xFFE53935);
  static const Color pWhiteColor = Color(0xFFFFFFFF);

  static const String fontName = 'WorkSans';

  static const TextStyle italicWhiteHeading = TextStyle(
    fontFamily: fontName,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.27,
    color: pWhiteColor,
  );

  static const TextStyle captionWhite = TextStyle(
    fontFamily: fontName,
    fontSize: 14,
    letterSpacing: 0.2,
    color: pWhiteColor, // was lightText
  );

  static const TextStyle headingStyle1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.27,
    color: Style.pContentColorLightTheme,
  );

  static const TextStyle greenHeadingStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.27,
    color: Style.pSuccessColor,
  );

  static const TextStyle redHeadingStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.27,
    color: Style.pErrorColor,
  );

  static const TextStyle textStyle1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.27,
    color: Colors.black38,
  );

  static const TextStyle textStyle2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.27,
    color: Style.pContentColorLightTheme,
  );

  static ThemeData buildLightTheme() {
    final Color primaryColor = pPrimaryColor;
    final Color secondaryColor = pSecondaryColor;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        colorScheme: colorScheme,
        primaryColor: primaryColor,
        buttonColor: primaryColor,
        brightness: Brightness.dark,
        indicatorColor: Colors.white,
        splashColor: Colors.white24,
        splashFactory: InkRipple.splashFactory,
        accentColor: secondaryColor,
        canvasColor: Colors.white,
        backgroundColor: const Color(0xFFFFFFFF),
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        errorColor: const Color(0xFFB00020),
        buttonTheme: ButtonThemeData(
          colorScheme: colorScheme,
          textTheme: ButtonTextTheme.primary,
        )
    );
  }
}