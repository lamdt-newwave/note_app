class NoteEntity {
  final String title;
  final String text;
  final DateTime createdTime;
  final DateTime updatedTime;
  final int id;

  NoteEntity({
    required this.id,
    required this.title,
    required this.text,
    required this.createdTime,
    required this.updatedTime,
  });

  NoteEntity copyWith({
    String? title,
    String? text,
    DateTime? createdTime,
    DateTime? updatedTime,
    int? id,
  }) {
    return NoteEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        text: text ?? this.text,
        createdTime: createdTime ?? this.createdTime,
        updatedTime: updatedTime ?? this.updatedTime);
  }

  @override
  String toString() {
    return 'NoteEntity{title: $title, text: $text, createdTime: $createdTime, updatedTime: $updatedTime, id: $id}';
  }
}
