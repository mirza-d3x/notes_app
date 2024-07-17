import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/repositories/note_repositories.dart';
import '../models/note.dart';

part 'notes_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository noteRepository;

  NoteCubit({required this.noteRepository}) : super(NoteInitial());

  void loadNotes() async {
    emit(NoteLoading());
    try {
      final notes = await noteRepository.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError("Failed to load notes."));
    }
  }

  void addNote(Note note) async {
    try {
      await noteRepository.addNote(note);
      loadNotes();
    } catch (e) {
      emit(NoteError("Failed to add note."));
    }
  }

  void updateNote(Note note) async {
    try {
      await noteRepository.updateNote(note);
      loadNotes();
    } catch (e) {
      emit(NoteError("Failed to update note."));
    }
  }

  void deleteNote(String noteId) async {
    try {
      await noteRepository.deleteNote(noteId);
      loadNotes();
    } catch (e) {
      emit(NoteError("Failed to delete note."));
    }
  }
}
