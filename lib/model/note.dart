import 'dart:io';
import 'dart:ui';
class Note {
  final String id;
  final String title;
  final String content;
  final File? image;
  final Color color;
  bool isFavorite;
  DateTime lastModified;

  Note({required this.id, required this.title, required this.content, this.image, required this.color, this.isFavorite = false, required this.lastModified});
}
