import 'package:flutterapp03/redux/note/note_action.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

final noteReducer = combineReducers<AppState>([
  TypedReducer<AppState, NewNoteAction>(_onNewNote),
  TypedReducer<AppState, NoteLoaded>(_onNoteLoaded)
]);

AppState _onNewNote(AppState state, NewNoteAction action) {
  print("_onNewNote");
  state.notes.add(action.note);
  return state;
}

AppState _onNoteLoaded(AppState state, NoteLoaded action) {
  print("_onNoteLoaded");
  state.notes = action.notes;
  return state;
}
