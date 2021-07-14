//@dart=2.9

import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/note.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    final path = join(directory.path, 'todo.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT, date TEXT)""");
    });
  }

  Future<int> addNote(NoteBook noteBook) async {
    final db = await initDatabase();
    return db.insert(
      'todo',
      noteBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<NoteBook>> fetchNoteList() async {
    final db = await initDatabase();
    final maps = await db.query('todo');

    return List.generate(maps.length, (index) {
      return NoteBook(
        id: maps[index]['id'],
        title: maps[index]['title'],
        content: maps[index]['content'],
        date: maps[index]['date'],
      );

    });
  }
}
