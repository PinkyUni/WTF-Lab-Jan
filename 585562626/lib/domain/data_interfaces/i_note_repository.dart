import '../../../shared/entities/category.dart';
import '../../../shared/entities/note.dart';
import '../../../shared/entities/note_with_category.dart';
import '../../../shared/entities/tag.dart';

abstract class INoteRepository {
  Future<List<Note>> fetchNotes(Category category);

  Future<List<Note>> fetchStarredNotes(Category category);

  Future<int> addNote(int categoryId, Note note);

  Future<int> updateNote(Note note);

  Future<bool> updateNotes(Iterable<Note> notes);

  Future<int> updateNoteCategory(Category category, Note note);

  Future<bool> deleteNotes(List<Note> notes);

  Future<void> addTag(Tag tag);

  Future<List<Tag>> fetchTags();

  Future<List<NoteWithCategory>> fetchNotesWithCategories();
}
