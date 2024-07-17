import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Note>> getNotes() async {
    QuerySnapshot snapshot = await _firestore.collection('notes').get();
    return snapshot.docs
        .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> addNote(Note note) {
    return _firestore.collection('notes').add(note.toJson());
  }

  Future<void> updateNote(Note note) {
    return _firestore.collection('notes').doc(note.id).update(note.toJson());
  }

  Future<void> deleteNote(String noteId) {
    return _firestore.collection('notes').doc(noteId).delete();
  }
}
