import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(255, 255, 255, 255),
      primary: Color(0xFF1B2A57),
      secondary: Color(0xFF7CA0CA),
      inversePrimary: Color(0xFF98A2B2),
      inverseSurface: Color(0xFFF2F4F7),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: const Color.fromARGB(255, 255, 255, 255),
          displayColor: const Color(0xFF7CA0CA),
          decorationColor: const Color(0xFF1B2A57),
        ));
