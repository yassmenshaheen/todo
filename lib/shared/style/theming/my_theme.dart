import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/style/colors/app_color.dart';

class MyThemeData{

  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: lightgreen,
      appBarTheme: AppBarTheme(


  ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
  )
  );
  static ThemeData darkTheme=ThemeData();
}