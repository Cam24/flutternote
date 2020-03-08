import 'package:flutterapp03/data/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'dart:io' as io;

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  initDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "note.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE note(id TEXT PRIMARY KEY,title TEXT,content TEXT);");
  }

  Future<Note> addNote(Note note) async {
    var dbClient = await db;
    await dbClient.insert("note", note.toMap());
    return note;
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    var mapList = await dbClient.query("note");
    var noteList = new List<Note>();
    for (var value in mapList) {
      print("Note:" +
          value['id'] +
          "," +
          value['title'] +
          "," +
          value['content']);
      Note note = Note.map(value);
      noteList.add(note);
    }
    return noteList;
  }
}
