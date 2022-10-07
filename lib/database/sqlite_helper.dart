import 'package:note_app/models/entities/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  late Database _database;

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_note.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, text TEXT, createdTime INTEGER, updatedTime INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertNote(NoteEntity noteEntity) async {
    return await _database.insert(
      'notes',
      noteEntity.toMapWithoutId(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteEntity>> getNoteList() async {
    final List<Map<String, dynamic>> maps = await _database.query('notes');

    return List.generate(maps.length, (i) {
      return NoteEntity(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        createdTime:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['createdTime']),
        updatedTime:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['updatedTime']),
      );
    });
  }

  Future<NoteEntity> getNoteById(int noteId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'notes',
      where: 'id = ?',
      whereArgs: [noteId],
    );

    if (maps.isNotEmpty) {
      final result = maps.first;
      return NoteEntity(
        id: result['id'],
        title: result['title'],
        text: result['text'],
        createdTime: DateTime.fromMillisecondsSinceEpoch(result['createdTime']),
        updatedTime: DateTime.fromMillisecondsSinceEpoch(result['updatedTime']),
      );
    } else {
      throw Exception("Not found note with $noteId }");
    }
  }

  Future<NoteEntity> updateNote(NoteEntity noteEntity) async {
    await _database.update(
      'notes',
      noteEntity.toMap(),
      where: 'id = ?',
      whereArgs: [noteEntity.id],
    );
    return getNoteById(noteEntity.id);
  }

  Future<bool> deleteNote(int noteId) async {
    return await _database.delete(
          'notes',
          where: 'id = ?',
          whereArgs: [noteId],
        ) !=
        0;
  }
}

final sqliteHelper = SqliteHelper();
