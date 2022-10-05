import 'package:note_app/models/entities/note.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNoteList();

  Future<bool> deleteNote(NoteEntity deleteNote);
}

class NoteRepositoryImpl extends NoteRepository {
  final notes = [
    NoteEntity(
        title: "About this day",
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
        time: DateTime.now()),
    NoteEntity(
        title: "About this day",
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
        time: DateTime.now()),
    NoteEntity(
        title: "About this day",
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices vehicula iaculis. Aliquam at accumsan leo. Proin in diam quam. Pellentesque habitant morbi ...",
        time: DateTime.now())
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
}
