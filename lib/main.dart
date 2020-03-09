import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp03/data/model/note.dart';
import 'package:flutterapp03/pages/newnote/newnote.dart';
import 'package:flutterapp03/pages/newnote/newnote_presenter.dart';
import 'package:flutterapp03/redux/note/note_action.dart';
import 'package:redux/redux.dart';
import 'data/model/note.dart';
import 'redux/app_reducer.dart';
import 'redux/app_state.dart';
import 'redux/app_state.dart';
import 'redux/app_state.dart';
import 'redux/reduxTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store =
      new Store<AppState>(appReducer, initialState: AppState.init());

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: StoreConnector<AppState, ThemeData>(
        converter: (store) => store.state.themeData,
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
          new StoreConnector<AppState, VoidCallback>(
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
        child: StoreConnector<AppState, List<Note>>(
          converter: (store) {
            return store.state.notes;
          },
          builder: (context, List<Note> notes) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return NoteItem(notes[index]);
              },
              itemCount: notes.length,
            );
          },
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
    print("onNoteLoadError");
  }

  @override
  void onNoteLoaded(List<Note> notes) {
    print("onNoteLoaded" + notes.length.toString());
    try {
      Store store = StoreProvider.of<AppState>(context,listen: true);
      store.dispatch(NoteLoaded(notes));
    } on Exception catch (ex) {
      print("error:" + ex.toString());
    }
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
