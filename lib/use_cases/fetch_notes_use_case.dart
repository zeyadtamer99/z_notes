import '../model/note.dart';
import '../repositories/notes_repository.dart';

class FetchNotesUseCase {
  final NotesRepository repository;

  FetchNotesUseCase(this.repository);

  Future<List<Note>> call() async {
    return await repository.fetch();
  }
}
