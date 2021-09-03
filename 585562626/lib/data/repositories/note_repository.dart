import '../../../domain/data_interfaces/i_note_repository.dart';
import '../../../shared/entities/category.dart';
import '../../../shared/entities/note.dart';
import '../../../shared/entities/note_with_category.dart';
import '../../../shared/entities/tag.dart';
import '../database/database_provider.dart';
import '../mappers/note_mapper.dart';
import '../mappers/note_with_category_mapper.dart';
import '../mappers/tag_mapper.dart';

class NoteRepository extends INoteRepository {
  final DbProvider _dbProvider;

  NoteRepository(this._dbProvider);

  @override
  Future<List<Note>> fetchNotes(Category category) async {
    final dbNotes = await _dbProvider.notesFor(category);
    return dbNotes.map(NoteMapper.fromDb).toList();
  }

  @override
  Future<List<Note>> fetchStarredNotes(Category category) async {
    final dbNotes = await _dbProvider.starredNotes(category);
    return dbNotes.map(NoteMapper.fromDb).toList();
  }

  @override
  Future<int> addNote(int categoryId, Note note) async {
    return _dbProvider.insertNote(categoryId, NoteMapper.toDb(note));
  }

  @override
  Future<bool> updateNotes(Iterable<Note> notes) async {
    return _dbProvider.updateNotes(notes.map(NoteMapper.toDb).toList());
  }

  @override
  Future<bool> deleteNotes(List<Note> notes) async {
    return _dbProvider.deleteNotes(notes.map(NoteMapper.toDb).toList());
  }

  @override
  Future<int> updateNote(Note note) async {
    return _dbProvider.updateNote(NoteMapper.toDb(note));
  }

  @override
  Future<int> updateNoteCategory(Category category, Note note) async {
    return _dbProvider.updateNoteCategory(category.id!, note.id!);
  }

  @override
  Future<void> addTag(Tag tag) async {
    await _dbProvider.insertTag(TagMapper.toDb(tag));
  }

  @override
  Future<List<Tag>> fetchTags() async {
    final dbTags = await _dbProvider.tags();
    return dbTags.map(TagMapper.fromDb).toList();
  }

  @override
  Future<List<NoteWithCategory>> fetchNotesWithCategories() async {
    final dbTags = await _dbProvider.notesWithCategories();
    return dbTags.map(NoteWithCategoryMapper.fromDb).toList();
  }
}
