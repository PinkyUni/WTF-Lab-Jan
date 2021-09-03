import '../../../domain/entities/category.dart';
import '../data_interfaces/i_category_repository.dart';

class CategoriesUseCase {
  final ICategoryRepository categoryRepository;

  CategoriesUseCase(this.categoryRepository);

  Future<int> countCategories() async {
    return categoryRepository.countCategories();
  }

  Future<List<Category>> fetchCategories() async {
    return categoryRepository.fetchCategories();
  }

  Future<List<Category>> fetchDefaultCategories() async {
    return categoryRepository.fetchCategories(isDefault: true);
  }

  Future<int> addCategory(Category category) async {
    return categoryRepository.addCategory(category);
  }

  Future<int> updateCategory(Category category) async {
    return categoryRepository.updateCategory(category);
  }

  Future<int> deleteCategory(Category category) async {
    return categoryRepository.deleteCategory(category);
  }
}
