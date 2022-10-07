import 'package:note_app/database/sqlite_helper.dart';
import 'package:note_app/models/entities/note.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNoteList();

  Future<bool> deleteNoteById(int noteId);

  Future<NoteEntity> getNoteById(int noteId);

  Future<NoteEntity> updateNote(NoteEntity updatedNote);

  Future<NoteEntity> createNewNote(NoteEntity newNote);
}

class NoteRepositoryImpl extends NoteRepository {
  final SqliteHelper localStorage;

  NoteRepositoryImpl({required this.localStorage});

  @override
  Future<NoteEntity> createNewNote(NoteEntity newNote) async {
    int id = await localStorage.insertNote(newNote);
    return newNote.copyWith(id: id);
  }

  @override
  Future<bool> deleteNoteById(int noteId) async {
    return await sqliteHelper.deleteNote(noteId);
  }

  @override
  Future<NoteEntity> getNoteById(int noteId) async {
    return await localStorage.getNoteById(noteId);
  }

  @override
  Future<List<NoteEntity>> getNoteList() async {
    return await localStorage.getNoteList();
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity updatedNote) async {
    return await localStorage.updateNote(updatedNote);
  }
}
