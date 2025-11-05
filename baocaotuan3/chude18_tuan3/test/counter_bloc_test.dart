import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chude18_tuan3/bloc/counter_bloc.dart';
import 'package:chude18_tuan3/bloc/counter_event.dart';
import 'package:chude18_tuan3/bloc/counter_state.dart';
import 'package:chude18_tuan3/data/counter_repository.dart';

void main() {
  group('CounterBloc', () {
    late CounterRepository repository;
    late CounterBloc bloc;

    setUp(() {
      repository = CounterRepository();
      bloc = CounterBloc(repository);
    });

    blocTest<CounterBloc, CounterState>(
      'emits [1] when IncrementPressed is added',
      build: () => bloc,
      act: (bloc) => bloc.add(IncrementPressed()),
      expect: () => [const CounterState(value: 1, isMax: false, isMin: false)],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [-1] when DecrementPressed is added',
      build: () => bloc,
      act: (bloc) => bloc.add(DecrementPressed()),
      expect: () => [const CounterState(value: -1, isMax: false, isMin: false)],
    );
  });
}
