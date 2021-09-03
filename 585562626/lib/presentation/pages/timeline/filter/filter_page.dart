import 'package:flutter/material.dart';
import '../../../../presentation/pages/timeline/filter/filter_content.dart';

class FilterPage extends StatelessWidget {
  static const routeName = '/timeline_filter';

  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FilterContent();
  }
}
