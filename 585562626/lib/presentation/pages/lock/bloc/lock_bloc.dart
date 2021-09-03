import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class LockBloc extends Bloc<LockEvent, LockState> {
  LockBloc({LockState initialState = const LockState()}) : super(initialState);

  @override
  Stream<LockState> mapEventToState(LockEvent event) async* {
    if (event is AuthenticateEvent) {
      yield state.copyWith(authenticated: event.isAuthenticated);
    }
  }
}
