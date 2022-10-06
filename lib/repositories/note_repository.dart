import 'package:note_app/models/entities/note.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNoteList();

  Future<bool> deleteNote(NoteEntity deleteNote);

  Future<NoteEntity> getNoteById(int noteId);

  Future<NoteEntity> updateNote(NoteEntity updatedNote);
}

class NoteRepositoryImpl extends NoteRepository {
  final notes = [
    NoteEntity(
      id: 1,
      title: "About this day",
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
      createdTime: DateTime.now(),
      updatedTime: DateTime.now(),
    ),
    NoteEntity(
        id: 2,
        title: "About this day",
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
        createdTime: DateTime.now(),
        updatedTime: DateTime.now()),
    NoteEntity(
        id: 3,
        title: "About this day",
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
        createdTime: DateTime.now(),
        updatedTime: DateTime.now())
  ];

  @override
  Future<List<NoteEntity>> getNoteList() {
    return Future.value(notes);
  }

  @override
  Future<bool> deleteNote(NoteEntity deleteNote) {
    try {
      notes.remove(deleteNote);
      return Future.value(true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NoteEntity> getNoteById(int noteId) {
    final note = notes.firstWhere((element) => element.id == noteId,
        orElse: () => throw Exception("Not found not with id: $noteId"));
    return Future.value(note);
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity updatedNote) {
    try {
      notes[notes.indexWhere((element) => element.id == updatedNote.id)] =
          updatedNote;
      return Future.value(updatedNote);
    } catch (e) {
      rethrow;
    }
  }
}
