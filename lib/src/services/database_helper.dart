import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            note TEXT NOT NULL,
            onCreated INTEGER NOT NULL,
            onModified INTEGER NOT NULL
          )
        ''');
        await db.insert(
          'notes',
          {
            'title': 'Notes App',
            'note': 'Click to edit me >u<\nHold to delete me T_T',
            'onCreated': DateTime.now().millisecondsSinceEpoch,
            'onModified': DateTime.now().millisecondsSinceEpoch,
          },
        );
      },
    );
  }

  Future<int> addNote(String title, String note) async {
    final db = await database;
    return await db.insert(
      'notes',
      {
        'title': title,
        'note': note,
        'onCreated': DateTime.now().millisecondsSinceEpoch,
        'onModified': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query('notes', orderBy: 'onModified DESC');
  }

  Future<int> updateNote(int id, String title, String note) async {
    final db = await database;
    return await db.update(
      'notes',
      {
        'title': title,
        'note': note,
        'onModified': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
