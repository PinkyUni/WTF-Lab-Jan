import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/pages/categories/categories_page.dart';
import '../../../presentation/pages/home/bloc/bloc.dart';
import '../../../presentation/pages/settings/settings_page.dart';
import '../../di/injector.dart';
import '../stats/stats_page.dart';
import '../timeline/timeline_page.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final HomeBloc _bloc = injector.get();
  final _tabs = const [
    CategoriesPage(),
    Center(child: Text('2')),
    TimelinePage(),
    StatsPage(),
  ];

  void _selectTab(int tab) {
    _bloc.add(TabSelectedEvent(index: tab));
  }

  Widget _bottomNavigationBar() {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _bloc,
      builder: (context, state) {
        return BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.indigo,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Daily',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.timeline_outlined),
              label: 'Timeline',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Stats',
            ),
          ],
          onTap: _selectTab,
          currentIndex: state.index,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cool Notes', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(SettingsPage.routeName),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (context, state) {
          return _tabs[state.index];
        },
      ),
    );
  }
}
