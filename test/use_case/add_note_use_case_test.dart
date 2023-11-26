import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:znotes/model/note.dart';
import 'package:znotes/use_cases/add_note_use_case.dart';

import '../repositories/mock_notes_repository.dart';

void main() {
  final repository = MockNotesRepository();
  final useCase = AddNoteUseCase(repository);

  test('AddNoteUseCase should add note to repository', () async {
    final note = Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now());

    when(repository.add(note)).thenAnswer((_) async => note);

    final result = await useCase(note);

    expect(result, note);
    verify(repository.add(note)).called(1);
  });

  test('AddNoteUseCase should throw when adding a note that already exists', () async {
    final note = Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now());

    when(repository.add(note)).thenThrow(Exception('Note already exists'));

    expect(() async => await useCase(note), throwsA(isA<Exception>()));
  });
}
