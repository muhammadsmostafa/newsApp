import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    fontFamily: 'Jannah',
    primarySwatch : Colors.deepOrange,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    )
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'Jannah',
  primarySwatch : defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);