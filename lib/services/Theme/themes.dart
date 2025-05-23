import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';

class Themes {
  final ThemeData lightMode = ThemeData(
      colorScheme: ColorScheme.light(
          // surface: Color(0xFFFFF3E9),

          secondaryContainer:const Color.fromRGBO(253, 167, 88, 0.1),
          scrim: const Color(darkPurple),
          brightness: Brightness.light,
          primary:const Color(0xFFFDA758),
          primaryFixed:const Color(0xFFFDA758),
          secondary:const Color(0xFFFFF3E9),
          tertiary: Colors.white,
          onTertiary: Colors.grey.shade200,
          //me added this
          onSurface:const Color(darkPurple),
          tertiaryContainer:const Color(lightOrange),
          surface: const Color(background)));

  final ThemeData darkMode = ThemeData(
      colorScheme:  ColorScheme.dark(
    secondaryContainer:const Color.fromRGBO(255, 255, 255, 0.05),
    brightness: Brightness.dark,
    scrim: Colors.white,
    primary:const Color.fromRGBO(240, 222, 250, 0.8),
    primaryFixed: altPurple,
    secondary:const Color(0xFF151437),
    tertiary: const Color(0xFF111111),
    onTertiary: Colors.grey.shade900,
    //me added this
    onSurface: altPurple,
    tertiaryContainer:const  Color(0xFF1B1B1B),
    surface: const Color(0xFF17153B),
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
