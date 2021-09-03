import '../../../domain/entities/category.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/entities/note_with_category.dart';
import '../../../domain/entities/tag.dart';
import '../data_interfaces/i_note_repository.dart';

class NotesUseCase {
  final INoteRepository noteRepository;

  NotesUseCase(this.noteRepository);

  Future<List<Note>> fetchNotes(Category category) async {
    return noteRepository.fetchNotes(category);
  }

  Future<List<Note>> fetchStarredNotes(Category category) async {
    return noteRepository.fetchStarredNotes(category);
  }

  Future<int> addNote(int categoryId, Note note) async {
    return noteRepository.addNote(categoryId, note);
  }

  Future<bool> updateNotes(Iterable<Note> notes) async {
    return noteRepository.updateNotes(notes);
  }

  Future<bool> deleteNotes(List<Note> notes) async {
    return noteRepository.deleteNotes(notes);
  }

  Future<int> updateNote(Note note) async {
    return noteRepository.updateNote(note);
  }

  Future<int> updateNoteCategory(Category category, Note note) async {
    return noteRepository.updateNoteCategory(category, note);
  }

  Future<void> addTag(Tag tag) async {
    await noteRepository.addTag(tag);
  }

  Future<List<Tag>> fetchTags() async {
    return noteRepository.fetchTags();
  }

  Future<List<NoteWithCategory>> fetchNotesWithCategories() async {
    return noteRepository.fetchNotesWithCategories();
  }
}
