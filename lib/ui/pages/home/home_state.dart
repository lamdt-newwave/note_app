part of 'home_cubit.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props =>
      [notes, loadNoteStatus, isEnableDelete, selectedIndex];

  final List<NoteEntity> notes;
  final LoadStatus loadNoteStatus;
  final bool isEnableDelete;
  final int selectedIndex;

  const HomeState(
      {this.isEnableDelete = false,
      this.loadNoteStatus = LoadStatus.initial,
      this.selectedIndex = -1,
      this.notes = const []});

  HomeState copyWith(
      {LoadStatus? loadNoteStatus,
      List<NoteEntity>? notes,
      int? selectedIndex,
      bool? isEnableDelete}) {
    return HomeState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        notes: notes ?? this.notes,
        isEnableDelete: isEnableDelete ?? this.isEnableDelete,
        loadNoteStatus: loadNoteStatus ?? this.loadNoteStatus);
  }
}
