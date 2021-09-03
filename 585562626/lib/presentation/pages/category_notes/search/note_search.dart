import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/note.dart';
import '../../../../../domain/entities/tag.dart';
import '../../../di/injector.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../../widgets/note_item.dart';
import 'bloc/bloc.dart';

class NoteSearch extends SearchDelegate<String> {
  final SearchBloc bloc = injector.get();

  NoteSearch(BuildContext context, List<Note> notes, List<Tag> tags)
      : super(
          searchFieldStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: Theme.of(context).textTheme.bodyText2!.fontSize! + 2,
              ),
        ) {
    bloc.add(InitStateEvent(notes, tags));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Platform.isIOS
          ? Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color)
          : Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Container();

  Widget _tags(BuildContext context, SearchState state) {
    return Container(
      padding: const EdgeInsets.all(Insets.small),
      child: Wrap(
        spacing: Insets.small,
        children: state.tags
            .map(
              (tag) => GestureDetector(
                onTap: () => bloc.add(TagTapEvent(tag)),
                child: Chip(
                  label: Text(
                    tag.name,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Theme.of(context).accentIconTheme.color,
                        ),
                  ),
                  backgroundColor: state.selectedTags.contains(tag)
                      ? Theme.of(context).accentColor
                      : darkAccentColor,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _content(SearchState state) {
    if (state.query.isNotEmpty || state.selectedTags.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.filteredNotes.length,
        itemBuilder: (context, index) => NoteItem(note: state.filteredNotes[index]),
      );
    } else {
      return Expanded(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.3,
            child: Image.asset('assets/search.png'),
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(QueryChangedEvent(query));
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_tags(context, state), _content(state)],
        );
      },
    );
  }
}
