import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.white,

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
      primary: Color(0xff002e39),
      onPrimary: Color(0xff2397b4),
      onSecondary: Color(0xff2397b4),
      onPrimaryContainer: Color(0xff004e61),
      brightness: Brightness.dark,
      tertiary: Color(0xffffffff),
    ),
  );

  void toggleTheme( bool isDarkMode ){
    emit(isDarkMode?_lightTheme:_darkTheme);
  }
  void setCustomTheme(){
    emit(customTheme);
  }
  static final ThemeData customTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      brightness: Brightness.light,
    ),
  );
}