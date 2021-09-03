import '../../../domain/entities/category.dart';
import '../pages/categories/bloc/bloc.dart';
import '../pages/category_notes/bloc/category_notes_bloc.dart';
import '../pages/category_notes/search/bloc/search_bloc.dart';
import '../pages/home/bloc/bloc.dart';
import '../pages/lock/bloc/lock_bloc.dart';
import '../pages/new_category/bloc/new_category_bloc.dart';
import '../pages/settings/bloc/bloc.dart';
import '../pages/starred_notes/bloc/starred_notes_bloc.dart';
import '../pages/stats/bloc/bloc.dart';
import '../pages/timeline/bloc/timeline_bloc.dart';
import '../pages/timeline/filter/bloc/filter_bloc.dart';
import 'injector.dart';

void initBlocModule() {
  injector.registerFactory<CategoriesBloc>(() => CategoriesBloc(categoriesUseCase: injector.get()));
  injector.registerFactoryParam<CategoryNotesBloc, Category, Object?>(
    (category, _) => CategoryNotesBloc(
      category: category,
      notesUseCase: injector.get(),
      categoriesUseCase: injector.get(),
      settingsUseCase: injector.get(),
    ),
  );
  injector.registerFactory<SearchBloc>(() => SearchBloc());
  injector.registerFactory<HomeBloc>(() => HomeBloc());
  injector.registerFactory<LockBloc>(() => LockBloc());
  injector.registerFactoryParam<NewCategoryBloc, Category?, Object?>(
    (category, _) => NewCategoryBloc(
      editCategory: category,
      categoriesUseCase: injector.get(),
    ),
  );
  injector.registerSingleton<SettingsBloc>(SettingsBloc(settingsUseCase: injector.get()));
  injector.registerFactoryParam<StarredNotesBloc, Category, Object?>(
    (category, _) => StarredNotesBloc(
      category: category,
      notesUseCase: injector.get(),
    ),
  );
  injector.registerFactory<StatsBloc>(() => StatsBloc(statsUseCase: injector.get()));
  injector.registerFactory<TimelineBloc>(() => TimelineBloc(notesUseCase: injector.get()));
  injector.registerFactory<FilterBloc>(
    () => FilterBloc(
      notesUseCase: injector.get(),
      categoriesUseCase: injector.get(),
    ),
  );
}
