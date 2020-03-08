import 'package:flutterapp03/data/database_helper.dart';
import 'package:flutterapp03/data/model/note.dart';

abstract class NewNotePresenterListener {
  void onNewNoteSuccess();

  void onNewNoteError();

  void onNoteLoaded(List<Note> notes);

  void onNoteLoadError();
}

abstract class LoadNotePresenterListener {
  void onNoteLoaded(List<Note> notes);

  void onNoteLoadError();
}

class NewNotePresenter {
  NewNotePresenterListener _listener;
  DatabaseHelper databaseHelper = new DatabaseHelper();

  NewNotePresenter(this._listener);

  addNewNote(Note note) {
    databaseHelper
        .addNote(note)
        .then((note) => _listener.onNewNoteSuccess())
        .catchError((error) => _listener.onNewNoteError());
  }

  getAllNote(LoadNotePresenterListener _listener) {
    databaseHelper
        .getNotes()
        .then((notes) => _listener.onNoteLoaded(notes))
        .catchError((onError) => _listener.onNoteLoadError());
  }
}
