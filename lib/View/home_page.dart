// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Extra/appbartitle.dart';
import 'package:todo/Extra/custom_toast.dart';
import 'package:todo/View/note_add.dart';
import 'package:todo/constants/cosntant.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/note.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //-------------------Variable-----------------------
  String _greeting;
  DatabaseHelper _db;
  bool isLoading;
  List<NoteBook> noteList;
  List<NoteBook> storeList;
  TextEditingController _titleController;

  final _auth =  FirebaseAuth.instance;

  //--------------------Function------------------------

  @override
  void initState() {
    super.initState();
    noteList = [];
    storeList = [];
    fetchNoteList();
    _db = DatabaseHelper();
    greetings();
    _titleController = TextEditingController();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final user =_auth.currentUser;
    if(user!=null){
      print(user.email);
    }
  }

  Future<void> fetchNoteList() async {
    try {
      var notes = await _db.fetchNoteList();
      if (notes.length > 0) {
        setState(() {
          noteList.addAll(notes);
          storeList.addAll(notes);
          isLoading = false;
        });
      } else {
        setState(() {
          noteList = [];
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        noteList = [];
        isLoading = false;
      });
    }
  }

  void greetings() {
    var timeOfDay = DateTime.now().hour;

    if (timeOfDay >= 0 && timeOfDay < 6) {
      _greeting = 'Good Morning';
    } else if (timeOfDay >= 0 && timeOfDay < 12) {
      _greeting = 'Good Morning';
    } else if (timeOfDay >= 12 && timeOfDay < 16) {
      _greeting = 'Good Afternoon';
    } else if (timeOfDay >= 16 && timeOfDay < 21) {
      _greeting = 'Good Evening';
    } else if (timeOfDay >= 21 && timeOfDay < 24) {
      _greeting = 'Good Night';
    }
  }

  Future<void> showMenuSelection(String value, int id) async {
    switch (value) {
      case 'Delete':
        setState(() {
          isLoading = true;
        });
        onDelete(id);
        break;

      case 'Edit':
        CustomToast.toast('Edit clicked');

        break;
    }
  }
  //
  // Widget showAlert() {
  //   return Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "Are You Sure?",
  //     desc: "Click delete to delete note",
  //     buttons: [
  //   DialogButton(
  //     child: Text(
  //       "Cancle",
  //       style: TextStyle(color: Colors.white, fontSize: 20),
  //     ),
  //     onPressed: () => Navigator.pop(context),
  //     color: Color.fromRGBO(0, 179, 134, 1.0),
  //   ),
  //   DialogButton(
  //     child: Text(
  //       "Delete",
  //       style: TextStyle(color: Colors.white, fontSize: 20),
  //     ),
  //     onPressed: () {
  //
  //     },
  //     gradient: LinearGradient(colors: [
  //       Color.fromRGBO(116, 116, 191, 1.0),
  //       Color.fromRGBO(52, 138, 199, 1.0)
  //     ]),
  //   )
  //     ],
  //   ).show();
  // }

  void onDelete(int id) async {
    int isDeleted = await _db.deleteNote(id);
    if (isDeleted == 1) {
      CustomToast.toast('Note deleted');
      setState(() {
        isLoading = false;
      });
      noteList = [];
      fetchNoteList();
    } else {
      CustomToast.toast('Note not deleted');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterSearchResult(String query) {
    noteList.clear();
    if (query.isNotEmpty) {
      List<NoteBook> newList = [];

      for (NoteBook noteBook in storeList) {
        if (noteBook.title.toLowerCase().contains(query.toLowerCase())) {
          newList.add(noteBook);
        }
      }
      setState(() {
        noteList.addAll(newList);
      });
    } else {
      setState(() {
        noteList.addAll(storeList);
      });
    }
  }

  //-----------------------Body--------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
            elevation: 0.0,
            child: Icon(Icons.add),
            backgroundColor: kColorPrimary,
            onPressed: () async {
              bool isAdded = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NoteAddPage();
                }),
              );

              if (isAdded == true) {
                setState(() {
                  noteList = [];
                  isLoading = true;
                });
                fetchNoteList();
              }
            }),
      ),
      body: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppBarTitle(
            title: 'To-Do',
            subTitle: '-365',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.menu_book,
                        size: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hello' + ' Saad Rafi,',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 32.0,
                                      fontFamily: 'Fuggles',
                                    ),
                          ),
                          Text(
                            _greeting,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Fuggles',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // -------------------------Searchbar-------------------------

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        height: 55,
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResult(value);
                          },
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'search by title...',
                            prefixIcon: Icon(Icons.search),
                            fillColor: kColorLight,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: kColorPrimary)),
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                bottom: 10.0, left: 10.0, right: 10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !isLoading
                          ? noteList.contains(null) || noteList.length <= 0
                              ? Container(
                                  child: Center(
                                      child:
                                          Text("No note available, add new")))
                              : ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 5,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: noteList.length,
                                  itemBuilder: (context, index) {
                                    return noteListItem(noteList[index]);
                                  },
                                )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    kColorPrimary),
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding noteListItem(NoteBook noteBook) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: kColorLight,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      noteBook.title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      noteBook.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      noteBook.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  showMenuSelection(value, noteBook.id);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                      value: 'Edit',
                      child: ListTile(
                          leading: Icon(Icons.edit), title: Text('Update'))),
                  const PopupMenuItem<String>(
                      value: 'Delete',
                      child: ListTile(
                          leading: Icon(Icons.delete), title: Text('Delete'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
