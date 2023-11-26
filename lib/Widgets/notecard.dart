import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../model/note.dart';
import '../pages/edit_note_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(note.color);
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    DateTime lastModified = note.lastModified;
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(lastModified);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: BlocProvider.of<NotesBloc>(context),
              child: EditNotePage(note),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          borderOnForeground: true,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    Text(
                      note.content.length > 50
                          ? note.content.substring(0, 50) + '...'
                          : note.content,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    Text(
                      'Last modified: ${formattedDate}',
                      style: TextStyle(fontSize: 12, color: textColor),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          note.isFavorite ? Icons.star : Icons.star_border,
                          color: note.isFavorite ? Colors.yellow : textColor,
                        ),
                        onPressed: () {
                          context
                              .read<NotesBloc>()
                              .add(ToggleFavorite(note.id));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: textColor),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Note'),
                                content: Text(
                                    'Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      context
                                          .read<NotesBloc>()
                                          .add(DeleteNote(note.id));
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          color: note.color,
        ),
      ),
    );
  }
}
