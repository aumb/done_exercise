import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static final light = ThemeData(
    hintColor: CustomColors.hintColor,
    scaffoldBackgroundColor: Colors.white,
    dividerColor: CustomColors.dividerColor,
    accentColor: CustomColors.accentColor,
    primarySwatch: const MaterialColor(0xFF6734C7, CustomColors.primaryColor),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            width: 1,
            color: CustomColors.elevatedButtonBorder,
          ),
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        button: CustomTextTheme.mediumSemiblod,
        overline: CustomTextTheme.regular,
        bodyText2: CustomTextTheme.mediumSemiblod,
        bodyText1: CustomTextTheme.smallRegular,
        subtitle2: CustomTextTheme.mediumRegular,
        subtitle1: CustomTextTheme.smallSemiBold,
        headline6: CustomTextTheme.largeRegular,
        headline5: CustomTextTheme.largeSemiBold,
        headline4: CustomTextTheme.headlineSmall,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            width: 1,
            color: CustomColors.border,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: CustomTextTheme.smallSemiBold,
      contentPadding: const EdgeInsets.all(16).copyWith(bottom: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: CustomColors.border,
        ),
      ),
    ),
  );
}

class CustomTextTheme {
  static const mediumSemiblod = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: Colors.black,
  );
  static const headlineSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: Colors.black,
  );
  static const regular = TextStyle(
    fontSize: 15,
    letterSpacing: 1,
    color: Colors.black,
  );
  static const smallRegular = TextStyle(
    fontSize: 13,
    color: Colors.black,
  );
  static const mediumRegular = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  static const smallSemiBold = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const largeRegular = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );
  static const largeSemiBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

class CustomColors {
  static const primaryColor = {
    50: Color.fromRGBO(103, 52, 199, .1),
    100: Color.fromRGBO(103, 52, 199, .2),
    200: Color.fromRGBO(103, 52, 199, .3),
    300: Color.fromRGBO(103, 52, 199, .4),
    400: Color.fromRGBO(103, 52, 199, .5),
    500: Color.fromRGBO(103, 52, 199, .6),
    600: Color.fromRGBO(103, 52, 199, .7),
    700: Color.fromRGBO(103, 52, 199, .8),
    800: Color.fromRGBO(103, 52, 199, .9),
    900: Color.fromRGBO(103, 52, 199, 1),
  };

  static const dividerColor = Color(0xFFF1F1F1);
  static const accentColor = Color(0xFF6734C7);
  static const elevatedButtonBorder = Color(0xFF2C2C2C);
  static const border = Color(0xFFC4C4C4);
  static const hintColor = Color(0xFF6C6C6C);
  static const textFieldBorder = Color(0xFF8c8c8c);
}
