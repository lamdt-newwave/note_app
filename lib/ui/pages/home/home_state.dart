part of 'home_cubit.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [notes, loadNoteStatus];

  final List<NoteEntity> notes;
  final LoadStatus loadNoteStatus;

  const HomeState(
      {this.loadNoteStatus = LoadStatus.initial, this.notes = const []});

  HomeState copyWith({LoadStatus? loadNoteStatus, List<NoteEntity>? notes}) {
    return HomeState(
        notes: notes ?? this.notes,
        loadNoteStatus: loadNoteStatus ?? this.loadNoteStatus);
  }
}
