import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/notecard.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import 'add_note_page.dart';

class NotesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesInitial) {
            context.read<NotesBloc>().add(FetchNotes());
          }
        },
        builder: (context, state) {
          if (state is NotesInitial) {
            return Center(child: Text("No notes taken yet!",style: TextStyle(fontSize: 24),));
          } else if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteCard(state.notes[index]);
              },
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  BlocProvider.value(
                  value: BlocProvider.of<NotesBloc>(context),
                  child: AddNotePage(),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
