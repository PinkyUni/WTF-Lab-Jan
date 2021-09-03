import 'package:equatable/equatable.dart';

import '../../../../../shared/entities/category.dart';
import '../../../../../shared/entities/tag.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotesEvent extends TimelineEvent {
  const FetchNotesEvent();
}

class ApplyFilterEvent extends TimelineEvent {
  final List<Category> selectedCategories;
  final List<Tag> selectedTags;
  final String query;

  ApplyFilterEvent(this.selectedCategories, this.selectedTags, this.query);

  @override
  List<Object?> get props => [selectedTags, selectedCategories, query];
}
