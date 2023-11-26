import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../model/note.dart';

class EditNotePage extends StatefulWidget {
  final Note note;

  EditNotePage(this.note);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late Color _selectedColor;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _image=widget.note.image;
    _selectedColor = widget.note.color;
    _isFavorite = widget.note.isFavorite;
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Note',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _titleController,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(labelText: 'Content'),
                      maxLines: null,
                      expands: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, spreadRadius: 1),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_image != null)
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Image.file(_image!),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            setState(() {
                                              _image = null;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Retake'),
                                          onPressed: () {
                                            _getImage();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Image.file(_image!, height: 50, width: 50),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                          _isFavorite ? Icons.star : Icons.star_border,
                            color: _isFavorite ? Colors.yellow : Colors.black,
                          ), // Star icon
                                onPressed: () {
                                  setState(() {
                                    _isFavorite = !_isFavorite; // Toggle the favorite status
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.camera),
                                onPressed: _getImage,
                              ),
                              DropdownButton<Color>(
                                value: _selectedColor,
                                items: <Color>[
                                  Colors.red,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.tealAccent
                                ].map<DropdownMenuItem<Color>>((Color value) {
                                  return DropdownMenuItem<Color>(
                                    value: value,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Color? newValue) {
                                  setState(() {
                                    _selectedColor = newValue!;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final updatedNote = Note(
                          id: widget.note.id,
                          title: _titleController.text,
                          content: _contentController.text,
                          image: _image,
                          color: _selectedColor,
                          isFavorite: _isFavorite,
                          lastModified: DateTime.now(),
                        );
                        final notesBloc = context.read<NotesBloc>();
                        notesBloc.add(EditNote(updatedNote));
                        notesBloc.add(FetchNotes());
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update Note'),
                  ),
                ],
              ),
          ),
          ),
        ),
      );
    }
  }
