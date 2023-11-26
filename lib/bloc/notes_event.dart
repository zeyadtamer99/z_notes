import '../model/note.dart';

abstract class NotesEvent {}

class FetchNotes extends NotesEvent {
    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FetchNotes;
  }

}

class AddNote extends NotesEvent {
  final Note note;

  AddNote(this.note);
    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddNote && other.note == note;
  }

  @override
  int get hashCode => note.hashCode;
}

class DeleteNote extends NotesEvent {
  final String id;

  DeleteNote(this.id);

    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteNote && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class EditNote extends NotesEvent {
  final Note note;

  EditNote(this.note);
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditNote && other.note == note;
  }

  @override
  int get hashCode => note.hashCode;
}

class ToggleFavorite extends NotesEvent {
  final String id;

  ToggleFavorite(this.id);

   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToggleFavorite && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
