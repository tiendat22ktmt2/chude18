import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/counter_repository.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// BLoC chịu trách nhiệm quản lý toàn bộ business logic
/// của counter: tăng, giảm, reset, và kiểm tra giới hạn.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository repository;

  CounterBloc(this.repository) : super(const CounterState(value: 0)) {
    // Khi người dùng nhấn nút cộng
    on<IncrementPressed>((event, emit) {
      final newValue = repository.increment();
      emit(state.copyWith(
        value: newValue,
        isMax: newValue >= 10, // đạt giới hạn trên
        isMin: false,
      ));
    });

    // Khi người dùng nhấn nút trừ
    on<DecrementPressed>((event, emit) {
      final newValue = repository.decrement();
      emit(state.copyWith(
        value: newValue,
        isMin: newValue <= -5, // đạt giới hạn dưới
        isMax: false,
      ));
    });

    // Khi người dùng nhấn nút reset
    on<ResetPressed>((event, emit) {
      repository.reset(); // ✅ đảm bảo dữ liệu trong repository cũng reset
      emit(const CounterState(
        value: 0,
        isMax: false,
        isMin: false,
      ));
    });
  }
}
