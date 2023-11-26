import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:znotes/bloc/notes_bloc.dart';
import 'package:znotes/main.dart';
import 'package:znotes/model/note.dart';

import 'repositories/mock_notes_repository.dart';

void main() {
  testWidgets('Notes are displayed correctly', (WidgetTester tester) async {
    final repository = MockNotesRepository();
    final note = Note(id: '1', title: 'Test Note', content: 'This is a test note.', color: Colors.blue, lastModified: DateTime.now());
    when(repository.fetch()).thenAnswer((_) async => [note]);
    await tester.pumpWidget(
      BlocProvider(
        create: (context) => NotesBloc(repository),
        child: MyApp(),
      ),
    );
    await tester.pump();
    final titleFinder = find.text('Test Note');
    final contentFinder = find.text('This is a test note.');
    expect(titleFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
