import 'package:flutter/material.dart';

enum ThemeEvent { toggle }

ThemeData themeChangeReducer(ThemeData state, action) {
  if (state == ThemeData.dark()) {
    return ThemeData.light();
  } else {
    return ThemeData.dark();
  }
}
