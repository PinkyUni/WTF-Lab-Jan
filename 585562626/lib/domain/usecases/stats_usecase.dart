import 'package:collection/collection.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/category_count.dart';
import '../../../domain/entities/note_with_category.dart';
import '../../../domain/entities/stats_data.dart';
import '../data_interfaces/i_category_repository.dart';
import '../data_interfaces/i_note_repository.dart';

class StatsUseCase {
  final ICategoryRepository categoryRepository;
  final INoteRepository noteRepository;

  StatsUseCase(this.categoryRepository, this.noteRepository);

  Future<StatsData> generateStats() async {
    final notes = await noteRepository.fetchNotesWithCategories();
    final categoryAmount = await categoryRepository.countCategories();
    final notesForCategories = groupBy<NoteWithCategory, Category>(
      notes,
      (noteWithCategory) => noteWithCategory.category,
    ).entries.map((e) => CategoryCount(e.key, e.value.length));
    return StatsData(
      notes: notes,
      categoryCountData: notesForCategories,
      categoryAmount: categoryAmount,
    );
  }
}
