import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'app_state.dart';
import 'app_state.dart';
import 'app_state.dart';
import 'app_state.dart';

enum ThemeEvent { toggle }

final themeReducer = combineReducers<AppState>(
    [TypedReducer<AppState, ThemeEvent>(_onThemeChange)]);

AppState _onThemeChange(AppState state, ThemeEvent themeEvent) {
  if (state.themeData == ThemeData.light()) {
    state.themeData = ThemeData.dark();
  } else {
    state.themeData = ThemeData.light();
  }
  return state;
}
