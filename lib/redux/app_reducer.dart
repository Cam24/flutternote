import 'package:flutterapp03/redux/note/note_reducer.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'reduxTheme.dart';
import 'reduxTheme.dart';

final appReducer = combineReducers<AppState>([noteReducer, themeReducer]);
