// @dart=2.9
import 'package:flutter/material.dart';
import 'package:todo/Extra/appbartitle.dart';
import 'package:todo/Extra/custom_toast.dart';
import 'package:todo/Extra/date_formatter.dart';
import 'package:todo/constants/cosntant.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/note.dart';

class NoteAddPage extends StatefulWidget {
  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  DatabaseHelper _db;
  bool isLoading;
  String _date;
  TextEditingController _titleController;
  TextEditingController _contentController;
  @override
  void initState() {
    super.initState();
    _date =
        DateFormatter.getDateFormat(DateTime.now().toString().substring(0, 10));
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(
          title: 'Note Add',
          subTitle: '',
        ),
        backgroundColor: kColorBlue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: !isLoading
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(
                                      'Note Title',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffbcbcbc),
                                        fontFamily: 'Dancing',
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff575757),
                                      fontFamily: 'Dancing',
                                    ),
                                    showCursor: true,
                                    cursorColor: kColorBlue,
                                    cursorWidth: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Text(
                                      'Note Content*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  child: TextFormField(
                                    maxLines: null,
                                    controller: _contentController,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffbcbcbc),
                                        fontFamily: 'Dancing',
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff575757),
                                      fontFamily: 'Dancing',
                                    ),
                                    showCursor: true,
                                    cursorColor: kColorBlue,
                                    cursorWidth: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Text(
                                      'Note Date*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  child: ListTile(
                                    title: Text(_date),
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2030))
                                          .then((DateTime value) {
                                        if (value != null) {
                                          setState(() {
                                            _date = DateFormatter.getDateFormat(
                                                value
                                                    .toString()
                                                    .substring(0, 10));
                                          });
                                        }
                                      });
                                    },
                                    trailing:
                                        Icon(Icons.calendar_today_rounded),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 25.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (_titleController.text == '') {
                          CustomToast.toast('Enter The title');
                        } else if (_contentController.text == '') {
                          CustomToast.toast('Enter the content');
                        } else if (_date == null) {
                          CustomToast.toast('Enter Date');
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          NoteBook note = NoteBook(
                              title: _titleController.text,
                              content: _contentController.text,
                              date: _date);
                          var isAdded = await _db.addNote(note);
                          if (isAdded == 1) {
                            setState(() {
                              isLoading = false;
                            });
                            CustomToast.toast('Note Added');
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            CustomToast.toast('Note can not be Added');
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: kColorPrimary,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'Add Note'.toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Dancing', color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kColorPrimary),
                ),
              ),
      ),
    );
  }
}
