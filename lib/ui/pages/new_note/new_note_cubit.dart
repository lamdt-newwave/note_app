import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:note_app/models/entities/note.dart';

import '../../../repositories/note_repository.dart';

part 'new_note_state.dart';

class NewNoteCubit extends Cubit<NewNoteState> {
  final NoteRepository noteRepository;

  NewNoteCubit({required this.noteRepository}) : super(NewNoteState());

  void onTitleChanged(String newValue) {
    emit(state.copyWith(
        newNote: state.newNote.copyWith(title: newValue.trim())));
  }

  void onTextChanged(String newValue) {
    emit(
        state.copyWith(newNote: state.newNote.copyWith(text: newValue.trim())));
  }

  bool hasContent() {
    return state.newNote.title.isNotEmpty && state.newNote.text.isNotEmpty;
  }

  void onBack() {
    emit(state.copyWith(newNote: NoteEntity()));
    Get.back();
  }

  Future<void> onCreateNewNote() async {
    try {
      final result = await noteRepository.createNewNote(state.newNote);
    } catch (e) {
      throw Exception(
          "Can't create new note with infor: ${state.newNote.toString()}");
    }
  }
}
