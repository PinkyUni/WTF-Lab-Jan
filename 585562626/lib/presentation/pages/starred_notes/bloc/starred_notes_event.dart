import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/note.dart';

abstract class StarredNotesEvent extends Equatable {
  const StarredNotesEvent();

  @override
  List<Object?> get props => [];
}

class FetchStarredNotesEvent extends StarredNotesEvent {
  const FetchStarredNotesEvent();
}

class DeleteFromStarredNotesEvent extends StarredNotesEvent {
  final Note note;

  DeleteFromStarredNotesEvent(this.note);

  @override
  List<Object?> get props => [note];
}
