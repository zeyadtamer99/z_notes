import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:znotes/model/note.dart';
import 'package:znotes/use_cases/fetch_notes_use_case.dart';

import '../repositories/mock_notes_repository.dart';

void main() {
  final repository = MockNotesRepository();
  final useCase = FetchNotesUseCase(repository);
  final notes = [Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now())];

  test('FetchNotesUseCase should fetch notes from repository', () async {
  when(repository.fetch()).thenAnswer((_) async => notes);
  final result = await useCase();
  expect(result, notes);
  verify(repository.fetch()).called(1);
});

}
