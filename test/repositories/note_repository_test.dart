// ignore_for_file: subtype_of_sealed_class, must_be_immutable

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/repositories/note_repositories.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  group('NoteRepository', () {
    late NoteRepository noteRepository;
    late MockFirestore mockFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockDocumentSnapshot mockDocumentSnapshot;

    setUp(() {
      mockFirestore = MockFirestore();
      mockCollectionReference = MockCollectionReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockDocumentSnapshot = MockDocumentSnapshot();

      noteRepository = NoteRepository();
    });

    test('getNotes returns a list of notes', () async {
      when(mockFirestore.collection("any")).thenReturn(
          mockCollectionReference as CollectionReference<Map<String, dynamic>>);
      when(mockCollectionReference.get())
          .thenAnswer((_) async => mockQuerySnapshot);
      // when(mockQuerySnapshot.docs).thenReturn([mockDocumentSnapshot]);
      when(mockDocumentSnapshot.data()).thenReturn({
        'id': '1',
        'title': 'Test Note',
        'content': 'This is a test note',
        'activeUsers': ['user1'],
      });

      final notes = await noteRepository.getNotes();
      expect(notes.length, 1);
      expect(notes[0].id, '1');
    });

  });
}
