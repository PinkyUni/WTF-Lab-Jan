import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../shared/entities/category.dart';
import '../../../../../shared/entities/note.dart';
import '../../../../../shared/entities/tag.dart';

class CategoryNotesState extends Equatable {
  final bool isEditingMode;
  final bool startedUpdating;
  final Category category;
  final List<Note> notes;
  final List<Tag> tags;
  final List<Note> selectedNotes;
  final PickedFile? image;
  final String? text;
  final bool showImagePicker;
  final bool showCategoryPicker;
  final bool showSearch;
  final List<Category>? existingCategories;
  final Category? tempCategory;
  final bool isRightAlignmentEnabled;
  final bool isDateTimeModificationEnabled;
  final bool notInsertedForAnotherCategory;

  CategoryNotesState({
    this.isEditingMode = false,
    this.startedUpdating = false,
    required this.category,
    this.notes = const [],
    this.tags = const [],
    this.selectedNotes = const [],
    this.image,
    this.text,
    this.showImagePicker = false,
    this.showCategoryPicker = false,
    this.showSearch = false,
    this.existingCategories,
    this.tempCategory,
    this.isRightAlignmentEnabled = false,
    this.isDateTimeModificationEnabled = false,
    this.notInsertedForAnotherCategory = false,
  });

  CategoryNotesState copyWith({
    bool? isEditingMode,
    bool? startedUpdating,
    List<Note>? notes,
    List<Tag>? tags,
    List<Note>? selectedNotes,
    PickedFile? image,
    String? text,
    bool? showImagePicker,
    bool? showCategoryPicker,
    bool? showSearch,
    bool? textCopiedToClipboard,
    List<Category>? categories,
    Category? tempCategory,
    bool? isRightAlignmentEnabled,
    bool? isDateTimeModificationEnabled,
    bool notInsertedForAnotherCategory = false,
  }) {
    return CategoryNotesState(
      isEditingMode: isEditingMode ?? this.isEditingMode,
      startedUpdating: startedUpdating ?? this.startedUpdating,
      category: category,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      selectedNotes: selectedNotes ?? this.selectedNotes,
      image: image ?? this.image,
      text: text ?? this.text,
      showImagePicker: showImagePicker ?? this.showImagePicker,
      showCategoryPicker: showCategoryPicker ?? this.showCategoryPicker,
      showSearch: showSearch ?? this.showSearch,
      existingCategories: categories ?? existingCategories,
      tempCategory: tempCategory ?? this.tempCategory,
      isRightAlignmentEnabled: isRightAlignmentEnabled ?? this.isRightAlignmentEnabled,
      isDateTimeModificationEnabled:
          isDateTimeModificationEnabled ?? this.isDateTimeModificationEnabled,
      notInsertedForAnotherCategory: notInsertedForAnotherCategory,
    );
  }

  CategoryNotesState resetImage() {
    return CategoryNotesState(
      isEditingMode: isEditingMode,
      startedUpdating: startedUpdating,
      category: category,
      notes: notes,
      selectedNotes: selectedNotes,
      image: null,
      text: text,
      showImagePicker: showImagePicker,
      showCategoryPicker: showCategoryPicker,
    );
  }

  @override
  List<Object?> get props => [
        isEditingMode,
        startedUpdating,
        category,
        notes,
        tags,
        selectedNotes,
        image,
        text,
        showImagePicker,
        showCategoryPicker,
        showSearch,
        tempCategory,
        existingCategories,
      ];
}
