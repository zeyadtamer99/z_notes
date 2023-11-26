import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:znotes/model/note.dart';
import 'package:znotes/use_cases/edit_note_use_case.dart';

import '../repositories/mock_notes_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = MockNotesRepository();
  final useCase = EditNoteUseCase(repository);
  final note = Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now());

  test('EditNoteUseCase should edit note in repository', () async {
    when(repository.edit(note)).thenAnswer((_) async => note);

    final result = await useCase(note);

    expect(result, note);
    verify(repository.edit(note)).called(1);
  });

  test('EditNoteUseCase should throw when editing a note that does not exist', () async {
    final note = Note(id: '2', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now());

    when(repository.edit(note)).thenThrow(Exception('Note not found'));

    expect(() async => await useCase(note), throwsA(isA<Exception>()));
  });
}
