import '../../../domain/entities/category.dart';

abstract class ICategoryRepository {
  Future<int> countCategories();

  Future<List<Category>> fetchCategories({bool isDefault});

  Future<int> addCategory(Category category);

  Future<int> updateCategory(Category category);

  Future<int> deleteCategory(Category category);
}
