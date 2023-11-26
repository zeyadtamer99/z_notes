import '../model/note.dart';
import '../repositories/notes_repository.dart';

class EditNoteUseCase {
  final NotesRepository repository;

  EditNoteUseCase(this.repository);

  Future<Note> call(Note note) async {
    return await repository.edit(note);
  }
}
