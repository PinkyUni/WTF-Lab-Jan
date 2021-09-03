import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/usecases/stats_usecase.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsUseCase statsUseCase;

  StatsBloc({
    StatsState initialState = const InitialDataState(),
    required this.statsUseCase,
  }) : super(initialState) {
    add(const FetchDataEvent());
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is FetchDataEvent) {
      yield const FetchingDataState();
      final data = await statsUseCase.generateStats();
      yield FetchedNotesState(data: data);
    }
  }
}
