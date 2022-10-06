part of 'detail_note_cubit.dart';

class DetailNoteState extends Equatable {
  final NoteEntity? note;
  final LoadStatus loadNoteStatus;
  final bool isEditing;
  final bool isSaving;
  final bool isDeleting;

  @override
  List<Object?> get props => [note, loadNoteStatus, isEditing, isSaving, isDeleting];

  const DetailNoteState({
     this.isDeleting = false,
    this.isEditing = false,
    this.note,
    this.loadNoteStatus = LoadStatus.initial,
    this.isSaving = false,

  });

  DetailNoteState copyWith({NoteEntity? note,
    LoadStatus? loadNoteStatus,
    bool? isEditing,
    bool? isSaving,
    bool? isDeleting
  }) {
    return DetailNoteState(
        isDeleting: isDeleting ?? this.isDeleting,
        isSaving: isSaving ?? this.isSaving,
        note: note ?? this.note,
        isEditing: isEditing ?? this.isEditing,
        loadNoteStatus: loadNoteStatus ?? this.loadNoteStatus);
  }
}
