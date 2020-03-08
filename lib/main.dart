import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp03/data/model/note.dart';
import 'package:flutterapp03/pages/newnote/newnote.dart';
import 'package:flutterapp03/pages/newnote/newnote_presenter.dart';
import 'package:redux/redux.dart';
import 'redux/reduxTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<ThemeData> store =
      new Store<ThemeData>(themeChangeReducer, initialState: ThemeData.light());

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: StoreConnector<ThemeData, ThemeData>(
        converter: (store) => store.state,
        builder: (context, themeData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData,
            home: FirstPage(title: 'Flutter Local Note'),
          );
        },
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  final String title;

  FirstPage({key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage>
    implements LoadNotePresenterListener {
  List<Note> noteList = new List<Note>();
  NewNotePresenter newNotePresenter;

  FirstPageState() {
    newNotePresenter = new NewNotePresenter(null);
  }

  loadNote() {
    newNotePresenter.getAllNote(this);
  }

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new StoreConnector<ThemeData, VoidCallback>(
            converter: (store) {
              return () {
                print("click");
                store.dispatch(ThemeEvent.toggle);
              };
            },
            builder: (context, callback) {
              return IconButton(
                onPressed: (callback),
                icon: Icon(Icons.store),
              );
            },
          )
        ],
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return NoteItem(noteList[index]);
          },
          itemCount: noteList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewNotePage(
              title: "New Note",
            );
          }));
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  @override
  void onNoteLoadError() {
    // TODO: implement onNoteLoadError
  }

  @override
  void onNoteLoaded(List<Note> notes) {
    setState(() {
      noteList = notes;
    });
  }
}

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.red,
        child: InkWell(
          highlightColor: Colors.blue,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  note.title,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                Expanded(
                  child: Text(
                    note.content,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
