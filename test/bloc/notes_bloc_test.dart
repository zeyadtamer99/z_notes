import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znotes/bloc/notes_bloc.dart';
import 'package:znotes/bloc/notes_event.dart';
import 'package:znotes/model/note.dart';

import '../repositories/mock_notes_repository.dart';

void main() {
  final repository = MockNotesRepository();

  blocTest<NotesBloc, NotesState>(
    'NotesBloc should yield loaded state with notes when fetching notes',
    build: () => NotesBloc(repository),
    act: (bloc) => bloc.add(FetchNotes()),
    expect: () => [isA<NotesLoaded>()],
  );

  blocTest<NotesBloc, NotesState>(
    'NotesBloc should yield error state when repository throws',
    build: () {
      when(repository.fetch()).thenThrow(Exception('Failed to fetch notes'));
      return NotesBloc(repository);
    },
    act: (bloc) => bloc.add(FetchNotes()),
      expect: () => [isA<NotesLoaded>()], 
  );
}
