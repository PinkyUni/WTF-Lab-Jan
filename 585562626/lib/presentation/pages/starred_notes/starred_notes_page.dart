import 'package:flutter/material.dart';
import '../../../../domain/entities/category.dart';
import 'starred_notes_content.dart';

class StarredNotesArguments {
  final Category category;

  StarredNotesArguments({required this.category});
}

class StarredNotesPage extends StatelessWidget {
  final Category category;

  static const routeName = '/starred_notes';

  const StarredNotesPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StarredNotesContent(category: category);
  }
}
