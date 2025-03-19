import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';

class Themes {
  final ThemeData lightMode = ThemeData(
      colorScheme: const ColorScheme.light(
          // surface: Color(0xFFFFF3E9),

          secondaryContainer: Color.fromRGBO(253, 167, 88, 0.1),
          scrim: Color(darkPurple),
          brightness: Brightness.light,
          primary: Color(0xFFFDA758),
          primaryFixed: Color(0xFFFDA758),
          secondary: Color(0xFFFFF3E9),
          tertiary: Colors.white,
          //me added this
          onSurface: Color(darkPurple),
          tertiaryContainer: Color(lightOrange),
          surface: Color(background)));

  final ThemeData darkMode = ThemeData(
      colorScheme: const ColorScheme.dark(
    secondaryContainer: Color.fromRGBO(255, 255, 255, 0.05),
    brightness: Brightness.dark,
    scrim: Colors.white,
    primary: Color.fromRGBO(240, 222, 250, 0.8),
    primaryFixed: altPurple,
    secondary: Color(0xFF151437),
    tertiary: Color(0xFF111111),
    //me added this
    onSurface: altPurple,
    tertiaryContainer: Color(0xFF1B1B1B),
    surface: Color(0xFF17153B),
  ));
}

/*
@Light Mode
// background 0xFFFFF3E9 creamy			
// buttons 0xFFFDA758 orange(light)
bottom nav white 
clouds 0xFFFFDFC1
fonts 0xFF573353 darkpurple
textfields 0xFFAA98A8 lavander  

!DARKMODE 

// background 0xFF151437
// buttons 0xFFE3DEEF
bottom nav 0xFF2C2B44
clouds 0xFFB5A8D5 
fonts 0xFFFFFFFF or darkpurple or 
textfields 0xFFAA98A8 lavander  
*/

//! the Dark Mode I Mages
