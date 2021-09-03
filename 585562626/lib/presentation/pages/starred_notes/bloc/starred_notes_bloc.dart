import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/category.dart';
import '../../../../../domain/entities/note.dart';
import '../../../../../domain/usecases/notes_usecase.dart';
import 'starred_notes_event.dart';
import 'starred_notes_state.dart';

class StarredNotesBloc extends Bloc<StarredNotesEvent, StarredNotesState> {
  final NotesUseCase notesUseCase;
  final Category category;

  StarredNotesBloc({
    StarredNotesState initialState = const InitialStarredNotesState(),
    required this.notesUseCase,
    required this.category,
  }) : super(initialState) {
    add(const FetchStarredNotesEvent());
  }

  @override
  Stream<StarredNotesState> mapEventToState(StarredNotesEvent event) async* {
    if (event is FetchStarredNotesEvent) {
      yield const FetchingStarredNotesState();
      yield await _fetchStarredNotes();
    } else if (event is DeleteFromStarredNotesEvent) {
      final currentState = state as FetchedStarredNotesState;
      final list = List<Note>.from(currentState.notes);
      list.remove(event.note);
      yield FetchedStarredNotesState(list, switchedStar: true);
      final result = await notesUseCase.updateNotes([event.note.copyWith(hasStar: false)]);
      if (!result) {
        yield await _fetchStarredNotes();
      }
    }
  }

  Future<StarredNotesState> _fetchStarredNotes({bool switchedStar = false}) async {
    final notes = await notesUseCase.fetchStarredNotes(category);
    if (state is FetchedStarredNotesState) {
      return (state as FetchedStarredNotesState).copyWith(notes: notes);
    } else {
      return FetchedStarredNotesState(notes);
    }
  }
}
