import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/counter_repository.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository repository;

  CounterBloc(this.repository)
      : super(CounterState(
          value: repository.value,
          isMin: repository.value == repository.min,
          isMax: repository.value == repository.max,
        )) {

    _initializeState();

    on<IncrementPressed>((event, emit) async {
      final newValue = repository.increment();
      emit(state.copyWith(
        value: newValue,
        isMax: newValue >= repository.max,
        isMin: newValue <= repository.min,
      ));
      await repository.saveToStorage();
    });

    on<DecrementPressed>((event, emit) async {
      final newValue = repository.decrement();
      emit(state.copyWith(
        value: newValue,
        isMin: newValue <= repository.min,
        isMax: newValue >= repository.max,
      ));
      await repository.saveToStorage();
    });

    on<ResetPressed>((event, emit) async {
      final newValue = repository.reset();
      emit(CounterState(
        value: newValue,
        isMin: true,
        isMax: false,
      ));
      await repository.saveToStorage();
    });

    on<SetLimitPressed>((event, emit) async {
      await repository.setLimits(event.min, event.max);
      emit(CounterState(
        value: repository.value,
        isMin: repository.value == repository.min,
        isMax: repository.value == repository.max,
      ));
    });
  }


  void _initializeState() async {
    await Future.delayed(Duration.zero); 
    emit(CounterState(
      value: repository.value,
      isMin: repository.value == repository.min,
      isMax: repository.value == repository.max,
    ));
  }
}
