import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/notes_cubit.dart';
import 'package:note_app/screens/note_edit_screen.dart';
import '../models/note.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.content),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NoteEditorScreen(username: note.activeUsers.first),
          ),
        );
      },
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          context.read<NoteCubit>().deleteNote(note.id);
        },
      ),
    );
  }
}
