// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const KprimaryColor = Color(0xff1f62de);
const Color KLightbackGroundColor = Color(0xff1f62de);
const Color KDarktbackGroundColor = Color(0xff5f5f63);
const Color KTaskColor1 = KprimaryColor;
const Color KTaskColor2 = Colors.pink;
const Color KTaskColor3 = Colors.amber;

class Themes {
  static final light = ThemeData(
    primaryColor: KprimaryColor,
    brightness: Brightness.light,
    backgroundColor: const Color(0xfff0ebe1),
    // appBarTheme: const AppBarTheme(titleSpacing: 0 ),
  );
  static final dark = ThemeData(
    primaryColor: Colors.grey.shade800,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey.shade700,
    //appBarTheme: const AppBarTheme(titleSpacing: 0),
  );
}

///fontSize=34
TextStyle get heading4Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=24
TextStyle get heading5Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=20,fontWeight=bold
TextStyle get heading6Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=16 ,fontWeight=bold
TextStyle get title1Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=14,fontWeight=bold
TextStyle get title2Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=16
TextStyle get subTitle1Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 16,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=14
TextStyle get subTitle2Style => GoogleFonts.oxygen(
        textStyle: TextStyle(
      fontSize: 14,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ));

///fontSize=12
TextStyle get captionStyle => GoogleFonts.oxygen(
        textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ));




//headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5