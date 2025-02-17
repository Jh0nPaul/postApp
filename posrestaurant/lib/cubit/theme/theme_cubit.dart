import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme){
    _loadTheme();
  }

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xff2397b4),
      onPrimaryContainer: Color(0xff9dbec6),
      brightness: Brightness.light,
      tertiary: Color(0xffffffff),

    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,


    colorScheme: ColorScheme.dark(
      primary:Color(0xff004656),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xff2397b4),
      onPrimaryContainer: Color(0xff004e61),
      brightness: Brightness.dark,
      tertiary:Color(0xffffffff),
      onSurface:Color(0xff002e39),
      onTertiary:Color(0xff001014),
      inversePrimary: Color(0xff004656),
    ),
  );

  void toggleTheme( bool isDarkMode ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    emit(isDarkMode?_darkTheme:_lightTheme);
  }

  void _loadTheme() async {
   final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode?_darkTheme:_lightTheme);
  }
  void setCustomTheme(){
    emit(customThemeL);
  }
  static final ThemeData customThemeL = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      brightness: Brightness.light,
      onPrimary: Colors.white,
    ),
  );
}