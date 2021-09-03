import 'package:equatable/equatable.dart';

import 'category_count.dart';
import 'note_with_category.dart';

class StatsData extends Equatable {
  final List<NoteWithCategory> notes;
  final Iterable<CategoryCount> categoryCountData;
  final int categoryAmount;

  const StatsData({
    required this.notes,
    required this.categoryCountData,
    required this.categoryAmount,
  });

  const StatsData.empty()
      : notes = const [],
        categoryCountData = const [],
        categoryAmount = 0;

  @override
  List<Object?> get props => [notes, categoryCountData];
}
