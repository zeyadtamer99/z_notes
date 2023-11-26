import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znotes/bloc/notes_bloc.dart';
import 'package:znotes/bloc/notes_event.dart';
import 'package:znotes/model/note.dart';
import 'package:znotes/pages/notes_page.dart';

import '../repositories/mock_notes_repository.dart';

void main() {
  final notes = [Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now())];
  final bloc = MockNotesBloc();

  whenListen(bloc, Stream.fromIterable([NotesLoaded(notes)]));

  testWidgets('NotesPage should display notes when state is NotesLoaded', (WidgetTester tester) async {
    final notes = [Note(id: '1', title: 'Test', content: 'Test content', color: Colors.blue, lastModified: DateTime.now())];
    final bloc = MockNotesBloc();

    whenListen(bloc, Stream.fromIterable([NotesLoaded(notes)]));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<NotesBloc>(
        create: (context) => bloc,
        child: NotesPage(),
      ),
    ));

    expect(find.text('Test'), findsOneWidget);
  });
}
