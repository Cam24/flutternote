import 'package:flutter/material.dart';

import '../data/model/note.dart';

class AppState {
  ThemeData themeData;
  List<Note> notes;

  AppState._();

  AppState.init() {
    themeData = ThemeData.light();
    notes = new List();
  }

  factory AppState() {
    return AppState();
  }
}
