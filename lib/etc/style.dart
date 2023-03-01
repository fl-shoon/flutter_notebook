import 'package:flutter/material.dart';

@immutable
class Style {
  final ColorScheme colorSheme;
  final Color elevatedBtnColor;
  final Color appBarBackgroundColor;

  const Style({
    required this.colorSheme,
    required this.elevatedBtnColor,
    required this.appBarBackgroundColor,
  });

  static const light = Style(
    colorSheme: ColorScheme.light(
      primary: Color.fromARGB(255, 250, 248, 251),
    ),
    elevatedBtnColor: Color.fromARGB(255, 187, 142, 239),
    appBarBackgroundColor: Color.fromARGB(255, 171, 82, 220),
  );

  static const dark = Style(
    colorSheme: ColorScheme.dark(
      primary: Color.fromARGB(255, 76, 203, 165),
    ),
    elevatedBtnColor: Color.fromARGB(255, 57, 65, 63),
    appBarBackgroundColor: Color.fromARGB(255, 20, 2, 2),
  );
}

ThemeData getTheme(Style style) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: style.colorSheme,
    primaryColor: style.colorSheme.primary,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 5,
      backgroundColor: style.appBarBackgroundColor,
      foregroundColor: style.colorSheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(style.elevatedBtnColor),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: style.appBarBackgroundColor,
      selectedItemColor: style.colorSheme.primary,
    ),
  );
}
