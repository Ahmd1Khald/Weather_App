import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

const url = 'forecast.json';

const key = '7dca6848bc4841c5a1e83109222509';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
    //statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: HexColor('9CC4DF'),
  )),
);
