import 'package:flutter/material.dart';

class Themes {
  final ThemeData lightMode = ThemeData(
      colorScheme: const ColorScheme.light(
          // surface: Color(0xFFFFF3E9),
          brightness: Brightness.light,
          primary: Color(0xFFFDA758),
          secondary: Color(0xFFFFF3E9),
          tertiary: Colors.black54));

  final ThemeData darkMode = ThemeData(
      colorScheme: const ColorScheme.dark(
    // surface: Color(0xFF131313),
    brightness: Brightness.dark,
    primary: Color(0xFFE3DEEF),
    secondary: Color(0xFF151437),
    tertiary: Colors.white,
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

!ARKMODE 

// background 0xFF151437
// buttons 0xFFE3DEEF
bottom nav 0xFF2C2B44
clouds 0xFFB5A8D5 
fonts 0xFFFFFFFF or darkpurple or 
textfields 0xFFAA98A8 lavander  
*/

//! the Dark Mode I Mages 