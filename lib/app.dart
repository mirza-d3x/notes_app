import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/notes_cubit.dart';
import 'package:note_app/repositories/note_repositories.dart';
import 'package:note_app/screens/login_scree.dart';

class CollaborativeNotesApp extends StatelessWidget {
  const CollaborativeNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NoteRepository(),
      child: BlocProvider(
        create: (context) => NoteCubit( noteRepository: RepositoryProvider.of<NoteRepository>(context),),
        child: MaterialApp(
          title: 'Collaborative Notes',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
