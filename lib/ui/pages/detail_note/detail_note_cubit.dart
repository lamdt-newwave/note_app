import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:note_app/models/entities/note.dart';
import 'package:note_app/models/enums/load_status.dart';
import 'package:note_app/router/app_routes.dart';
import 'package:note_app/ui/pages/home/home_cubit.dart';

import '../../../repositories/note_repository.dart';

part 'detail_note_state.dart';

class DetailNoteCubit extends Cubit<DetailNoteState> {
  final NoteRepository noteRepository;

  DetailNoteCubit({required this.noteRepository})
      : super(const DetailNoteState());

  Future<void> fetchNote(int noteId) async {
    emit(state.copyWith(loadNoteStatus: LoadStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final result = await noteRepository.getNoteById(noteId);
      emit(
        state.copyWith(note: result, loadNoteStatus: LoadStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(loadNoteStatus: LoadStatus.failure));
    }
  }

  void onEnableEditing() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void onDeleteNote() {
    emit(state.copyWith(isDeleting: !state.isDeleting));
  }

  void onSaveNote() {
    emit(state.copyWith(isSaving: !state.isSaving));
  }

  void onBack() {
    Get.back();
  }

  Future<void> onConfirm(NoteEntity note, BuildContext context) async {
    if (state.isEditing) {
      try {
        final result = await noteRepository.updateNote(note);
        emit(state.copyWith(note: result, isSaving: false, isEditing: false));
      } catch (e) {}
    } else if (state.isDeleting) {
      try {
        final result = await noteRepository.deleteNote(note);
        emit(state.copyWith(
            isSaving: false, isEditing: false, isDeleting: false));
        final homeCubit = context.read<HomeCubit>();
        await homeCubit.fetchNotes();
        Get.offNamed(AppRoutes.home);
      } catch (e) {}
    }
  }

  void onCancel() {
    emit(state.copyWith(isEditing: false, isSaving: false));
  }
}
