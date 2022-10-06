import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/entities/note.dart';
import '../../../models/enums/load_status.dart';
import '../../../repositories/note_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteRepository noteRepository;

  HomeCubit({required this.noteRepository}) : super(const HomeState());

  Future<void> fetchNotes() async {
    emit(state.copyWith(loadNoteStatus: LoadStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await noteRepository.getNoteList();
      emit(
        state.copyWith(notes: result, loadNoteStatus: LoadStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(loadNoteStatus: LoadStatus.failure));
    }
  }

  void onEnableDeleteNote() {
    emit(state.copyWith(isEnableDelete: !state.isEnableDelete));
  }

  void onDisableDeleteNote() {
    emit(state.copyWith(isEnableDelete: !state.isEnableDelete));
  }

  void onDeleteNote(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> onConfirmDeleteNote(int index) async {
    noteRepository.deleteNote(state.notes[index]);
    final newNotes = await noteRepository.getNoteList();
    emit(state.copyWith(notes: newNotes, selectedIndex: -1));
  }

  void onCancelDeleteNote() {
    emit(state.copyWith(selectedIndex: -1));
  }

  Future<void> onTextFieldChanged(String newText) async {
    final newNotes = await noteRepository.getNoteList();
    final filteredNotes =
        newNotes.where((element) => element.title.contains(newText)).toList();
    emit(state.copyWith(notes: filteredNotes));
  }

  Future<void> onClearTextField() async {
    final notes = await noteRepository.getNoteList();
    emit(state.copyWith(notes: notes));
  }
}
