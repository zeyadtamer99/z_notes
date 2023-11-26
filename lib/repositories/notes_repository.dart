import '../model/note.dart';

abstract class NotesRepository {
  Future<Note> add(Note note);
  Future<Note> edit(Note note);
  Future<void> delete(String id);
  Future<void> toggleFavorite(String id);
  Future<List<Note>> fetch();
}

class NotesRepositoryImpl implements NotesRepository {
  final List<Note> _notes = [];

  @override
  Future<Note> add(Note note) async {
    _notes.add(note);
    return note;
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index].isFavorite = !_notes[index].isFavorite;
    }
  }

  @override
  Future<Note> edit(Note note) async {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      return note;
    }
    throw Exception('Note not found');
  }

  @override
  Future<void> delete(String id) async {
    _notes.removeWhere((n) => n.id == id);
  }

  @override
  Future<List<Note>> fetch() async {
    return _notes;
  }
}
