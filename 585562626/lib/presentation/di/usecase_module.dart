import '../../../domain/usecases/categories_usecase.dart';
import '../../../domain/usecases/notes_usecase.dart';
import '../../../domain/usecases/settings_usecase.dart';
import '../../../domain/usecases/stats_usecase.dart';
import 'injector.dart';

void initUseCaseModule() {
  injector.registerSingleton<CategoriesUseCase>(CategoriesUseCase(injector.get()));
  injector.registerSingleton<NotesUseCase>(NotesUseCase(injector.get()));
  injector.registerSingleton<SettingsUseCase>(SettingsUseCase(injector.get()));
  injector.registerSingleton<StatsUseCase>(StatsUseCase(injector.get(), injector.get()));
}
