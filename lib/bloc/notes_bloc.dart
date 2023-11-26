import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/note.dart';
import '../repositories/notes_repository.dart';
import 'notes_event.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _repository;

  NotesBloc(this._repository) : super(NotesInitial()) {
    on<FetchNotes>((event, emit) async {
      final notes = await _repository.fetch();
      emit(NotesLoaded(notes));
    });

    on<AddNote>((event, emit) async {
      await _repository.add(event.note);
      final notes = await _repository.fetch();
      emit(NotesLoaded(notes));
    });

    on<DeleteNote>((event, emit) async {
      await _repository.delete(event.id);
      final notes = await _repository.fetch();
      emit(NotesLoaded(notes));
    });

    on<EditNote>((event, emit) async {
      await _repository.edit(event.note);
      final notes = await _repository.fetch();
      emit(NotesLoaded(notes));
    });

    on<ToggleFavorite>((event, emit) async {
      await _repository.toggleFavorite(event.id);
      final notes = await _repository.fetch();
      emit(NotesLoaded(notes));
    });
  }
}

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  NotesLoaded(this.notes);
}
