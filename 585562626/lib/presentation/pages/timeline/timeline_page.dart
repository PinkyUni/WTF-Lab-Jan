import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/tag.dart';
import '../../../presentation/pages/timeline/bloc/timeline_bloc.dart';
import '../../../presentation/pages/timeline/filter/filter_page.dart';
import '../../di/injector.dart';
import '../../widgets/note_item.dart';
import 'bloc/bloc.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> with SingleTickerProviderStateMixin {
  final TimelineBloc _bloc = injector.get();
  late final AnimationController _animationController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    switch (_scrollController.position.userScrollDirection) {
      case ScrollDirection.idle:
        break;
      case ScrollDirection.forward:
        _animationController.forward();
        break;
      case ScrollDirection.reverse:
        _animationController.reverse();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      bloc: _bloc,
      builder: (context, state) {
        final content;
        if (state is FetchedNotesState) {
          content = state.filteredNotes.isEmpty
              ? Center(
                  child: Text('Nothing found.', style: Theme.of(context).textTheme.bodyText2),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = state.filteredNotes[index];
                    return NoteItem(note: note.note, category: note.category);
                  },
                );
        } else {
          content = Center(
            child: CircularProgressIndicator(color: Theme.of(context).accentColor),
          );
        }
        return Scaffold(
          body: content,
          floatingActionButton: RotationTransition(
            turns: _animationController,
            child: ScaleTransition(
              scale: _animationController,
              child: FloatingActionButton(
                heroTag: 'filter_hero',
                child: const Icon(Icons.filter_list),
                onPressed: _navigateToFilter,
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToFilter() async {
    final result = await Navigator.of(context).pushNamed(FilterPage.routeName);
    if (result != null && result is FilterResult) {
      _bloc.add(ApplyFilterEvent(result.categories, result.tags, result.query));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class FilterResult {
  final String query;
  final List<Tag> tags;
  final List<Category> categories;

  FilterResult({required this.query, required this.tags, required this.categories});
}
