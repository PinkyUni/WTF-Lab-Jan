import 'package:flutter/material.dart';
import 'home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return HomeContent();
  }
}
