import '../model/note.dart';
import '../repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<Note> call(Note note) async {
    return await repository.add(note);
  }
}
