import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/utils/utils.dart';
import '../../presentation/pages/category_notes/category_notes_page.dart';
import '../../presentation/pages/new_category/new_category_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../presentation/pages/starred_notes/starred_notes_page.dart';
import '../../presentation/pages/timeline/filter/filter_page.dart';
import '../di/injector.dart';
import '../pages/home/home_page.dart';
import '../pages/lock/lock_page.dart';
import '../pages/settings/bloc/bloc.dart';
import '../utils/themes.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final SettingsBloc _bloc = injector.get();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _bloc,
      buildWhen: (previousState, state) {
        var shouldRebuild = false;
        if (previousState is MainSettingsState && state is MainSettingsState) {
          shouldRebuild = previousState.isDarkMode != state.isDarkMode ||
              previousState.fontSize != state.fontSize;
        }
        return previousState.runtimeType != state.runtimeType || shouldRebuild;
      },
      builder: (_, state) {
        if (state is InitialSettingsState) {
          return Container(color: lightTheme().primaryColor);
        }
        state as MainSettingsState;
        return MaterialApp(
          title: 'Cool Notes',
          theme: state.isDarkMode
              ? darkTheme(fontSizeRatio: state.fontSize.fontRatio())
              : lightTheme(fontSizeRatio: state.fontSize.fontRatio()),
          home: state.showBiometricsDialog ? const LockPage() : const HomePage(),
          onGenerateRoute: (settings) {
            Route pageRoute(Widget destination) => MaterialPageRoute(builder: (_) => destination);
            switch (settings.name) {
              case HomePage.routeName:
                return pageRoute(const HomePage());
              case SettingsPage.routeName:
                return pageRoute(const SettingsPage());
              case CategoryNotesPage.routeName:
                final args = settings.arguments as CategoryNotesArguments;
                return pageRoute(
                  CategoryNotesPage(category: args.category),
                );
              case StarredNotesPage.routeName:
                final args = settings.arguments as StarredNotesArguments;
                return pageRoute(
                  StarredNotesPage(category: args.category),
                );
              case NewCategoryPage.routeName:
                final args = settings.arguments as NewCategoryArguments?;
                return pageRoute(NewCategoryPage(editCategory: args?.category));
              case FilterPage.routeName:
                return pageRoute(const FilterPage());
            }
          },
        );
      },
    );
  }
}
