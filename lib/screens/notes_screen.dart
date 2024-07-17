import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/notes_cubit.dart';
import 'package:note_app/screens/note_edit_screen.dart';
import 'package:note_app/widget/note_item.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    context.read<NoteCubit>().loadNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                    username: username,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: state.notes[index],
                );
              },
            );
          } else if (state is NoteError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: Text('No notes available.'),
          );
        },
      ),
    );
  }
}
