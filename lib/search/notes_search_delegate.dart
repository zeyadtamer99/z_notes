import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/notecard.dart';
import '../bloc/notes_bloc.dart';
import '../model/note.dart';

class NotesSearchDelegate extends SearchDelegate<List<Note>> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, List<Note>.empty(growable: true));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults(context);
  }

  Widget buildSearchResults(BuildContext context) {
    final notesBloc = context.read<NotesBloc>();
    final notesState = notesBloc.state;

    if (notesState is NotesLoaded) {
      final allNotes = notesState.notes;
      final filteredNotes = allNotes
          .where((note) {
        return note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase());
      })
          .toList();

      if (filteredNotes.isEmpty && query.isNotEmpty) {
        // No search results found
        return Center(
          child: Text('No search results found for "$query"'),
        );
      }

      return ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          return NoteCard(filteredNotes[index]);
        },
      );
    } else {
      return Center(child: Text('No Notes Found'));
    }
  }
}
