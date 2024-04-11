import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Note(_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT NOT NULL, done INTEGER NOT NULL,needToSync INTEGER NOT NULL);"),
        version: _version);
  }

  static Future<PersonalTodoModel> addNote(PersonalTodoModel note) async {
    final db = await _getDB();
    await db.insert("Note", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    final map =
        await db.rawQuery("SELECT * FROM Note WHERE title = ?", [note.title]);
    return PersonalTodoModel.fromJson(map.first);
  }

  static Future<int> updateNote(PersonalTodoModel note) async {
    final db = await _getDB();
    return await db.update("Note", note.toMap(),
        where: '_id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(PersonalTodoModel note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: '_id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<PersonalTodoModel>?> getAllList() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PersonalTodoModel.fromMap(maps[index]));
  }
}
