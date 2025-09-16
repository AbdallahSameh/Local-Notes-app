import 'package:local_notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static Future<Database> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'local_notes.db');

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, title TEXT, subtitle TEXT, content TEXT, last_modified TEXT)',
        );
      },
    );
    return database;
  }

  Future<int> insert(Database database, Notes note) async {
    var map = note.toMap();
    await database.insert('Notes', map);
    return 0;
  }

  Future<int> update(Database database, Notes note) async {
    await database.rawUpdate(
      'UPDATE Notes SET image = ?, title = ?, subtitle = ?, content = ?, last_modified = ? WHERE id = ?',
      [
        note.image,
        note.title,
        note.subtitle,
        note.content,
        note.lastModified,
        note.id,
      ],
    );
    return 0;
  }

  Future<int> delete(Database database, int id) async {
    await database.rawDelete('DELETE FROM Notes WHERE id = ?', [id]);
    return 0;
  }

  Future<List<Notes>> getAll(Database database) async {
    List<Notes> notes = [];
    List<Map<String, dynamic>> data = await database.rawQuery(
      'SELECT * FROM Notes',
    );

    for (Map<String, dynamic> note in data) {
      notes.add(Notes.fromMap(note));
    }

    return notes;
  }

  Future<void> resetCounter(Database database) async {
    await database.delete(
      'sqlite_sequence',
      where: 'name = ?',
      whereArgs: ['notes'],
    );
  }
}
