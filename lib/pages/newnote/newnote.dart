import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp03/data/model/note.dart';
import 'package:flutterapp03/pages/newnote/newnote_presenter.dart';
import 'package:uuid/uuid.dart';

class NewNotePage extends StatefulWidget {
  final String title;

  NewNotePage({key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewNotePageState();
  }
}

class NewNotePageState extends State<NewNotePage>
    implements NewNotePresenterListener {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  NewNotePresenter newNotePresenter;

  NewNotePageState() {
    newNotePresenter = new NewNotePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  minLines: 5,
                  decoration: InputDecoration(
                      hintText: "Note",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        onPressed: () {
          Note note = new Note(Uuid().v4(), "Note1", "Hello");
          newNotePresenter.addNewNote(note);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  void onNewNoteError() {
    // TODO: implement onNewNoteError
  }

  @override
  void onNewNoteSuccess() {

  }

  @override
  void onNoteLoadError() {
    // TODO: implement onNoteLoadError
  }

  @override
  void onNoteLoaded(List<Note> notes) {
    // TODO: implement onNoteLoaded
  }
}
