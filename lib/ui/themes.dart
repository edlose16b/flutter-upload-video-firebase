import 'package:flutter/material.dart';
import 'package:retofamosos/constants.dart';

ThemeData themeData = ThemeData(
  fontFamily: kFontFamily,
  primaryColor: kPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  iconTheme: IconThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
  ),
);
