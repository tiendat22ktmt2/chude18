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
        isMax: newValue >= repository.max, // đọc từ repo
        isMin: newValue <= repository.min, // đọc từ repo
      ));
    });

    // Khi người dùng nhấn nút trừ
    on<DecrementPressed>((event, emit) {
      final newValue = repository.decrement();
      emit(state.copyWith(
        value: newValue,
        isMin: newValue <= repository.min, // đọc từ repo
        isMax: newValue >= repository.max, // đọc từ repo
      ));
    });

    // Khi người dùng nhấn nút reset
    on<ResetPressed>((event, emit) {
      final newValue = repository.reset(); // giờ sẽ reset về min
      emit(CounterState(
      value: newValue,
      isMin: true,
      isMax: false,
      ));
    });

    // Khi người dùng thay đổi min/max
    on<SetLimitPressed>((event, emit) {
      repository.setLimits(event.min, event.max);

      // Nếu counter hiện tại < min hoặc > max, đưa về giới hạn và emit lại
      emit(CounterState(
        value: repository.value,
        isMin: repository.value == repository.min,
        isMax: repository.value == repository.max,
      ));
    });
  }
}
