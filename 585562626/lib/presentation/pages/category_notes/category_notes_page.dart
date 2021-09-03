import 'package:flutter/material.dart';
import '../../../../domain/entities/category.dart';
import 'category_notes_content.dart';

class CategoryNotesArguments {
  final Category category;

  CategoryNotesArguments({required this.category});
}

class CategoryNotesPage extends StatelessWidget {
  final Category category;
  static const routeName = '/categoryNotes';

  const CategoryNotesPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryNotesContent(category: category);
  }
}
