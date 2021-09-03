import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../di/injector.dart';
import '../home/home_page.dart';
import 'bloc/bloc.dart';

class LockPage extends StatefulWidget {
  const LockPage({Key? key}) : super(key: key);

  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  final _localAuthentication = LocalAuthentication();
  final LockBloc _bloc = injector.get();

  @override
  void initState() {
    super.initState();
    _authenticateMe();
  }

  Future<void> _authenticateMe() async {
    try {
      final result = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to enter the app',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      );
      _bloc.add(AuthenticateEvent(isAuthenticated: result));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockBloc, LockState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state.authenticated == true) {
          Navigator.of(context).popAndPushNamed(HomePage.routeName);
        } else if (state.authenticated == false) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop', true);
        } else {
          _authenticateMe();
        }
      },
      child: Container(
        color: Theme.of(context).accentColor,
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Image.asset('assets/lock.png'),
        ),
      ),
    );
  }
}
