part of 'new_note_cubit.dart';

class NewNoteState extends Equatable {
  final NoteEntity newNote;

  NewNoteState({NoteEntity? newNote})
      : newNote = newNote ?? NoteEntity(id: -1, title: "", text: "");

  @override
  List<Object?> get props => [newNote];

  NewNoteState copyWith({NoteEntity? newNote}) {
    return NewNoteState(
      newNote: newNote ?? this.newNote,
    );
  }
}
