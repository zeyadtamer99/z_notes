import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/notecard.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';

class FavoritesPage extends StatelessWidget {
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
            return  Center(child: Text("No notes taken yet!",style: TextStyle(fontSize: 24),));
          } else if (state is NotesLoaded) {
            final favoriteNotes = state.notes.where((note) => note.isFavorite).toList();
            return ListView.builder(
              itemCount: favoriteNotes.length,
              itemBuilder: (context, index) {
                return NoteCard(favoriteNotes[index]);
              },
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
