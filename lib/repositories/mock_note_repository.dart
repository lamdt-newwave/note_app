import '../models/entities/note.dart';
import 'note_repository.dart';

class MockNoteRepositoryImpl extends NoteRepository {
  final notes = [
    NoteEntity(
      id: 1,
      title: "About this day",
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
    ),
    NoteEntity(
      id: 2,
      title: "About this day",
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
    ),
    NoteEntity(
      id: 3,
      title: "About this day",
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
    )
  ];

  @override
  Future<List<NoteEntity>> getNoteList() {
    return Future.value(notes);
  }

  @override
  Future<bool> deleteNoteById(int noteId) {
    try {
      notes.remove(notes.firstWhere((element) => element.id == noteId));
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

  @override
  Future<NoteEntity> createNewNote(NoteEntity newNote) {
    notes.add(newNote.copyWith(id: notes.length + 1));
    return Future.value(notes.last);
  }
}
