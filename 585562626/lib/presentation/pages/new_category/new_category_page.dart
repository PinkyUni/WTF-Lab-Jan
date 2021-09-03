import 'package:flutter/material.dart';
import '../../../../domain/entities/category.dart';
import '../../../presentation/pages/new_category/new_category_content.dart';

class NewCategoryArguments {
  final Category? category;

  NewCategoryArguments(this.category);
}

class NewCategoryPage extends StatelessWidget {
  final Category? editCategory;
  static const routeName = '/new_category';

  const NewCategoryPage({Key? key, this.editCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewCategoryContent(editCategory: editCategory,);
  }
}
