import 'package:flutter/material.dart';

const primaryColor = Color(0xff333333);
const secondaryColor = Colors.grey;
final inactiveColor = Colors.grey.shade400;

const primaryBackgroundColor = Colors.white;
final secondaryBackgroundColor = Colors.grey.shade100;

const primaryTextColor = Color(0xff333333);

const mainHorizontalPadding = 28.0;
const commonBorderRadius = 10.0;

final commonSplashColor = Colors.grey.withOpacity(0.1);
const commonImageRadius = 14.0;

final themeData = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: primaryBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryBackgroundColor,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
  ),
  menuTheme: MenuThemeData(
    style: MenuStyle(
      elevation: const MaterialStatePropertyAll(5),
      shadowColor: MaterialStatePropertyAll(
        Colors.grey.shade50.withOpacity(0.4),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 25,
      color: primaryTextColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Hiragino Sans',
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      color: primaryTextColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Hiragino Sans',
    ),
    headlineSmall: TextStyle(
      fontSize: 14,
      color: primaryTextColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Hiragino Sans',
    ),
    titleMedium: TextStyle(
      color: primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Hiragino Sans',
    ),
    titleSmall: TextStyle(
      color: primaryTextColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Hiragino Sans',
    ),
    bodyMedium: TextStyle(
      color: primaryTextColor,
      fontFamily: 'Hiragino Sans',
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: primaryTextColor,
      fontFamily: 'Hiragino Sans',
    ),
  ),
);
