import 'package:flutter/foundation.dart';

import '../../data/model/note.dart';
import '../../data/model/note.dart';
import '../../data/model/note.dart';

class NewNoteAction {
  Note note;

  NewNoteAction(this.note);
}

class NoteLoaded {
  List<Note> notes;

  NoteLoaded(this.notes);
}
