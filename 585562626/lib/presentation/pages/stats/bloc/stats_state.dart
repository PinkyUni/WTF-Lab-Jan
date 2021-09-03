import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/stats_data.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object?> get props => [];
}

class FetchingDataState extends StatsState {
  const FetchingDataState();
}

class InitialDataState extends FetchedNotesState {
  const InitialDataState() : super(data: const StatsData.empty());
}

class FetchedNotesState extends StatsState {
  final StatsData data;

  const FetchedNotesState({required this.data});

  @override
  List<Object?> get props => [data];
}
