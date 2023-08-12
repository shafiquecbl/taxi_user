import 'package:flutter/material.dart';
import 'package:taxi_user/utils/style.dart';

ThemeData light({Color color = const Color(0xFF57B054)}) => ThemeData(
      useMaterial3: true,
      fontFamily: 'poppins',
      primaryColor: color,
      primaryColorDark: const Color(0xFF55B174),
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: const Color(0xFFF7F8FB), // 0xFFF6F6F6
      dividerColor: Colors.grey[300]!, //0xFFE8E8E8
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color).copyWith(
          background: const Color(0xFFFFFFFF),
          error: const Color(0xFFdd3135),
          outline: const Color(0xFFF4F4F4)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        titleSpacing: 20,
        color: Color(0xFFFFFFFF),
        iconTheme: IconThemeData(color: Color(0xFF9F9F9F)),
        titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontSize: 18,
            fontWeight: fontWeightSemiBold,
            fontFamily: 'poppins'),
      ),
    );
