import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:znotes/bloc/notes_event.dart';
import 'package:znotes/model/note.dart';

void main() {
  Note n1 = Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now());
  group('AddNote', () {
    test('supports value comparisons', () {
      expect(AddNote(n1), AddNote(n1));
    });
  });

  group('DeleteNote', () {
    test('supports value comparisons', () {
      expect(DeleteNote('id'), DeleteNote('id'));
    });
  });

  group('EditNote', () {
    test('supports value comparisons', () {
      expect(EditNote(n1), EditNote(n1));
    });
  });

  group('FetchNotes', () {
    test('supports value comparisons', () {
      expect(FetchNotes(), FetchNotes());
    });
  });
}
