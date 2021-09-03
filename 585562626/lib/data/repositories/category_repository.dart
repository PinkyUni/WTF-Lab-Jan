import 'dart:async';

import '../../../domain/data_interfaces/i_category_repository.dart';
import '../../../domain/entities/category.dart';
import '../database/database_provider.dart';
import '../mappers/category_mapper.dart';

class CategoryRepository extends ICategoryRepository {
  final DbProvider _dbProvider;

  CategoryRepository(this._dbProvider);

  @override
  Future<int> countCategories() async {
    return _dbProvider.countCategories();
  }

  @override
  Future<List<Category>> fetchCategories({bool isDefault = false}) async {
    final dbCategories = await _dbProvider.categories(isDefault: isDefault);
    return dbCategories.map(CategoryMapper.fromDb).toList();
  }

  @override
  Future<int> addCategory(Category category) async {
    return _dbProvider.insertCategory(CategoryMapper.toDb(category));
  }

  @override
  Future<int> updateCategory(Category category) async {
    return _dbProvider.updateCategory(CategoryMapper.toDb(category));
  }

  @override
  Future<int> deleteCategory(Category category) async {
    return _dbProvider.deleteCategory(category.id!);
  }
}
