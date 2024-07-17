import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:note_app/cubit/notes_cubit.dart';
import 'package:note_app/repositories/note_repositories.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  group('NoteCubit', () {
    late NoteCubit noteCubit;
    late MockNoteRepository mockNoteRepository;

    setUp(() {
      mockNoteRepository = MockNoteRepository();
      noteCubit = NoteCubit(noteRepository: mockNoteRepository);
    });

    tearDown(() {
      noteCubit.close();
    });

    test('initial state is NoteInitial', () {
      expect(noteCubit.state, NoteInitial());
    });

    blocTest<NoteCubit, NoteState>(
      'emits [NoteLoading, NoteLoaded] when loadNotes is called',
      build: () {
        when(mockNoteRepository.getNotes()).thenAnswer((_) async => []);
        return noteCubit;
      },
      act: (cubit) => cubit.loadNotes(),
      expect: () => [
        NoteLoading(),
        NoteLoaded([]),
      ],
    );

    // Add more cubit tests as needed
  });
}
