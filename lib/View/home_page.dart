// @dart=2.9

import 'package:flutter/material.dart';
import 'package:todo/Extra/appbartitle.dart';
import 'package:todo/View/note_add.dart';
import 'package:todo/constants/cosntant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //-------------------Variable-----------------------
  String _greeting;

  //--------------------Function------------------------

  @override
  void initState() {
    // TODO: implement
    super.initState();

    greetings();
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
          onPressed: () {
            setState(() {
              print('Clicked');
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NoteAddPage();
                },
              ),
            );
          },
        ),
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
                          onChanged: (value) {},
                          // controller: _editingController,
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 0, bottom: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kColorLight),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Notes',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          Text(
                                            '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          Text(
                                            '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    //----------POpUpMEnu----------------
                                    PopupMenuButton(
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Edit',
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Update'),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Delete',
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text('Delete'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
}
