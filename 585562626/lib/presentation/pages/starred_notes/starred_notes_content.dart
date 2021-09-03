import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/note.dart';
import '../../di/injector.dart';
import '../../widgets/note_item.dart';
import '../starred_notes/bloc/starred_notes_bloc.dart';
import 'bloc/bloc.dart';

class StarredNotesContent extends StatefulWidget {
  final Category category;

  const StarredNotesContent({Key? key, required this.category}) : super(key: key);

  @override
  _StarredNotesContentState createState() => _StarredNotesContentState();
}

class _StarredNotesContentState extends State<StarredNotesContent> {
  late final StarredNotesBloc _bloc = injector.get(param1: widget.category);
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  AppBar _appBar(FetchedStarredNotesState state) {
    return AppBar(
      leading: IconButton(
        onPressed: () => _onPop(state),
        icon: Platform.isIOS ? const Icon(Icons.arrow_back_ios) : const Icon(Icons.arrow_back),
      ),
      title: Text(
        'Starred notes',
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Note note, FetchedStarredNotesState state) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel'.toUpperCase(),
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
            TextButton(
              onPressed: () {
                _listKey.currentState?.removeItem(
                  state.notes.indexOf(note),
                  (context, animation) => FadeTransition(
                    opacity: animation,
                    child: NoteItem(note: note, isStarred: false),
                  ),
                  duration: const Duration(milliseconds: 300),
                );
                _bloc.add(DeleteFromStarredNotesEvent(note));
                Navigator.pop(context);
              },
              child: Text(
                'Delete'.toUpperCase(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onPop(FetchedStarredNotesState state) async {
    Navigator.pop(context, state.switchedStar);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StarredNotesBloc, StarredNotesState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is FetchingStarredNotesState) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).accentColor),
          );
        }
        final currentState = state as FetchedStarredNotesState;
        return WillPopScope(
          onWillPop: () => _onPop(currentState),
          child: Scaffold(
            appBar: _appBar(currentState),
            body: currentState.notes.isEmpty
                ? Center(
                    child: Text(
                      'Nothing starred yet.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: currentState.notes.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, i, animation) {
                      return NoteItem(
                        note: currentState.notes[i],
                        isStarred: true,
                        onLongPress: (note) {
                          _showDeleteDialog(context, note, state);
                          HapticFeedback.mediumImpact();
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
