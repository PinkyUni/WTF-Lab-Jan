import '../../../data/database/database_provider.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/note_repository.dart';
import '../../../data/repositories/preferences_repository.dart';
import '../../../domain/data_interfaces/i_category_repository.dart';
import '../../../domain/data_interfaces/i_note_repository.dart';
import '../../../domain/data_interfaces/i_preferences_repository.dart';
import 'injector.dart';

void initRepositoryModule() {
  injector.registerSingleton<DbProvider>(DbProvider());
  injector.registerSingleton<ICategoryRepository>(CategoryRepository(injector.get()));
  injector.registerSingleton<INoteRepository>(NoteRepository(injector.get()));
  injector.registerSingleton<IPreferencesRepository>(PreferencesRepository());2
}
