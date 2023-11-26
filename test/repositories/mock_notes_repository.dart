import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:znotes/bloc/notes_bloc.dart';
import 'package:znotes/bloc/notes_event.dart';
import 'package:znotes/model/note.dart';
import 'package:znotes/repositories/notes_repository.dart';


class MockNotesRepository extends Mock implements NotesRepository {
  @override
  Future<Note> add(Note note) => Future.value(note);

  @override
  Future<Note> edit(Note note) => Future.value(note);

  @override
  Future<void> delete(String id) => Future.value();

  @override
  Future<List<Note>> fetch() => Future.value([Note(id: '1', title: 'Test', content: 'Test content', color: Color(0256456), lastModified: DateTime.now())]);
}

class MockNotesBloc extends MockBloc<NotesEvent, NotesState> implements NotesBloc {}
