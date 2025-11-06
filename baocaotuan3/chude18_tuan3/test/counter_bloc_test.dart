import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chude18_tuan3/bloc/counter_bloc.dart';
import 'package:chude18_tuan3/bloc/counter_event.dart';
import 'package:chude18_tuan3/bloc/counter_state.dart';
import 'package:chude18_tuan3/data/counter_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CounterBloc', () {

    //Kiểm thử event IncrementPressed
    blocTest<CounterBloc, CounterState>(
      'emits [1] when IncrementPressed is added',
      build: () => CounterBloc(CounterRepository()),
      act: (bloc) => bloc.add(IncrementPressed()),
      expect: () => [
        const CounterState(value: 1, isMax: false, isMin: false),
      ],
    );


    //Kiểm thử event DecrementPressed

    blocTest<CounterBloc, CounterState>(
      'emits [-1] when DecrementPressed is added',
      build: () => CounterBloc(CounterRepository()),
      act: (bloc) => bloc.add(DecrementPressed()),
      expect: () => [
        const CounterState(value: -1, isMax: false, isMin: false),
      ],
    );

    //Kiểm thử event ResetPressed
    blocTest<CounterBloc, CounterState>(
      'resets counter to min value when ResetPressed is added',
      build: () => CounterBloc(CounterRepository()),
      act: (bloc) {
        bloc.add(IncrementPressed());
        bloc.add(IncrementPressed());
        bloc.add(ResetPressed());
      },
      expect: () => [
        const CounterState(value: 1, isMax: false, isMin: false),
        const CounterState(value: 2, isMax: false, isMin: false),
        const CounterState(value: -5, isMax: false, isMin: true),
      ],
    );

    //Kiểm thử SetLimitPressed (thay đổi min/max)
    blocTest<CounterBloc, CounterState>(
      'updates limits when SetLimitPressed is added',
      build: () => CounterBloc(CounterRepository()),
      act: (bloc) => bloc.add(SetLimitPressed(-2, 5)),
      expect: () => [
        const CounterState(value: -2, isMax: false, isMin: true),
      ],
    );
  });
}
