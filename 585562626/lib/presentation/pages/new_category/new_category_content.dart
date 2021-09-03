import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/entities/category.dart';
import '../../di/injector.dart';
import '../../utils/constants.dart';
import '../../widgets/category_item.dart';
import 'bloc/bloc.dart';

class NewCategoryContent extends StatefulWidget {
  final Category? editCategory;

  NewCategoryContent({required this.editCategory});

  @override
  _NewCategoryContentState createState() => _NewCategoryContentState();
}

class _NewCategoryContentState extends State<NewCategoryContent> {
  final _textController = TextEditingController();
  late final NewCategoryBloc _bloc = injector.get(param1: widget.editCategory);

  void _addCategory() {
    _bloc.add(const NewCategorySubmitted());
  }

  Widget _textInput(UpdateCategoryState state) {
    return Padding(
      padding: const EdgeInsets.only(top: Insets.medium, right: Insets.large, left: Insets.large),
      child: TextField(
        textInputAction: TextInputAction.done,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize! + 2,
            ),
        decoration: InputDecoration(
          hintText: 'Type the name...',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          errorText: state.error == NameValidationError.empty ? 'Name can\'t be empty' : null,
        ),
        controller: _textController,
        onChanged: (text) => _bloc.add(NameChangedEvent(text)),
      ),
    );
  }

  Widget _gridContent(UpdateCategoryState state) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: Insets.medium, horizontal: Insets.large),
        crossAxisCount: 3,
        children: state.defaultCategories
            .map(
              (category) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(CornerRadius.card),
                  border: Border.all(
                    width: 2,
                    color: state.selectedCategory?.image == category.image
                        ? Theme.of(context).accentColor
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: state.selectedCategory?.image == category.image
                      ? Theme.of(context).accentColor.withAlpha(Alpha.alpha50)
                      : null,
                ),
                child: CategoryItem(
                  category: category,
                  onTap: (category) => _bloc.add(CategoryChanged(category)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewCategoryBloc, NewCategoryState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UpdateCategoryState) {
          switch (state.result) {
            case SubmissionResult.success:
              Navigator.of(context).pop(state.selectedCategory);
              break;
            case SubmissionResult.failure:
              if (state.selectedCategory == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Specify the icon for new category'),
                  ),
                );
              }
              break;
            default:
          }
          ;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Platform.isIOS ? const Icon(Icons.arrow_back_ios) : const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'New Category',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: BlocBuilder<NewCategoryBloc, NewCategoryState>(
          bloc: _bloc,
          builder: (_, state) {
            if (state is FetchingDefaultCategoriesState) {
              return Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor));
            }
            final currentState = state as UpdateCategoryState;
            if (_textController.text != currentState.name) {
              _textController.text = currentState.name ?? '';
            }
            return Column(
              children: [_textInput(currentState), _gridContent(currentState)],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'new_category',
          onPressed: _addCategory,
          child: const Icon(Icons.done),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
